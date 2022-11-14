import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      PostAddUpdatePage(isUpdate: true, post: post)));
        },
        icon: Icon(Icons.edit),
        label: Text("Update"));
  }
}
