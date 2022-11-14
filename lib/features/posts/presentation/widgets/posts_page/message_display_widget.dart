import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  const MessageDisplayWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(message,style: TextStyle(fontSize: 25),textAlign: TextAlign.center,)
        ),
      ),
    );
  }
}