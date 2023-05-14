import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';

import '../utils/ColorConfig.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView(
      {Key key,
      this.globalKey,
      this.title,
      this.description,
      this.child,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;
  @override
  Widget build(BuildContext context) {
    return Showcase(
        key: globalKey,
        title: title,
        description: description,
        titleTextStyle: GoogleFonts.openSans(
          fontSize: 15,
          color: Colors.orange.shade500,
          fontWeight: FontWeight.bold,
        ),
        descTextStyle: GoogleFonts.openSans(
          fontSize: 12,
          color: ColorConfig().terColor,
          //fontWeight: FontWeight.bold,
        ),
      //  shapeBorder: shapeBorder,
        child: child);
  }
}
