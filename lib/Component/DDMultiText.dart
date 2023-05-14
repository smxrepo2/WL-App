import 'package:flutter/material.dart';
import '../Component/DDText.dart';
import '../utils/ColorConfig.dart';

// ignore: must_be_immutable
class DDMultiText extends StatelessWidget {
  String text1, text2;
  Color color1, color2;
  double size1, size2;

  DDMultiText(
      {this.color1,
      this.size1,
      this.color2,
      this.size2,
      this.text1,
      this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: textStyle.copyWith(
              fontSize: size1 ?? 14,
              color: color1 ?? ColorConfig().primaryColor),
          children: [
            TextSpan(
              text: text2,
              style: textStyle.copyWith(
                  fontSize: size2 ?? 14,
                  color: color2 ?? ColorConfig().secondaryColor),
            )
          ]),
    );
  }
}
