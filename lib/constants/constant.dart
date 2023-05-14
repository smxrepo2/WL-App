import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xff4885ED);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);

const lightRed = Color(0xFFff2c2c);
const redColor = Color(0xFFFF0000);
const lightGreen = Color(0xFF90ee90);

const secondaryColor = Color(0xFF0ABFC8);
const pinkColor = Color(0xFFE55864);
const purple = Color(0xFFA954B1);
const noInternetsnackBar = SnackBar(
    content:
        Text("No internet connection", style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.red);

const darkGrey = Color(0xFF707070);
const darkColor = Color(0xFF2B2B2B);
const saltPurple = Color(0xFF9075ff);
const lightGrey = Color(0xFFAFAFAF);

///Question color
const queColor = Color(0xff23233C);
const greyColor = Color(0xff797A7A);
const buttonColor = Color(0xffD7E2F1);

const selectColor = Color(0xffFFEFDB);
const selectBorderColor = Color(0xffF7D4A6);

const mindSelect = Color(0xffEFE2FB);
const mindBorder = Color(0xffE6D1F8);

const exSelect = Color(0xffD7E2F1);
const exBorder = Color(0xffCBECE5);

const light = FontWeight.w300;
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w600;

const totalQuestion = 23;
// Russian Salad
String totalCalInCircleValue = '200';
String carbsValue = '17.2g';
String fatValue = ' 55.5g';
String proteinValue = '85.7g';

//Percent from your daily Budget

String calories = '150g';
String carbs = '450g';
String fat = '45g';
String protein = '254g';
var style = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: darkGrey,
);
var bodyText = GoogleFonts.openSans(
  fontSize: 10,
  color: Colors.black,
);

const int questionHeight = 44;
var bodyTextred = GoogleFonts.openSans(
  fontSize: 12,
  color: pinkColor,
);
var bodyTextpurple = GoogleFonts.openSans(
  fontSize: 12,
  color: purple,
);
var bodyTextFez = GoogleFonts.openSans(
  fontSize: 12,
  color: secondaryColor,
);
var tabStyle = GoogleFonts.openSans(
  fontSize: 14,
  color: Colors.black87,
);

var style1 = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

TextStyle labelStyle(
  double size,
  FontWeight weight,
  Color color,
) {
  return GoogleFonts.openSans(fontSize: size, fontWeight: weight, color: color);
}
