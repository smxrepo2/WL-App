import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

class CustomFoodInfo extends StatefulWidget {
  const CustomFoodInfo({Key key}) : super(key: key);

  @override
  _CustomFoodInfoState createState() => _CustomFoodInfoState();
}

Widget headingView(title) {
  return Container(
    padding: EdgeInsets.only(
      left: MySize.size16,
    ),
    child: Container(
      // margin: const EdgeInsets.only(right: 100, left: 10),
      child: DDText(
        title: title,
        size: MySize.size11,
        color: Colors.black,
      ),
    ),
  );
}

class _CustomFoodInfoState extends State<CustomFoodInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: customAppBar(
          context,
          elevation: 0.5,
          /*tabBar: TabBar(
            labelPadding: EdgeInsets.only(left: MySize.size4),
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black87,
            tabs: [
              Tab(
                text: 'Today',
              ),
              Tab(text: 'Diet'),
              Tab(text: 'Exercise'),
              Tab(text: 'Mind'),
            ],
          ),*/
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomStaticBottomNavigationBar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MySize.size36,
              ),
              Row(
                children: [
                  headingView("Custom Food"),
                ],
              ),
              SizedBox(
                height: MySize.size10,
              ),
              Container(
                margin: EdgeInsets.only(left: MySize.size10),
                child: Row(
                  children: [
                    detailFood(context, icon: "assets/icons/fruit.svg", title: "Food Name"),
                  ],
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Container(
                margin: EdgeInsets.only(left: MySize.size10),
                child: Row(
                  children: [
                    detailFood(context, icon: "assets/icons/brand.svg", title: "Brand Name"),
                  ],
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                children: [
                  headingView("Nutrition Info"),
                ],
              ),
              SizedBox(
                height: MySize.size10,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MySize.size16,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xff4885ED),
                          ),
                        ),
                      ),
                      // color: Colors.red,
                      width: 14,
                      height: MySize.size30,
                      // margin: const EdgeInsets.only(right: 100, left: 10),
                      child: TextField(
                        style: GoogleFonts.openSans(fontSize: MySize.size12, color: Colors.black, fontWeight: FontWeight.w300),
                        decoration: new InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 8, left: 2),
                          border: InputBorder.none,
                          hintText: "1",
                          hintStyle: GoogleFonts.openSans(fontSize: MySize.size12, color: Colors.black, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: MySize.size4,
                    // ),
                    DDText(title: "Serving", size: 12, weight: FontWeight.w300),
                  ],
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Container(
                margin: EdgeInsets.only(left: MySize.size10),
                child: Row(
                  children: [
                    detailFood(context, icon: "assets/icons/calories.svg", title: "Calories"),
                  ],
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/fat.svg", title: "Fat (g)"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/saturated-fat.svg", title: "Saturated Fat"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/carbohydrates.svg", title: "Carbohydrates"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/sodium.svg", title: "Sodium (mg)"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/protein.svg", title: "Protein"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/fiber.svg", title: "Fiber (g)"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/sugar-cube.svg", title: "Sugars (g)"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MySize.size10),
                      child: Row(
                        children: [
                          detailFood(context, icon: "assets/icons/cholestrol.svg", title: "Cholesterol (mg)"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MySize.size30,
              ),
              GestureDetector(
                onTap: () {
                  Flushbar(
                    title: "Message",
                    message: "Add Food",
                    duration: Duration(seconds: 2),
                  )..show(context);
                },
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11, right: 11, top: 10, bottom: 8),
                      child: Text(
                        'Add Food',
                        style: style.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailFood(BuildContext context, {icon, title}) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
      decoration: BoxDecoration(border: Border.all(color: Color(0xffdfdfdf)), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(
            width: MySize.size16,
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width / 3,
              height: MySize.size22,
              // margin: const EdgeInsets.only(right: 100, left: 10),
              child: TextField(
                style: GoogleFonts.openSans(fontSize: MySize.size11, color: Colors.black, fontWeight: FontWeight.w300),
                decoration: new InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: title,
                  hintStyle: GoogleFonts.openSans(fontSize: MySize.size11, color: Colors.black, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
