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

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController badgeNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  var isLoading = false.obs;

  Future loginRequest() async {
    isLoading.value = true;
    var url = "https://rokeats.000webhostapp.com/aljinabu/login.php";
    var request = await http.post(Uri.parse(url), body: json.encode(
        {
          'badgeno': badgeNumber.text,
          'password': password.text,
        }
    ));
    var responseBody = jsonDecode(request.body);
    if (request.statusCode == 200){
      isLoading.value = false;
    }


    if (responseBody.toString() == "LOGIN SUCCESSFUL.") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('badgeno', badgeNumber.text);
      Get.to(BottomNavigation(badgeNumber: badgeNumber.text,));
    } else {
      Get.defaultDialog(
          content: Text(responseBody),
          titleStyle: TextStyle(
            color: Colors.red
          ),
          actions: [
            ButtonModel(
                text: 'RETRY',
                onTap: () {
                  Get.back();
                })
          ]);
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
                        'Welcome ya janabu!',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      'Keep the roads safe!',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white70,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
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
                              controller: badgeNumber,
                              decoration: InputDecoration(
                                labelText: 'Enter your badge number',
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
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Enter your password',
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
                              text: "Login",
                              onTap: () {
                                loginRequest();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 0.0,
                            ),
                            child: Column(
                              children: [
                                TextButtonModel(
                                    text: 'Forgot Password?', onPressed: ()=> Get.to(ContactConfirmationScreen())),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text("Don't have an account?"),
                                    // TextButtonModel(
                                    //     text: 'Make Request', onPressed: () {})
                                  ],
                                ),
                              ],
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
