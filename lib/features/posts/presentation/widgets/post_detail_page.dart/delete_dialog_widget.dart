import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/add_delete_update_post/add_delete_update_provider.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  final WidgetRef ref;
  const DeleteDialogWidget({super.key, required this.postId, required this.ref});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      actions: [
        TextButton(
          onPressed: () => {Navigator.of(context).pop()},
          child: Text("No"),
        ),
        TextButton(
            onPressed: () => {
                  ref.read(addDeleteUpdatePostProvider.notifier).deletePost(postId)
                },
            child: Text("Yes"))
      ],
    );
  }
}
