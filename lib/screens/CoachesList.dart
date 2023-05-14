import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/chat/DetailChatScreen.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';

import 'package:weight_loser/screens/food_screens/DietTabView.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

class CoachesList extends StatefulWidget {
  const CoachesList({Key key}) : super(key: key);

  @override
  _CoachesListState createState() => _CoachesListState();
}

int _indexOfTab = 0;
TabController _tabController;

class _CoachesListState extends State<CoachesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? titleAppBar(context: context, title: "Coaches List")
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                  child: Column(
                children: [
                  // Expanded(
                  //     child: TabBarView(
                  //       controller: _tabController,
                  //  children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Padding(
                      padding: Responsive1.isDesktop(context)
                          ? const EdgeInsets.only(left: 100, right: 100)
                          : const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: MySize.size26,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MySize.size20, top: MySize.size30),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DDText(
                                      title: "24/7",
                                      color: primaryColor,
                                      weight: FontWeight.w300,
                                    ),
                                    DDText(
                                      title: "How can we help?",
                                      color: primaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MySize.size26,
                          ),
                          Container(
                            child: Divider(
                              color: Color(0xffF8F8FA),
                              thickness: 5,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(MySize.size20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Responsive1.isMobile(context)
                                        ? Get.to(DetailChatScreen(
                                            title: "Diet Coach",
                                          ))
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 300,
                                                          right: 300,
                                                          bottom: 50,
                                                          top: 50),
                                                  child: DetailChatScreen(
                                                    title: "Diet Coach",
                                                  ),
                                                ));
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) {
                                    //   return DetailChatScreen(
                                    //     title: "Diet Coach",
                                    //   );
                                    // }));
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MySize.size14),
                                        child: Image.asset(
                                            "assets/icons/diet_coach.png"),
                                      ),
                                      DDText(title: "Diet Coach"),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: MySize.size14,
                                    color: Color(0xffafafaf)),
                              ],
                            ),
                          ),
                          Container(
                            child: Divider(
                              color: Color(0xffF8F8FA),
                              thickness: 5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Responsive1.isMobile(context)
                                  ? Get.to(DetailChatScreen(
                                      title: "Exercise Coach",
                                    ))
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 300,
                                                right: 300,
                                                bottom: 50,
                                                top: 50),
                                            child: DetailChatScreen(
                                              title: "Exercise Coach",
                                            ),
                                          ));
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return DetailChatScreen(
                              //     title: "Exercise Coach",
                              //   );
                              // }));
                            },
                            child: Container(
                              padding: EdgeInsets.all(MySize.size20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MySize.size14),
                                        child: Image.asset(
                                            "assets/icons/exercise_coach.png"),
                                      ),
                                      DDText(title: "Exercise Coach"),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      size: MySize.size14,
                                      color: Color(0xffafafaf)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Divider(
                              color: Color(0xffF8F8FA),
                              thickness: 5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //Responsive1.isMobile(context)?
                              Get.to(() => DetailChatScreen(
                                    title: "Therapy Coach",
                                  ));
                              /*
                                      :  showDialog(
                                          context: context,
                                          builder: (BuildContext context) => Padding(
                                            padding: const EdgeInsets.only(left: 300,right: 300,bottom: 50,top: 50),
                                            child:DetailChatScreen(
                                              title: "Therapy Coach",
                                            ),
                                          ));
                                          */
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return DetailChatScreen(
                              //     title: "Therapy Coach",
                              //   );
                              // }));
                            },
                            child: Container(
                              padding: EdgeInsets.all(MySize.size20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MySize.size14),
                                        child: Image.asset(
                                            "assets/icons/therapy_coach.png"),
                                      ),
                                      DDText(title: "Therapy Coach"),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      size: MySize.size14,
                                      color: Color(0xffafafaf)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Divider(
                              color: Color(0xffF8F8FA),
                              thickness: 5,
                            ),
                          ),
                          /*
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(MySize.size20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MySize.size14),
                                        child: Image.asset(
                                            "assets/icons/faqs.png"),
                                      ),
                                      DDText(title: "FAQs"),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      size: MySize.size14,
                                      color: Color(0xffafafaf)),
                                ],
                              ),
                            ),
                          ),
                          
                          Container(
                            child: Divider(
                              color: Color(0xffF8F8FA),
                              thickness: 5,
                            ),
                          ),
                          */
                        ],
                      ),
                    ),
                  ),
                  // DietTabView(),
                  // RunningTabView(),
                  // MindTabView(),
                ],
                //)
              )
                  // ],
                  ),
            ),
            //),
          ],
        ),
      ),
    );
    // return DefaultTabController(
    //   length: 4,
    //   child: Scaffold(
    //     drawer: CustomDrawer(),
    //     appBar: customAppBar(
    //       context,
    //       elevation: 0.5,
    //       tabBar: TabBar(
    //         controller: _tabController,
    //         onTap: (index) {
    //           setState(() {
    //             _indexOfTab = index;
    //           });
    //         },
    //         labelPadding: EdgeInsets.only(left: MySize.size4),
    //         indicatorColor: _indexOfTab == 0
    //             ? Colors.transparent
    //             : _indexOfTab == 1
    //                 ? Colors.blue
    //                 : Colors.blue,
    //         labelColor: _indexOfTab == 0 ? Colors.black : Color(0xff4885ED),
    //         indicatorSize: TabBarIndicatorSize.label,
    //         unselectedLabelColor: Colors.black87,
    //         tabs: [
    //           Tab(
    //             text: 'Today',
    //           ),
    //           Tab(text: 'Diet'),
    //           Tab(text: 'Exercise'),
    //           Tab(text: 'Mind'),
    //         ],
    //       ),
    //     ),
    //     body: Container(
    //       color: Colors.white,
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: Container(
    //               child: Column(
    //                 children: [
    //                   Expanded(
    //                       child: TabBarView(
    //                     controller: _tabController,
    //                     children: [
    //                       SingleChildScrollView(
    //                         physics: BouncingScrollPhysics(
    //                             parent: AlwaysScrollableScrollPhysics()),
    //                         child: Column(
    //                           children: [
    //                             // SizedBox(
    //                             //   height: MySize.size26,
    //                             // ),
    //                             Padding(
    //                               padding: EdgeInsets.only(
    //                                   left: MySize.size20, top: MySize.size30),
    //                               child: Row(
    //                                 children: [
    //                                   Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       DDText(
    //                                         title: "24/7",
    //                                         color: Color(0xff4885ED),
    //                                         weight: FontWeight.w300,
    //                                       ),
    //                                       DDText(
    //                                         title: "How can we help?",
    //                                         color: Color(0xff4885ED),
    //                                         weight: FontWeight.w500,
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: MySize.size26,
    //                             ),
    //                             Container(
    //                               child: Divider(
    //                                 color: Color(0xffF8F8FA),
    //                                 thickness: 5,
    //                               ),
    //                             ),
    //                             Container(
    //                               padding: EdgeInsets.all(MySize.size20),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   GestureDetector(
    //                                     onTap: () {
    //                                       Get.to(DetailChatScreen(
    //                                         title: "Diet Coach",
    //                                       ));
    //                                       // Navigator.push(context,
    //                                       //     MaterialPageRoute(
    //                                       //         builder: (context) {
    //                                       //   return DetailChatScreen(
    //                                       //     title: "Diet Coach",
    //                                       //   );
    //                                       // }));
    //                                     },
    //                                     child: Row(
    //                                       children: [
    //                                         Padding(
    //                                           padding: EdgeInsets.only(
    //                                               right: MySize.size14),
    //                                           child: Image.asset(
    //                                               "assets/icons/diet_coach.png"),
    //                                         ),
    //                                         DDText(title: "Diet Coach"),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   Icon(Icons.arrow_forward_ios,
    //                                       size: MySize.size14,
    //                                       color: Color(0xffafafaf)),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               child: Divider(
    //                                 color: Color(0xffF8F8FA),
    //                                 thickness: 5,
    //                               ),
    //                             ),
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Get.to(DetailChatScreen(
    //                                   title: "Exercise Coach",
    //                                 ));
    //                                 // Navigator.push(context,
    //                                 //     MaterialPageRoute(builder: (context) {
    //                                 //   return DetailChatScreen(
    //                                 //     title: "Exercise Coach",
    //                                 //   );
    //                                 // }));
    //                               },
    //                               child: Container(
    //                                 padding: EdgeInsets.all(MySize.size20),
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         Padding(
    //                                           padding: EdgeInsets.only(
    //                                               right: MySize.size14),
    //                                           child: Image.asset(
    //                                               "assets/icons/exercise_coach.png"),
    //                                         ),
    //                                         DDText(title: "Exercise Coach"),
    //                                       ],
    //                                     ),
    //                                     Icon(Icons.arrow_forward_ios,
    //                                         size: MySize.size14,
    //                                         color: Color(0xffafafaf)),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                             Container(
    //                               child: Divider(
    //                                 color: Color(0xffF8F8FA),
    //                                 thickness: 5,
    //                               ),
    //                             ),
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Get.to(()=>DetailChatScreen(
    //                                   title: "Therapy Coach",
    //                                 ));
    //                                 // Navigator.push(context,
    //                                 //     MaterialPageRoute(builder: (context) {
    //                                 //   return DetailChatScreen(
    //                                 //     title: "Therapy Coach",
    //                                 //   );
    //                                 // }));
    //                               },
    //                               child: Container(
    //                                 padding: EdgeInsets.all(MySize.size20),
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         Padding(
    //                                           padding: EdgeInsets.only(
    //                                               right: MySize.size14),
    //                                           child: Image.asset(
    //                                               "assets/icons/therapy_coach.png"),
    //                                         ),
    //                                         DDText(title: "Therapy Coach"),
    //                                       ],
    //                                     ),
    //                                     Icon(Icons.arrow_forward_ios,
    //                                         size: MySize.size14,
    //                                         color: Color(0xffafafaf)),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                             Container(
    //                               child: Divider(
    //                                 color: Color(0xffF8F8FA),
    //                                 thickness: 5,
    //                               ),
    //                             ),
    //                             Container(
    //                               padding: EdgeInsets.all(MySize.size20),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Row(
    //                                     children: [
    //                                       Padding(
    //                                         padding: EdgeInsets.only(
    //                                             right: MySize.size14),
    //                                         child: Image.asset(
    //                                             "assets/icons/faqs.png"),
    //                                       ),
    //                                       DDText(title: "FAQs"),
    //                                     ],
    //                                   ),
    //                                   Icon(Icons.arrow_forward_ios,
    //                                       size: MySize.size14,
    //                                       color: Color(0xffafafaf)),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               child: Divider(
    //                                 color: Color(0xffF8F8FA),
    //                                 thickness: 5,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       DietTabView(),
    //                       RunningTabView(),
    //                       MindTabView(),
    //                     ],
    //                   ))
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
