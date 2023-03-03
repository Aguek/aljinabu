import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/futureBuilderWidgetsModel.dart';

class DrivingLicenseDetails extends StatefulWidget {
  const DrivingLicenseDetails({Key? key, this.licenseNumber}) : super(key: key);
  final licenseNumber;

  @override
  State<DrivingLicenseDetails> createState() => _DrivingLicenseDetailsState();
}

class _DrivingLicenseDetailsState extends State<DrivingLicenseDetails> {
  Future getLicenseDetails() async {
    String url =
        "https://rokeats.000webhostapp.com/aljinabu/get_license_details.php";
    var request = await http.post(Uri.parse(url),
        body: json.encode({
          'license_number': widget.licenseNumber,
        }));
    var response = jsonDecode(request.body);
    print(response.toString());
    if (response.toString() == "[]") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("${widget.licenseNumber} DETAILS"),
              content: Text("This license isn't registered in the system."),
            );
          });
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    getLicenseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Driving License Details.'),
      ),
      backgroundColor: Colors.white70,
      body: FutureBuilder(
        future: getLicenseDetails(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          late List snap = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (BuildContext context, int index) {
              return licenseDetailsModel(
                snap[index]['owner_name'],
                snap[index]['class'],
                snap[index]['nin'],
                snap[index]['place_issued'],
                snap[index]['number'],
                snap[index]['date_issued'],
                snap[index]['expiry_date'],
              );
            },
          );
        },
      ),
    );
  }
}

Widget licenseDetailsModel(
  String owner,
  String licenseClass,
  String nin,
  String placeIssued,
  String licenseNo,
    String issuingDate,
  String expiryDate,

) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          itemToShow(owner, Icons.person),
          itemToShow("License Class: ${licenseClass}", Icons.class_),
          itemToShow("NIN: $nin", Icons.confirmation_number_outlined),
          itemToShow(placeIssued, Icons.place),
          itemToShow("License Number: $licenseNo", Icons.numbers),
          itemToShow("Issuing Date: $issuingDate", Icons.date_range),
          itemToShow("Expiry Date: $expiryDate", Icons.date_range),

        ],
      ),
    ),
  );
}
