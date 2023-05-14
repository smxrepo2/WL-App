import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/SettingScreen/eating_habits.dart';
import 'package:weight_loser/widget/Choice%20Chip%20Dialog.dart';
import 'package:weight_loser/widget/dialog.dart';

import 'components.dart';

class MindSetting extends StatefulWidget {
  const MindSetting({Key key}) : super(key: key);

  @override
  _MindSettingState createState() => _MindSettingState();
}

class _MindSettingState extends State<MindSetting> {
  bool featureVideoValue = false;
  bool mentalValue = false;

  List<String> foodCarving = [
    "Pizza",
    "Burger",
    "Soda",
    "Coffee",
    "Alcohol",
    "Buttered popcorn",
    "Chocolate",
    "Steak",
    "Sweet candy",
    "Cheese",
    "Franch Fries",
    "Ice Cream"
  ];
  List<String> selectedFoodList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    print("tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Mind',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            rowWithEditIcon(
                context: context,
                image: 'assets/svg_icons/eatinghabit_svg.svg',
                option: 'Eating Habit',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EatingHabits()));
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            /*
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SvgPicture.asset(
                    'assets/svg_icons/featurevideo_svg.svg',
                    color: primaryColor,
                    height: 30,
                    width: 35,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Feature Video',
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CupertinoSwitch(
                    activeColor: Colors.blue,
                    value: featureVideoValue,
                    onChanged: (v) => setState(() => featureVideoValue = v),
                  ),
                )
              ],
            ),
            */
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            // FutureBuilder(
            //   future: getHabitData(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData &&
            //         snapshot.connectionState == ConnectionState.done) {
            //       var p = Provider.of<UserDataProvider>(context,listen: false);
            //       var checking = snapshot.data["CraveFoods"];
            //       checking = checking.replaceAll("[", "")
            //           .replaceAll("]", "")
            //           .replaceAll(" ", "");
            //       selectedFoodList = checking.split(',');
            //       selectedFoodList = selectedFoodList.toSet().toList();
            //       p.updateFoodCravingList(selectedFoodList);
            //       return Consumer<UserDataProvider>(
            //         builder: (BuildContext context, value, Widget child) {
            //           return Column(
            //             children: [
            //               listTileComponent(
            //                   oNTap: () {
            //                     showDialog(
            //                         context: context,
            //                         builder: (_) {
            //                           return StatefulBuilder(
            //                               builder: (context, setState) {
            //                                 return AlertDialog(
            //                                   insetPadding: EdgeInsets.all(0),
            //                                   content: Container(
            //                                     height: 500,
            //                                     width: 300,
            //                                     child: ListView.builder(
            //                                         physics: const BouncingScrollPhysics(),
            //                                         itemCount: foodCarving.length,
            //                                         itemBuilder: (context, index) {
            //                                           return Padding(
            //                                             padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
            //                                             child: InkWell(
            //                                               onTap: () {
            //                                                 setState(() {
            //                                                   if(!selectedFoodList.contains(foodCarving[index])){
            //                                                     selectedFoodList.add(foodCarving[index]);
            //                                                   }
            //                                                 });
            //                                               },
            //                                               child: ListTile(
            //                                                 shape: RoundedRectangleBorder(
            //                                                   side: BorderSide(
            //                                                       color: selectedFoodList.contains(foodCarving[index])
            //                                                           ? const Color(0xff4885ED)
            //                                                           : const Color(0xffdfdfdf),
            //                                                       width: selectedFoodList.contains(foodCarving[index]) ? 2 : 1),
            //                                                   borderRadius: BorderRadius.circular(10),
            //                                                 ),
            //                                                 minLeadingWidth: 0,
            //                                                 title: Text(
            //                                                   foodCarving[index],
            //                                                   style: const TextStyle(
            //                                                     fontFamily: 'Open Sans',
            //                                                     fontSize: 15,
            //                                                     color: Color(0xff23233c),
            //                                                     letterSpacing: -0.44999999999999996,
            //                                                     fontWeight: FontWeight.w500,
            //                                                   ),
            //                                                   softWrap: false,
            //                                                 ),
            //                                               ),
            //                                             ),
            //                                           );
            //                                         }),
            //                                   ),
            //                                   actions: [
            //                                     TextButton(
            //                                       child: Text("Cancel"),
            //                                       onPressed: () {
            //                                         Navigator.pop(context);
            //                                       },
            //                                     ),
            //                                     TextButton(
            //                                       child: Text("Update"),
            //                                       onPressed: () {
            //                                         if(selectedFoodList.isNotEmpty){
            //                                           updateFoodCraving(
            //                                               selectedFoodList.toString());
            //                                           value.updateFoodCravingList(selectedFoodList);
            //                                           Navigator.pop(context);
            //                                         }
            //                                       },
            //                                     ),
            //                                   ],
            //                                 );
            //                               });
            //                         });
            //                   },
            //                   context: context,
            //                   title: 'Food Craving',
            //                   subtitle: value.foodCraving.toString()
            //                       .replaceAll("[", "")
            //                       .replaceAll("]", "") ??
            //                       "Pizza",
            //                   image: 'assets/svg_icons/food_svg.svg'),
            //             ],
            //           );
            //         },);
            //     } else if (snapshot.hasError) {
            //       return Center(
            //         child: Text('unable to load data'),
            //       );
            //     }
            //     // By default, show a loading spinner.
            //     return Center();
            //   },
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            /*
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child:
                      SvgPicture.asset('assets/svg_icons/remider_svg.svg',
                      color: primaryColor,height: 30,
                        width: 35,),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Mental Exercise Reminder',
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CupertinoSwitch(
                    activeColor: Colors.blue,
                    value: mentalValue,
                    onChanged: (v) => setState(() => mentalValue = v),
                  ),
                )
              ],
            ),
            */
          ],
        ),
      ),
    );
  }
}
