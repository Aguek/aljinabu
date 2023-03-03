import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import '../models/button.dart';

class ReportTrafficIncident extends StatefulWidget {
  const ReportTrafficIncident({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ReportTrafficIncident> createState() => _ReportTrafficIncidentState();
}

class _ReportTrafficIncidentState extends State<ReportTrafficIncident> {
  TextEditingController plate_number = TextEditingController();
  var isLoading = false.obs;
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  List<dynamic> incidentsLists = [];
  List<String> selectedIncident = [];
  // method for reporting incident.
  Future reportIncident() async {
    isLoading.value = true;
    String url =
        "https://rokeats.000webhostapp.com/aljinabu/report_incident.php";
    var request = await http.post(Uri.parse(url),
        body: json.encode({
          'plateNumber': plate_number.text.toUpperCase(),
          'location': location.text,
          'description': description.text,
          'incident': selectedIncident[0],
          'id': widget.id,
        }));

    var response = jsonDecode(request.body);
    print(response);
    if (request.statusCode == 200) {
      isLoading.value = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                response.toString(),
                style: TextStyle(
                  color: Colors.green,
                ),
              ),

            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getIncidents();
  }

  Future<void> getIncidents() async {
    String url =
        "https://rokeats.000webhostapp.com/aljinabu/get_incident_names.php";
    var request = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(request.body);
    setState(() {
      incidentsLists = responseBody;
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
                      "Report Traffic Incident,",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
            padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: location,
              decoration: InputDecoration(
                labelText: 'Enter the location.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "Choose the type of incident.",
              style: kHeadingStyle,
            )),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: incidentsLists.length,
            itemBuilder: (context, index) {
              final incident = incidentsLists[index];
              return CheckboxListTile(
                title: Text(incident['incident_name']),
                value:
                    incident['is_checked'].toString().toLowerCase() == "true",
                onChanged: (value) {
                  setState(() {
                    incident['is_checked'] = value;
                    if (value!) {
                      if (selectedIncident.isEmpty) {
                        selectedIncident.add(incident['id']);
                      }
                    } else {
                      selectedIncident.remove(incident['id']);
                    }
                    print(selectedIncident);
                  });
                },
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: description,
              decoration: InputDecoration(
                labelText: 'Describe the incident.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
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
          Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
            child: ButtonModel(
                text: 'Report Incident',
                onTap: () {
                  reportIncident();
                }),
          )
        ],
      ),
    );
  }
}
