import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';

class AddWeightWidget extends StatefulWidget {
  const AddWeightWidget({Key key}) : super(key: key);

  @override
  _AddWeightWidgetState createState() => _AddWeightWidgetState();
}

class _AddWeightWidgetState extends State<AddWeightWidget> {
  var weightController = TextEditingController();
  var weightDropValue = "kg";
  SimpleFontelicoProgressDialog _dialog;
int userid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      // height: 300,
      width: Responsive1.isMobile(context)? MediaQuery.of(context).size.width:300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MySize.size20,
          ),
          Image.asset(ImagePath.weight),
          SizedBox(
            height: MySize.size20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                width: MySize.size80,
                // height: 40,
                child: TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(1),
                    hintText: "0",
                    hintStyle: GoogleFonts.openSans(
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 20),
                width: MySize.size50,
                child: DropdownButton<String>(
                  iconSize: 0.0,
                  value: weightDropValue,
                  underline: SizedBox(),
                  isExpanded: true,
                  items: <String>['kg', 'lbs'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value + "(s)"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      weightDropValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: MySize.size20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              print(weightController.text);
              if (weightController.text.isNotEmpty) {
                _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
                _dialog.show(message: "Please wait", type: SimpleFontelicoProgressDialogType.normal);
                addWeight( int.parse(weightController.text), context);
                setState(() {});
              } else {
                final snackBar =
                    SnackBar(content: Text('Please enter weight', style: TextStyle(color: Colors.white)), backgroundColor: Colors.lightGreen);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text("Add"),
          ),
          SizedBox(
            height: MySize.size10,
          ),
        ],
      ),
    );
  }

  addWeight( int currentWeight, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid=prefs.getInt('userid');
    await patch(
      Uri.parse('$apiUrl/api/goals/weight'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{"UserId": userid, "CurrentWeight": currentWeight}),
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {

        setState(() {Navigator.pop(context,true);});
        print(weightController.text);
        weightController.text = "";
        final snackBar = SnackBar(content: Text('Weight Added', style: TextStyle(color: Colors.white)), backgroundColor: Colors.lightGreen);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _dialog.hide();
      } else {
        final snackBar = SnackBar(content: Text("Unable to add weight", style: TextStyle(color: Colors.white)), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _dialog.hide();
      }
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(content: Text(error.toString(), style: TextStyle(color: Colors.white)), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _dialog.hide();
    });
  }
}
