import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/utils/ColorConfig.dart';
import 'package:http/http.dart' as http;

import 'add_water_widget.dart';

Future AltDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(text),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
Future WaterDialog(BuildContext context,) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        // contentPadding: EdgeInsets.all(0),
        actions: <Widget>[AddWaterWidget()],
      );
    },
  );
}
class EditText extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function() onpress;
  EditText({this.onpress, this.title, this.controller, this.hintText});
  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  String codeDialog;
  String valueText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(hintText: widget.hintText),
        // onChanged: (value) {
        //   widget.controller.text=value;
        // },
      ),
      actions: [
        MaterialButton(
          child: new Text('Update'),
          onPressed: widget.onpress,
        )
      ],
    );
  }
}

class OptionSelect extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function() onpress;
  OptionSelect({this.title, this.onpress, this.controller, this.hintText});

  @override
  _OptionSelectState createState() => _OptionSelectState();
}

class _OptionSelectState extends State<OptionSelect> {
  var items = ["Agree", "Disagree", "I don\'t know"];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title,style: TextStyle(fontSize: 16),),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down),
            onSelected: (String value) {
              widget.controller.text = value;
            },
            itemBuilder: (BuildContext context) {
              return items.map<PopupMenuItem<String>>((String value) {
                return new PopupMenuItem(child: new Text(value), value: value);
              }).toList();
            },
          ),
        ),
      ),
      actions: [
        MaterialButton(
          child: new Text('Update'),
          onPressed: widget.onpress,
        )
      ],
    );
  }
}
