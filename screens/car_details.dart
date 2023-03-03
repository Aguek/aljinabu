import 'package:flutter/material.dart';
import 'package:janabu/models/details_model.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

import '../models/futureBuilderWidgetsModel.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({Key? key, this.numberPlate}) : super(key: key);
  final numberPlate;

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  Future getCarDetails() async {
    var url = "https://rokeats.000webhostapp.com/aljinabu/get_car_details.php";
    var request = await http.post(Uri.parse(url),
        body: json.encode({
          'number_plate': widget.numberPlate,
        }));
    var response = json.decode(request.body);
    if (response.toString() == "[]"){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("${widget.numberPlate} DETAILS"),
          content: Text("There are no registered records pertaining this number plate."),
        );
      });
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    getCarDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.numberPlate} Details"),
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: Colors.white70,
      body: FutureBuilder(
        future: getCarDetails(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          late List snap = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (BuildContext context, int index) {
              return carDetailsModel(
                snap[index]['manufacturer'],
                snap[index]['model'],
                snap[index]['year'],
                snap[index]['color_name'],
                snap[index]['type_of_use'],
                snap[index]['engine_no'],

              );
            },
          );
        },
      ),
    );
  }
}

Widget carDetailsModel(String manufacturer, String model, String year,
    String color, String type_of_use, String engine) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: itemToShow(manufacturer, Icons.factory),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: itemToShow(model, Icons.car_rental),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: itemToShow(color, Icons.color_lens),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: itemToShow(type_of_use, Icons.workspaces_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: itemToShow("Engine No: $engine", Icons.settings,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: itemToShow(year, Icons.calendar_month),
          ),
        ],
      ),
    ),
  );
}
