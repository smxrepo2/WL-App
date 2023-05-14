// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Component/DDText.dart';
import '../utils/ColorConfig.dart';

// ignore: must_be_immutable
class DDButton extends StatelessWidget {
  double height, width;
  String title;
  Color bgColor;
  Function onTap;

  DDButton({this.height, this.width, this.onTap, this.title, this.bgColor});

  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: bgColor ?? colors.secondaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: DDText(
          title: title,
          color: colors.primaryColor,
          weight: FontWeight.w600,
          size: 14,
        )),
      ),
    );
  }
}
