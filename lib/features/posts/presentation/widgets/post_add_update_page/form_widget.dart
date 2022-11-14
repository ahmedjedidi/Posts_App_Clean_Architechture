import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/post_add_update_page/form_submit_btn.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';

import '../../riverpood/add_delete_update_post/add_delete_update_provider.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;
  final WidgetRef ref;
  const FormWidget(
      {super.key, required this.isUpdate, this.post, required this.ref});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final key = GlobalKey<FormState>();
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _bodyEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleEditingController.text = widget.post!.title;
      _bodyEditingController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title",
                multiline: false,
                controller: _titleEditingController),
            TextFormFieldWidget(
                name: "Body",
                multiline: true,
                controller: _bodyEditingController),
            FormSubmitBtn(isUpdate: widget.isUpdate, onPressed: _validateForm),
          ]),
    );
  }

  void _validateForm() {
    final isFormValid = key.currentState!.validate();
    Post post = Post(
        id: widget.isUpdate ? widget.post!.id : null,
        title: _titleEditingController.text,
        body: _bodyEditingController.text);

    if (isFormValid) {
      if (widget.isUpdate) {
        widget.ref
            .read(addDeleteUpdatePostProvider.notifier).updatePost(post);
            
      } else {
        widget.ref.read(addDeleteUpdatePostProvider.notifier).addPost(post);
      }
    }
  }
}
