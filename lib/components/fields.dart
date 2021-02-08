import 'package:flutter/material.dart';

class Fields extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  Fields({this.controller, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          style: TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: title, labelStyle: TextStyle(color: Colors.blueGrey)
          ),
        ),
      ),
    );
  }
}