import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

import '../models/futureBuilderWidgetsModel.dart';
class LogbookDetails extends StatefulWidget {
  const LogbookDetails({Key? key, this.logbookNumber}) : super(key: key);
  final logbookNumber;

  @override
  State<LogbookDetails> createState() => _LogbookDetailsState();
}

class _LogbookDetailsState extends State<LogbookDetails> {
  Future getLogbookDetails() async {
    var url =
        "https://rokeats.000webhostapp.com/aljinabu/get_logbook_details.php";
    var request = await http.post(Uri.parse(url), body: json.encode({
      'logbook_number': widget.logbookNumber,
    }));
    var response = jsonDecode(request.body);
    print(response.toString());
    if (response.toString() == "[]"){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("${widget.logbookNumber} LOGBOOK DETAILS"),
          content: Text("This logbook is invalid."),
        );
      });
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    getLogbookDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('${widget.logbookNumber} Traffic Fines.'),
      ),
      backgroundColor: Colors.white70,
      body: FutureBuilder(
        future: getLogbookDetails(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          late List snap = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (BuildContext context, int index) {
              return finesDetailsModel(
                snap[index]['manufacturer'],
                snap[index]['model'],
                snap[index]['engine_no'],
                snap[index]['number_plate'],
                snap[index]['year'],
                snap[index]['color_name'],
                snap[index]['owner_name'],
                snap[index]['number'],
              );
            },
          );
        },
      ),
    );

  }
}

Widget finesDetailsModel(
    String manufacturer, String model, String engineNo, String numberPlate, String year,
    String color, String owner, String number) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          itemToShow(manufacturer, Icons.factory),
          itemToShow(model, Icons.car_rental),
          itemToShow("Engine No: $engineNo", Icons.settings),
          itemToShow(numberPlate, Icons.abc_outlined),
          itemToShow(year, Icons.calendar_month),
          itemToShow(color, Icons.color_lens),
          itemToShow(owner, Icons.person),
          itemToShow(number, Icons.numbers),
        ],
      ),
    ),
  );
}