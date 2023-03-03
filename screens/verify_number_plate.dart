import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:janabu/models/button.dart';
import 'package:janabu/screens/car_details.dart';

import '../constants.dart';

class VerifyNumberPlate extends StatefulWidget {
  VerifyNumberPlate({Key? key}) : super(key: key);


  @override
  State<VerifyNumberPlate> createState() => _VerifyNumberPlateState();
}

class _VerifyNumberPlateState extends State<VerifyNumberPlate> {
  TextEditingController plate_number = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
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
                      "Verify Number Plate,",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Mr. Anyieth.',
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

          // beginning of verify license textfield

          Padding(
            padding: EdgeInsets.only(
                top: 30.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: plate_number,
              decoration: InputDecoration(
                labelText: 'Enter the number plate.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
            child: ButtonModel(text: 'Verify Plate', onTap: (){
              Get.to(CarDetails(numberPlate: plate_number.text,));
            }),
          )

        ],
      ),
    );
  }
}
