import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:janabu/models/button.dart';

import '../constants.dart';
import 'logbook_details.dart';

class VerifyLogbook extends StatefulWidget {
  VerifyLogbook({Key? key}) : super(key: key);

  @override
  State<VerifyLogbook> createState() => VerifyLogbookState();
}

class VerifyLogbookState extends State<VerifyLogbook> {
  TextEditingController logbook_number = TextEditingController();

  Future showAlert(){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("${logbook_number.text}DETAILS"),
        content: Column(
          children: [
            Text("Registered Owner: Anyieth Aguek"),
            Text("Model: V8"),
            Text("Year: 2022"),
            Text("Logbook Status: Active"),
            Text("Color: White"),
          ],
        ),

      );
    });
  }

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
                      "Verify Logbook,",
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
              controller: logbook_number,
              decoration: InputDecoration(
                labelText: 'Enter the logbook number.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
            child: ButtonModel(text: 'Verify Logbook', onTap: (){
              Get.to(LogbookDetails(logbookNumber: logbook_number.text,));
            }),
          )

        ],
      ),
    );
  }
}
