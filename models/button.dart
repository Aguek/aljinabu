import 'package:flutter/material.dart';
import 'package:janabu/constants.dart';


class ButtonModel extends StatelessWidget {
  const ButtonModel({Key? key, required this.text,required this.onTap}) : super(key: key);
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 55,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,

            ),
          ),
        ),
      ),
    );
  }
}
