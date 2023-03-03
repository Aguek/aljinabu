import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:janabu/constants.dart';
import 'package:janabu/models/button.dart';
import '../models/card_model.dart';
import '../models/text_button_model.dart';
import 'bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'contact_confirmation_screen.dart';

class PasswordReset extends StatelessWidget {
  PasswordReset({super.key});
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  var isLoading = false.obs;
  // get the id from the otpresetscreen, update them password
  Future resetPassword() async {
    isLoading.value = true;
    var url = "";
    var request = await http.post(Uri.parse(url));
    var responseBody = jsonDecode(request.body);
    if (request.statusCode == 200){
      isLoading.value = false;
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70.0, bottom: 70.0),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              // singlechildscrollview is to make the textfields adjust to fit on the screen when the keyboard comes up
              child: SingleChildScrollView(
                //the CardModel is a class from the models directory which contains a card, and it has one arguement called column, and
                //it is of type widget, that is why it is being assigned a Column
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CardModel(
                      radius: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.0, left: 8.0, right: 8.0),
                            child: TextField(
                              obscureText: true,
                              controller: password,
                              decoration: InputDecoration(
                                labelText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.0, left: 8.0, right: 8.0),
                            child: TextField(
                              controller: confirmPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm your password',
                                focusColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 25.0),
                          // adding the circular progress indicator depending
                          // on the state of the request
                          Center(
                            child: Obx(() {
                              if (isLoading.value) {
                                return CircularProgressIndicator(
                                  color: kPrimaryColor,
                                );
                              } else {
                                return Text('');
                              }
                            }),
                          ),
                          //the button model is from the model class
                          //it will contain code to validate the user logging in so that he can login or be denied access
                          //all of that will in the onPressed
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonModel(
                              text: "Reset Password",
                              onTap: () {
                                resetPassword();
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
