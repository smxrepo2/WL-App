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

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({Key key}) : super(key: key);

  @override
  _NoInternetWidgetState createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
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
          Icon(Icons.warning_amber_rounded),
          SizedBox(
            height: MySize.size20,
          ),
          Text("No Internet Connection"),
          SizedBox(
            height: MySize.size20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
          SizedBox(
            height: MySize.size10,
          ),
        ],
      ),
    );
  }
}
