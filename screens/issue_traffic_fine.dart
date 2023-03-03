import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import '../models/button.dart';

class TrafficFine extends StatefulWidget {
  const TrafficFine({Key? key}) : super(key: key);

  @override
  State<TrafficFine> createState() => _TrafficFineState();
}

class _TrafficFineState extends State<TrafficFine> {
  TextEditingController plate_number = TextEditingController();
  List<dynamic> fines = [];
  List<String> selectedItems = [];
  String selectedItemId = "";
  var isLoading = false.obs;

  Future issueFine() async {
    isLoading.value = true;
    String url =
        "https://rokeats.000webhostapp.com/aljinabu/issue_traffic_fine.php";
    var request = await http.post(Uri.parse(url),
        body: json.encode({
          'plateNumber': plate_number.text.toUpperCase(),
          'fine': selectedItemId,
        }));

    var response = jsonDecode(request.body);
    print(response);
    if (request.statusCode == 200) {
      isLoading.value = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(response.toString(), style: TextStyle(
                color: Colors.green,
              ),),
            );
          });
    }
  }
  @override
  void initState() {
    super.initState();
    getFines();
  }

  Future<void> getFines() async {
    String url = "https://rokeats.000webhostapp.com/aljinabu/get_type_of_fines.php";
    var request = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(request.body);
    setState(() {
      fines = responseBody;
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
                      "Issue a traffic fine,",
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
            padding: EdgeInsets.only(
                top: 30.0, left: 8.0, right: 8.0),
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
          SizedBox(
            height: 10,
          ),
          Center(child: Text('Select the appropriate fine.', style: kHeadingStyle,)),
          SizedBox(
            height: 10,
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: fines.length,
            itemBuilder: (context, index) {
              final fine = fines[index];
              return RadioListTile(
                title: Text(fine['fine']),
                value: fine['id'],
                groupValue: selectedItemId,
                onChanged: (value) {
                  setState(() {
                    selectedItemId = value.toString();
                    print(selectedItemId);
                  });
                },
              );
            },
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
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8, bottom: 12),
            child: ButtonModel(text: 'Issue Fine', onTap: (){
              issueFine();
            }),
          )

        ],
      ),
    );
  }
}
