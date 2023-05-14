import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';

class AddWaterWidget extends StatefulWidget {
  const AddWaterWidget({Key key}) : super(key: key);

  @override
  _AddWaterWidgetState createState() => _AddWaterWidgetState();
}

class _AddWaterWidgetState extends State<AddWaterWidget> {
  var waterController = TextEditingController();
  bool cup1 = false;
  bool cup2 = false;
  bool cup3 = false;
  var glassDropValue = "cup";
  SimpleFontelicoProgressDialog _dialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      // height: 300,
      width: Responsive1.isMobile(context)
          ? MediaQuery.of(context).size.width
          : 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MySize.size20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.waterGlass,
                width: 60,
                height: 60,
              ),
            ],
          ),
          // SizedBox(
          //   height: MySize.size20,
          // ),
          Container(
            padding: EdgeInsets.only(left: MySize.size84),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MySize.size60,
                  // height: 40,
                  child: TextFormField(
                    controller: waterController,
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
                  padding: EdgeInsets.only(top: 8),
                  width: MySize.size100,
                  child: DropdownButton<String>(
                    iconSize: 0.0,
                    value: glassDropValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    items: <String>['cup', 'mug'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: DDText(
                          title: value + "(s)",
                          size: 11,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        glassDropValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cup1 = true;
                      cup2 = false;
                      cup3 = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: cup1 ? primaryColor : Color(0xff797A7A),
                      ),
                      color: cup1 ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: DDText(
                        title: "+1 CUP",
                        size: 11,
                        color: cup1 ? Colors.white : Color(0xff797A7A),
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cup1 = false;
                      cup2 = true;
                      cup3 = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: cup2 ? primaryColor : Color(0xff797A7A)),
                      color: cup2 ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: DDText(
                        title: "+2 CUP",
                        size: 11,
                        color: cup2 ? Colors.white : Color(0xff797A7A),
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cup1 = false;
                      cup2 = false;
                      cup3 = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: cup3 ? primaryColor : Color(0xff797A7A)),
                      color: cup3 ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: DDText(
                        title: "+3 CUP",
                        size: 11,
                        color: cup3 ? Colors.white : Color(0xff797A7A),
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: MySize.size20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              if (!cup1 && !cup2 && !cup3) {
                if (waterController.text.isNotEmpty &&
                    waterController.text.trim() != '0') {
                  _dialog = SimpleFontelicoProgressDialog(
                      context: context, barrierDimisable: true);
                  _dialog.show(
                      message: "Please wait",
                      type: SimpleFontelicoProgressDialogType.normal);
                  addWater(int.parse(waterController.text), context);
                } else {
                  final snackBar = SnackBar(
                      content: Text('Water count is empty',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else {
                int value = 0;
                if (cup1) value = 1;
                if (cup2) value = 2;
                if (cup3) value = 3;
                _dialog = SimpleFontelicoProgressDialog(
                    context: context, barrierDimisable: true);
                _dialog.show(
                    message: "Please wait",
                    type: SimpleFontelicoProgressDialogType.normal);
                addWater(value, context);
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

  int userid;
  addWater(int waterServing, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    await post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": 6,
        "WaterServing": waterServing
      }),
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        Navigator.pop(context, true);
        waterController.text = "";
        print("Water ${waterServing}");
        final snackBar = SnackBar(
            content: Text('Water Added', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.lightGreen);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _dialog.hide();
      } else {
        final snackBar = SnackBar(
            content: Text("Unable to add water",
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _dialog.hide();
      }
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(
          content: Text(
              error.toString().contains("Failed host lookup")
                  ? "No internet connection"
                  : "Check your Internet/Connectivity",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _dialog.hide();
    });
  }
}
