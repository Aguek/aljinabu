import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:janabu/constants.dart';
import '../models/details_model.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.badgeno}) : super(key: key);
  final String badgeno;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String idNum = "";
  String rank = "";
  String dateJoined = "";
  String contact = "";
  String gender = "";
  String address = "";
  Future getUserInfo() async {
    String url = "https://rokeats.000webhostapp.com/aljinabu/get_user.php";
    var request = await http.post(Uri.parse(url), body: json.encode({
      'badgeNumber': widget.badgeno,
    }));
    var response = json.decode(request.body);
    setState(() {
      name = response[0]['name'];
      idNum = response[0]['badgeno'];
      rank = response[0]['rank'];
      dateJoined = response[0]['date_joined'];
      contact = response[0]['contact'];
      address = response[0]['address'];
      gender = response[0]['gender'];
    });
    return response[0];
  }

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile.'),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              height: 150.0,
              color: Colors.blue,
              image: AssetImage("assets/images/user.png"),
            ),
          ),

          buildListTileModel(name, Icons.person),
          buildListTileModel(gender, Icons.shield_moon_sharp),
          buildListTileModel(idNum, Icons.badge),
          buildListTileModel(rank, Icons.star),
          buildListTileModel(dateJoined, Icons.date_range),
          buildListTileModel(contact, Icons.phone),
          buildListTileModel(address, Icons.home),

        ]
      ),
    );
  }
}
