import 'package:flutter/material.dart';
import 'package:janabu/screens/check_traffic_fines.dart';
import 'package:janabu/screens/report_traffic_incident.dart';
import 'package:janabu/screens/verify_license_screen.dart';
import 'package:janabu/screens/verify_logbook.dart';
import 'package:janabu/screens/verify_number_plate.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/services_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'issue_traffic_fine.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.badgeno}) : super(key: key);
  final String badgeno;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name = '';
  var id = '';
  Future getUserInfo() async {
    String url = "https://rokeats.000webhostapp.com/aljinabu/get_user.php";
    var request = await http.post(Uri.parse(url), body: json.encode({
      'badgeNumber': widget.badgeno,
    }));
    var response = json.decode(request.body);
    setState(() {
      name = response[0]['name'].split(' ')[0];
      id = response[0]['id'];
    });
    return response[0]['name'];
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView(children: [
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0)),
          ),
          height: MediaQuery.of(context).size.height / 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Marhab Janabu,",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    name == '' ? 'Officer' : "$name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  )
                ],
              ),
              const Image(
                height: 100.0,
                color: Colors.white,
                image: AssetImage("assets/images/user.png"),
              ),
            ],
          ),
        ),
        ////end of introductory section

        //// beginning of services section
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "What would you like to do?",
                style: kHeadingStyle,
              ),
            ),
            Row(
              children: [
                ServicesModel(
                  link: 'assets/images/driver-license-card.png',
                  text: 'Verify License',
                  onClick: () {
                    Get.to(VerifyLicense());
                  },
                ),
                ServicesModel(link: 'assets/images/driver-license-card.png',
                    text: 'Check fines', onClick: (){
                      Get.to(CheckFines());

                    }),
                ServicesModel(
                  link: 'assets/images/licence-plate.png',
                  text: 'Verify Plate.',
                  onClick: () {
                    Get.to(VerifyNumberPlate());
                  },
                )
              ],
            ),
            Row(
              children: [
                ServicesModel(
                  link: 'assets/images/logbook.png',
                  text: 'Verify Logbook',
                  onClick: () {
                    Get.to(VerifyLogbook());
                  },
                ),
                ServicesModel(
                  link: 'assets/images/police-fine.png',
                  text: 'Traffic Fine',
                  onClick: () {
                    Get.to(TrafficFine());
                  },
                ),
                ServicesModel(
                  link: 'assets/images/crime.png',
                  text: 'Report Incident',
                  onClick: () {
                    Get.to(ReportTrafficIncident(id: id));
                  },
                ),
              ],
            ),
          ],
        ),
        //// end of services section

      ]),
    );
  }
}



