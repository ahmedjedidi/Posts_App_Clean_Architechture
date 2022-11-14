import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/posts/posts_state.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/posts_page/posts_list_widget.dart';

import '../riverpood/posts/posts_provider.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text("Posts"));

  Widget _buildBody(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(postsProvider);
          if (state is InitialPostState){
            return LoadingWidget();
          }
          else if (state is LoadedPostState){
            return RefreshIndicator(onRefresh: () => _OnRefresh(ref),child: PostsListWidget(posts:state.posts));
          }
          else if (state is ErrorPostsState){
            return MessageDisplayWidget(message:state.message);
          }
          return LoadingWidget();
        },
      ));
  }

Future<void> _OnRefresh(WidgetRef ref)async {
ref.read(postsProvider.notifier).getPosts();

}

  Widget _buildFloatingButton(BuildContext context){
    return FloatingActionButton(onPressed: (() {
      Navigator.push(context, MaterialPageRoute(builder:(_) => PostAddUpdatePage(isUpdate: false)));
    }),
    child: const Icon(Icons.add),
    );
  }
}