import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final bool multiline;
  final TextEditingController controller;
  const TextFormFieldWidget(
      {super.key,
      required this.name,
      required this.multiline,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: TextFormField(
          minLines: multiline ? 6 : 1,
          maxLines: multiline ? 6 : 1 ,
          controller: controller,
          validator: (value) => value!.isEmpty ? "$name Required." : null,
          decoration: InputDecoration(hintText: name),
        ));
  }
}
