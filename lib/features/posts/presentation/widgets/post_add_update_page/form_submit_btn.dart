import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdate;
  final void Function() onPressed;
  const FormSubmitBtn(
      {super.key, required this.isUpdate, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(isUpdate ? Icons.edit : Icons.add),
        label: Text(isUpdate ? "Update" : "Add"));
  }
}
