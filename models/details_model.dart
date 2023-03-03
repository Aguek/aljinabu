import 'package:flutter/material.dart';

import '../constants.dart';


Widget buildListTileModel(String text, IconData icon) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(icon),
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(text, style: TextStyle(
          color: Colors.white,
        ),),
        tileColor: kPrimaryColor,
      ),
    ),
  );
}