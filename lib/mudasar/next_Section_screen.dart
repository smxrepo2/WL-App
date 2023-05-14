import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'dietry_screen.dart';

class NextSetion extends StatefulWidget {
  const NextSetion({Key key}) : super(key: key);

  @override
  State<NextSetion> createState() => _NextSetionState();
}

class _NextSetionState extends State<NextSetion> {

  @override
  Widget build(BuildContext context) {
    // this is will pop scop function f
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DietryScreen()));

    });
    return   Scaffold(
      backgroundColor: Color(0xffFFC5C4),
    );
  }
}
