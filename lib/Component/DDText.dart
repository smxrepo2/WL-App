import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/ColorConfig.dart';

TextStyle textStyle = GoogleFonts.openSans(
  fontSize: 14,
  color: ColorConfig().terColor.withOpacity(0.8),
);

class DDText extends StatefulWidget {
  final String title;
  final FontWeight weight;
  final double size;
  final color;
  final toverflow;
  final bool center;
  final int line;
  final bool under, cut;

  DDText(
      {this.title,
      this.size,
      this.color,
      this.weight,
      this.center,
      this.line,
      this.under,
      this.toverflow,
      this.cut});

  @override
  _DDTextState createState() => _DDTextState();
}

class _DDTextState extends State<DDText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title ?? "",
      overflow: widget.toverflow ?? TextOverflow.visible,
      maxLines: widget.line ?? 1,
      style: GoogleFonts.openSans(
        decoration: widget.under == true
            ? TextDecoration.underline
            : widget.cut == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontSize: widget.size,
        color: widget.color ?? ColorConfig().terColor,
        fontWeight: widget.weight == null ? FontWeight.w400 : widget.weight,
      ),
      textAlign: widget.center == null
          ? TextAlign.left
          : widget.center
              ? TextAlign.center
              : TextAlign.left,
    );
  }
}
