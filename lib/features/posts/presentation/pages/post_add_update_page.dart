import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/core/utils/snackbar_message.dart';
import 'package:posts_clean_architechture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/add_delete_update_post/add_delete_update_provider.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/post_add_update_page/form_widget.dart';

import '../riverpood/add_delete_update_post/add_delete_update_notifier.dart';
import '../riverpood/add_delete_update_post/add_delete_update_state.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() =>
      AppBar(title: Text(isUpdate ? "Edit Post" : "Add Post"));

  Widget _buildBody() {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(addDeleteUpdatePostProvider);
          ref.listen(
              addDeleteUpdatePostProvider,
              ((previous, next) => {
                    if (next is MessageAddDeleteUpdatePostState)
                      {
                        SnackBarMessage().ShowSuccessSnackBar(
                            message: next.message, context: context),
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => PostsPage()),
                            (route) => false)
                      }
                    else if (next is ErrorAddDeleteUpdatePostState)
                      {
                        SnackBarMessage().ShowErrorSnackBar(
                            message: next.message, context: context)
                      }
                  }));

          if (state is LoadingAddDeleteUpdatePostState) {
            return LoadingWidget();
          }
          return FormWidget(
              isUpdate: isUpdate, post: isUpdate ? post : null, ref: ref);
        },
      ),
    ));
  }
}
