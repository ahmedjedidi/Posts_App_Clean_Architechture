import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/core/utils/snackbar_message.dart';
import 'package:posts_clean_architechture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/post_detail_page.dart/delete_dialog_widget.dart';

import '../../riverpood/add_delete_update_post/add_delete_update_provider.dart';
import '../../riverpood/add_delete_update_post/add_delete_update_state.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ()=>deleteDialog(context, postId),
      icon: Icon(Icons.delete),
      label: Text("Delete"),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
    );
  }

 void  deleteDialog(BuildContext context,int posId) {
    showDialog(
        context: context,
        builder: (context) {
       return  Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(addDeleteUpdatePostProvider);
              // TODO: implement listener
               ref.listen(
              addDeleteUpdatePostProvider,
              ((previous, next) => {
                    if (next is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().ShowSuccessSnackBar(
                    message: next.message, context: context),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false),
              } else if (next is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop(),
                SnackBarMessage().ShowErrorSnackBar(
                    message: next.message, context: context)
              }
              
                  }));
               if (state is LoadingAddDeleteUpdatePostState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId,ref:ref);
            }
          );
        });
  }
}
