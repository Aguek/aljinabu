import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

import '../models/futureBuilderWidgetsModel.dart';
import 'incidents.dart';

class FinesDetails extends StatefulWidget {
  const FinesDetails({Key? key, this.number_plate}) : super(key: key);
  final number_plate;

  @override
  State<FinesDetails> createState() => _FinesDetailsState();
}

class _FinesDetailsState extends State<FinesDetails> {
  Future getTrafficFines() async {
    var url =
        "https://rokeats.000webhostapp.com/aljinabu/get_traffic_fines.php";
    var request = await http.post(Uri.parse(url), body: json.encode({
      'number_plate': widget.number_plate,
    }));
    var response = jsonDecode(request.body);
    print(response.toString());
    if (response.toString() == "[]"){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("${widget.number_plate} FINES"),
          content: Text("This car has no traffic fines."),
        );
      });
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    getTrafficFines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('${widget.number_plate} Traffic Fines.'),
      ),
      body: FutureBuilder(
        future: getTrafficFines(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          late List snap = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (BuildContext context, int index) {
              return finesDetailsModel(
                snap[index]['id'],
                snap[index]['number_plate'],
                snap[index]['fine'],
                snap[index]['time_issued'],
              );
            },
          );
        },
      ),
    );
  }
}

Widget finesDetailsModel(
    String id, String number_plate, String fine, String date) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          itemToShow(id, Icons.numbers),
          itemToShow(number_plate, Icons.car_rental),
          itemToShow(fine, Icons.ac_unit_sharp),
          itemToShow(date, Icons.calendar_month)
        ],
      ),
    ),
  );
}
