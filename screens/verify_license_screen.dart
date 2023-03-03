import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:janabu/models/button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:janabu/screens/driving_license_details.dart';
import '../constants.dart';
import '../models/text_button_model.dart';

class VerifyLicense extends StatefulWidget {
  VerifyLicense({Key? key}) : super(key: key);

  @override
  State<VerifyLicense> createState() => _VerifyLicenseState();
}

class _VerifyLicenseState extends State<VerifyLicense> {
  TextEditingController license_number = TextEditingController();

  String _scanBarcode = '';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
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
                      "Verify Driving License,",
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
            padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: license_number,
              decoration: InputDecoration(
                labelText: 'Enter the license number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
            child: ButtonModel(
                text: 'Verify License',
                onTap: () {
                  Get.to(DrivingLicenseDetails(licenseNumber: license_number.text,));
                }),
          ),

          Center(
              child: Text(
            "OR",
            style: TextStyle(
              fontSize: 30,
            ),
          )),

          //// SCAN LICENSE BAR CODE
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
            child: ButtonModel(
                text: 'Scan License', onTap: () => scanBarcodeNormal()),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: TextButtonModel(text:_scanBarcode == '' ? '' : 'Verify: $_scanBarcode\n', onPressed: ()=>Get.to(DrivingLicenseDetails(licenseNumber: _scanBarcode,)),),
          ),
        ],
      ),
    );
  }
}
