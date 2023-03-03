import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

import '../models/futureBuilderWidgetsModel.dart';

class Incidents extends StatefulWidget {
  const Incidents({Key? key}) : super(key: key);

  @override
  State<Incidents> createState() => _IncidentsState();
}

class _IncidentsState extends State<Incidents> {
  Future getIncidents() async {
    String url = "https://rokeats.000webhostapp.com/aljinabu/get_incidents.php";
    var request = await http.get(Uri.parse(url));
    var response = jsonDecode(request.body);
    return response;
  }

  @override
  void initState() {
    super.initState();
    getIncidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Latest Incidents'),
      ),
      backgroundColor: Colors.white70,
      body: FutureBuilder(
        future: getIncidents(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          late List snap = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (BuildContext context, int index) {
              return incidentsModel(
                  snap[index]['incident_name'],
                  snap[index]['location'],
                  snap[index]['time_reported'],
                  snap[index]['description']);
            },
          );
        },
      ),
    );
  }
}

Widget incidentsModel(
    String incident_name, String location, String date, String description) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          itemToShow(incident_name.toUpperCase(), Icons.add_road),
          itemToShow(location, Icons.location_on_rounded),
          itemToShow(date, Icons.access_time_filled_rounded),
          itemToShow(description, Icons.note)
        ],
      ),
    ),
  );
}


