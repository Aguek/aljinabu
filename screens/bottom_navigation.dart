import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:janabu/constants.dart';
import 'package:janabu/screens/profile_screen.dart';
import 'home_screen.dart';
import 'incidents.dart';
import 'package:http/http.dart' as http;

class BottomNavigation extends StatefulWidget {
  String badgeNumber;
  BottomNavigation({required this.badgeNumber});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var _selectedIndex = 0;
  // we shall get the details of the logged in user depending on the
  // badgeNumber, then display their image.







  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(badgeno: widget.badgeNumber,),
      Incidents(),
      ProfileScreen(badgeno: widget.badgeNumber),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        unselectedItemColor: Colors.white70,
        backgroundColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          // ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important,),
            label: 'Incidents',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
