import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:janabu/screens/bottom_navigation.dart';
import 'package:janabu/screens/login_screen.dart';
import 'package:janabu/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var badgeno = preferences.getString('badgeno');

  Timer(const Duration(seconds: 2), () {
    Get.to(badgeno == null ? LoginScreen() : BottomNavigation(badgeNumber: badgeno,));
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
