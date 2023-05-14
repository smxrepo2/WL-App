import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/screens/auth/authenticate/authenticate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>   with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.to(()=> const Authenticate());
  }
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    animation =
    CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: 'imageHero',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Image.asset('assets/images/weightchopper.png'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
              ),
              SizedBox(
                width: double.infinity,
                  child: Image.asset(
                      'assets/images/weight loser splash screend-01.png',)),
            ],
          ),
        ),
      ),
    );
  }
}
