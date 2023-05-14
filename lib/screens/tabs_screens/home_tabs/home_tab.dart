import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/constants/constant.dart';

import 'home_sub_tabs.dart';

class HomeScreenTab extends StatefulWidget {
  HomeScreenTab();

  @override
  _HomeScreenTabState createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const TabBar(
                indicatorColor: primaryColor,
                labelColor: primaryColor,
                unselectedLabelColor: Colors.black87,
                labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w600),
                tabs: [
                  Tab(
                    text: 'Apple',
                  ),
                  Tab(text: 'Summary'),
                  Tab(text: 'Blogs'),
                  Tab(text: 'Goals'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5, color: Colors.grey[300])),
                              height: Get.height * .73,
                              width: Get.width * .92,
                              child: Column(
                                children: [
                                  HomeSubTabs(),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: Get.height * .9,
                        width: Get.width,
                        child: Center(
                            child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Colors.grey[300])),
                          height: Get.height * .65,
                          width: Get.width,
                          child: Column(
                            children: [
                              Row(
                                children: [],
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                    Icon(Icons.directions_bike),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
