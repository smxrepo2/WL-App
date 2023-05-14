import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDToast.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/Shimmer/Food%20Dialog%20Shimmer.dart';

List<String> types = [
  'All Cuisines',
  'Indians',
  'Thai',
  'Italian',
  'Mexican',
];
int selectedIndex = 0;
//int selectedEatingTime = 0;
int ingredientOrProcedure = 0;
SimpleFontelicoProgressDialog _dialog;

showFoodDialog(
    BuildContext context,
    Function() success,
    title,
    serving,
    cal,
    carb,
    fat,
    protein,
    description,
    imageurl,
    mealtype,
    selectedEatingTime,
    foodId) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      var id = int.parse(foodId);
      print(id);
      var other;
      return StatefulBuilder(
        builder: (context, setState) {
          var size = MediaQuery.of(context).size.width;
          var mobile = Responsive1.isMobile(context);
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: Responsive1.isMobile(context)
                  ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.only(left: 400, right: 400, top: 10),
              child: Container(
                width: Responsive1.isMobile(context) ? double.infinity : 500,
                height: Responsive1.isMobile(context) ? double.infinity : 560,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            mobile ? EdgeInsets.all(8.0) : EdgeInsets.all(2.0),
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.20
                                    : size * 0.15,
                                height: mobile
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : size * 0.09,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: Image.network(imageurl)
                                            //'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                            .image,
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : size * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    width: 165,
                                    child: Text(
                                      title,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.002,
                                  ),
                                  Text(
                                    '${serving} Serving, ${serving} grams',
                                    style: GoogleFonts.openSans(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    // width:55,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: FutureBuilder(
                                        future: fetchOtherDetail(id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.connectionState ==
                                                  ConnectionState.done) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                snapshot.data['Cuisine'] ??
                                                    "indian",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            );
                                          } else if (snapshot.hasData &&
                                              snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "indian",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            );
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "  ",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        }),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       // width:55,
                                  //       height: 25,
                                  //       decoration: BoxDecoration(
                                  //           border:
                                  //               Border.all(color: Colors.grey),
                                  //           borderRadius:
                                  //               BorderRadius.circular(100)),
                                  //       child: FutureBuilder(
                                  //           future: fetchOtherDetail(id),
                                  //           builder: (context, snapshot) {
                                  //             return Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(4.0),
                                  //               child: Text(
                                  //                 snapshot.data['Cuisine'],
                                  //                 style: GoogleFonts.montserrat(
                                  //                     fontSize: 10,
                                  //                     color: Colors.grey),
                                  //               ),
                                  //             );
                                  //           }),
                                  //     ),
                                  //     // SizedBox(
                                  //     //   width: MediaQuery.of(context).size.width *
                                  //     //       0.02,
                                  //     // ),
                                  //     // Container(
                                  //     //   decoration: BoxDecoration(
                                  //     //       color: Colors.red[100],
                                  //     //       borderRadius:
                                  //     //           BorderRadius.circular(100)),
                                  //     //   child: Padding(
                                  //     //     padding: const EdgeInsets.symmetric(
                                  //     //         vertical: 4, horizontal: 10),
                                  //     //     child: Text(
                                  //     //       'Keton: Avoid',
                                  //     //       style: GoogleFonts.montserrat(
                                  //     //           fontSize: 9, color: Colors.red),
                                  //     //     ),
                                  //     //   ),
                                  //     // )
                                  //   ],
                                  // )
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : size * 0.07,
                                height: mobile
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : size * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cals',
                                      style: GoogleFonts.openSans(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    Text(
                                      "${cal.toString()}",
                                      style: GoogleFonts.openSans(
                                          color: Colors.black, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : size * .02,
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: Responsive1.isMobile(context),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Carb',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${carb}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Fat',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${fat}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Protein',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${protein}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Other',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 15,
                                      child: FutureBuilder(
                                          future: fetchOtherDetail(id),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.connectionState ==
                                                    ConnectionState.done) {
                                              return Text(
                                                '${snapshot.data['SatFat'] + snapshot.data['Sodium'] + snapshot.data['Fiber']}g',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              );
                                            } else if (snapshot.hasData &&
                                                snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[100],
                                                child: Text(
                                                  // '${other ?? 0}g',
                                                  '0g',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              );
                                            }
                                            return Text(
                                              // '${other ?? 0}g',
                                              '0g',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: mobile
                            ? EdgeInsets.symmetric(horizontal: 10)
                            : EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 0;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 0
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Morning',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 1;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 1
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Snack',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 2;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 2
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Lunch',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 3;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 3
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Dinner',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Serving Size',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${serving}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Grams',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.01,
                      ),
                      FutureBuilder(
                          future: fetchRecipe1(id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var ab = snapshot.data["Ingredients"];
                              var ingredient = jsonDecode(ab);
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 0;
                                                });
                                              },
                                              child: Text(
                                                'Ingredients',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                0
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 0
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 1;
                                                });
                                              },
                                              child: Text(
                                                'Procedure',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                1
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 1
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: .5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: ingredientOrProcedure == 1
                                            ? snapshot.data['Procedure'] != null
                                                ? Text(
                                                    snapshot.data['Procedure']
                                                        .replaceAll("<p>", "")
                                                        .replaceAll("</p>", "")
                                                        .replaceAll('"', "")
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "")
                                                        .replaceAll('<li>', "")
                                                        .replaceAll("</li>", "")
                                                        .replaceAll("<ul>", "")
                                                        .replaceAll(
                                                            '</ul>', ""),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                  )
                                                : Text("No Data Available")
                                            : ingredientOrProcedure == 0
                                                ? ListView.builder(
                                                    itemCount:
                                                        ingredient.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Text(
                                                        ingredient[index],
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                      );
                                                    })
                                                : "Not Available",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return FoodDialogShimmer();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _dialog = SimpleFontelicoProgressDialog(
                                  context: context, barrierDimisable: true);
                              _dialog.show(
                                  message: "Please wait",
                                  type:
                                      SimpleFontelicoProgressDialogType.normal);
                              print(mealtype);
                              double servingDouble =
                                  double.parse(serving.toString());
                              int servings = servingDouble.toInt();
                              var typeId;
                              if (mealtype == "Breakfast") {
                                typeId = 1;
                              } else if (mealtype == "Lunch") {
                                typeId = 2;
                              } else if (mealtype == "Dinner") {
                                typeId = 3;
                              } else if (mealtype == "Snacks") {
                                typeId = 4;
                              }
                              post(
                                Uri.parse('$apiUrl/api/diary'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "userId": userid,
                                  "F_type_id": typeId,
                                  "FoodId": id.toString(),
                                  "Cons_Cal": cal,
                                  "ServingSize": servings,
                                  "fat": fat,
                                  "Protein": protein,
                                  "Carbs": carb
                                }),
                              ).then((value) {
                                _dialog.hide();

                                print(value.body);

                                Navigator.pop(context);
                                success();
                              }).onError((error, stackTrace) {
                                print(error.toString());
                                _dialog.hide();
                                DDToast().showToast(
                                    "message", error.toString(), true);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add Food',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
    },
  );
}
