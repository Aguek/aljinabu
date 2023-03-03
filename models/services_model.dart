import 'package:flutter/material.dart';

/*
* this class is a model for the options on the home screen
* */

class ServicesModel extends StatefulWidget {
  const ServicesModel({Key? key, required this.link, required this.text, required this.onClick})
      : super(key: key);
  final String link;
  final String text;
  final void Function() onClick;


  @override
  State<ServicesModel> createState() => _ServicesModelState();
}

class _ServicesModelState extends State<ServicesModel> {
  // void tapAction() {
  //   showDialog(context: context, builder: (BuildContext context){
  //     return AlertDialog(
  //       title: Text("Am a button"),
  //       content: Text('Am a button and you\'ve tapped me'),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onClick,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            shadowColor: Colors.black,
            color: Colors.white,
            elevation: 120,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Image(
                    color: Colors.blue,
                    image: AssetImage(widget.link),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.text,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
