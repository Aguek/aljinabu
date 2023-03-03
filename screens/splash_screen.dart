import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:janabu/constants.dart';
import 'package:janabu/screens/login_screen.dart';

import 'bottom_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("**********", style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
            Text(
              "aljanabu",
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text("**********", style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
