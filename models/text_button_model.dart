import 'package:flutter/material.dart';

import '../constants.dart';




class TextButtonModel extends StatelessWidget {
  const TextButtonModel({Key? key, required this.text, required this.onPressed}) : super(key: key);
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
      return TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(
          color: kPrimaryColor,
        ),),
      );

  }
}
