import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/diet_widget.dart';

class RunningTab extends StatefulWidget {
  RunningTab();

  @override
  _RunningTabState createState() => _RunningTabState();
}

class _RunningTabState extends State<RunningTab> {
  List a = [
    'assets/images/diet2.jpg',
    'assets/images/diet4.jpg',
    'assets/images/diet3.jpg',
    'assets/images/diet3.jpg',
    'assets/images/diet2.jpg',
    'assets/images/diet4.jpg',
    'assets/images/diet3.jpg',
    'assets/images/diet2.jpg',
    'assets/images/diet4.jpg',
    'assets/images/diet3.jpg',
    'assets/images/diet2.jpg',
    'assets/images/diet4.jpg',
  ];
  String tabBarText = 'My Diet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * .2,
                    child: Image.asset(
                      'assets/images/appleee.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        'Diet program',
                        style:
                            whiteText18Px.copyWith(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          tabBarText = 'My Diet';
                        });
                      },
                      child: Container(
                          height: Get.height * .04,
                          width: Get.width * .12,
                          decoration: BoxDecoration(
                              border: tabBarText == 'My Diet'
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 1.5, color: primaryColor))
                                  : Border()),
                          child: Text(
                            'My Diet',
                            style: darkText14Px,
                            textAlign: TextAlign.center,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tabBarText = 'My Workouts';
                        });
                      },
                      child: Container(
                          height: Get.height * .04,
                          width: Get.width * .15,
                          decoration: BoxDecoration(
                              border: tabBarText == 'My Workouts'
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 1.5, color: primaryColor))
                                  : Border()),
                          child: Text(
                            'My Workouts',
                            style: darkText14Px,
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  Container(
                    width: Get.width * .72,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '<',
                            style: darkText16Px,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Today',
                              style: darkText16Px.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            '>',
                            style: darkText16Px,
                          )
                        ],
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.history_edu),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Morning',
                      style: darkText14Px,
                    ),
                    Text(
                      '8:30',
                      style: darkText14Px,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Container(
                  height: Get.height * .2,
                  //width: Get.width * .8,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return DietWidget();
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lunch',
                      style: darkText14Px,
                    ),
                    Text(
                      '12:30',
                      style: darkText14Px,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Container(
                  height: Get.height * .2,
                  //width: Get.width * .8,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return DietWidget();
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dinner',
                      style: darkText14Px,
                    ),
                    Text(
                      '9:30',
                      style: darkText14Px,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Container(
                  height: Get.height * .2,
                  //width: Get.width * .8,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return DietWidget();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
