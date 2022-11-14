import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architechture/core/utils/snackbar_message.dart';
import 'package:posts_clean_architechture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architechture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/post_detail_page.dart/delete_dialog_widget.dart';

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
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().ShowSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().ShowErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}
