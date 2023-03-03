import 'package:flutter/material.dart';

import '../constants.dart';

Widget itemToShow(String incident, IconData icon) {
  return ListTile(
    leading: Icon(icon),
    iconColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    title: Text(
      incident,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    tileColor: kPrimaryColor,
  );
}