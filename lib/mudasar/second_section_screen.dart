import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/select_your_opinion_on_self_control_screen.dart';

import 'dietry_screen.dart';

class SecondSectionScreen extends StatefulWidget {
  const SecondSectionScreen({Key key}) : super(key: key);

  @override
  State<SecondSectionScreen> createState() => _SecondSectionScreenState();
}

class _SecondSectionScreenState extends State<SecondSectionScreen> {
  @override
  Widget build(BuildContext context) {
    // this is will pop scop function f
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectYourOpinionSelfControlScreen(),
          ));
    });
    return Scaffold(
      backgroundColor: Color(0xffF4C2AB),
    );
  }
}
