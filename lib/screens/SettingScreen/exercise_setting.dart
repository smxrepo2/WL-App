import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/Choice%20Chip%20Dialog.dart';
import '../Questions_screen/models/all_questions_model.dart';
import 'components.dart';
import 'package:weight_loser/widget/radio.dart';

class ExerciseSetting extends StatefulWidget {
  const ExerciseSetting({Key key}) : super(key: key);

  @override
  _ExerciseSettingState createState() => _ExerciseSettingState();
}

class _ExerciseSettingState extends State<ExerciseSetting> {
  // List<String> exType = [
  //   "Weights",
  //   "Yoga",
  //   "Pilates",
  //   "Kickboxing or Martial arts",
  //   "Stairs",
  //   "Running",
  //   "Walking",
  //   "Cycling",
  //   "Swimming",
  //   "Any Sports"
  // ];
  // List<String> bodyType = ['Pear-shaped', 'Apple-shaped', 'Pot Belly'];
  int selectedCurrentLife = -1;
  int selectedGymMember;
  String selectedMobility;
  int selectedCanYouDo = -1;
  int selectedExerciseType = -1;
  int selectedBodyType = -1;
  int selectedHowOftenYouGoToGym;
  // List<String> currentLife = [
  //   'I focus on diet and exercise.',
  //   'I watch my diet, but I am not active.',
  //   'I am active and do daily exercise,but I cannot control my eating.'
  // ];
  List<String> minutesEx = [
    'Yes',
    'No',
  ];
  List<String> gym = [
    'Yes',
    'No',
  ];
  List<String> selectedExType = [];
  List<String> mobilityOptions;
  List<String> howOftenGymOption;
  String exerciseT;

  Future<GetAllQuestionsModel> GetAllQueestions() async {
    final response = await get(Uri.parse('$apiUrl/api/Questionair'));

    if (response.statusCode == 200) {
      GetAllQuestionsModel _data =
          GetAllQuestionsModel.fromJson(jsonDecode(response.body));
      print("response:" + response.statusCode.toString());
      mobilityOptions = _data.questoins[14].options
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("\"", "")
          .split(",");
      howOftenGymOption = _data.questoins[13].options
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("\"", "")
          .split(",");
      setState(() {});
      return _data;
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAllQueestions();
  }

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
                      'Exercise',
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
            FutureBuilder(
              future: getExerciseData(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  var p = Provider.of<UserDataProvider>(context, listen: false);
                  p.updateEverydayMobility(snapshot.data["Routine"] ?? '-');
                  p.updateHowOfterYouGoToGym(
                      snapshot.data["ActivityLevel"] ?? '-');
                  p.updateGymMember(snapshot.data["MemberShip"] ?? '-');
                  p.updateBodyType(snapshot.data["BodyType"] ?? '-');
                  p.updatesevenMinuteExercise(
                      snapshot.data["MinExercise"] ?? '-');
                  p.updateExerciseType(snapshot.data["ExerciseType"] ?? '-');
                  selectedMobility = snapshot.data["Routine"];
                  selectedHowOftenYouGoToGym =
                      snapshot.data["ActivityLevel"] - 1;
                  String memberShip = snapshot.data["MemberShip"];
                  String bodyT = snapshot.data["BodyType"];
                  String sevenMin = snapshot.data["MinExercise"];
                  exerciseT = snapshot.data["ExerciseType"];
                  if (memberShip == 'Yes') {
                    selectedGymMember = 0;
                  } else {
                    selectedGymMember = 1;
                  }
                  if (bodyT == 'Pear-shaped') {
                    selectedBodyType = 0;
                  } else if (bodyT == 'Apple-shaped') {
                    selectedBodyType = 1;
                  } else {
                    selectedBodyType = 2;
                  }
                  if (sevenMin == 'Yes') {
                    selectedCanYouDo = 0;
                  } else {
                    selectedCanYouDo = 1;
                  }
                  return Consumer<UserDataProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      return Column(
                        children: [
                          // listTileComponent(
                          //     oNTap: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (_) {
                          //             return StatefulBuilder(
                          //                 builder: (context, setState) {
                          //                   return AlertDialog(
                          //                     insetPadding: EdgeInsets.all(0),
                          //                     content: Container(
                          //                       height: 300,
                          //                       width: 300,
                          //                       child: ListView.builder(
                          //                           physics: const BouncingScrollPhysics(),
                          //                           itemCount: currentLife.length,
                          //                           itemBuilder: (context, index) {
                          //                             return Padding(
                          //                               padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
                          //                               child: InkWell(
                          //                                 onTap: () {
                          //                                   setState(() {
                          //                                     selectedCurrentLife = index;
                          //                                   });
                          //                                 },
                          //                                 child: ListTile(
                          //                                   shape: RoundedRectangleBorder(
                          //                                     side: BorderSide(
                          //                                         color: selectedCurrentLife == index
                          //                                             ? const Color(0xff4885ED)
                          //                                             : const Color(0xffdfdfdf),
                          //                                         width: selectedCurrentLife == index ? 2 : 1),
                          //                                     borderRadius: BorderRadius.circular(10),
                          //                                   ),
                          //                                   minLeadingWidth: 0,
                          //                                   title: Text(
                          //                                     currentLife[index],
                          //                                     style: const TextStyle(
                          //                                       fontFamily: 'Open Sans',
                          //                                       fontSize: 15,
                          //                                       color: Color(0xff23233c),
                          //                                       letterSpacing: -0.44999999999999996,
                          //                                       fontWeight: FontWeight.w500,
                          //                                     ),
                          //                                     softWrap: false,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             );
                          //                           }),
                          //                     ),
                          //                     actions: [
                          //                       TextButton(
                          //                         child: Text("Cancel"),
                          //                         onPressed: () {
                          //                           Navigator.pop(context);
                          //                         },
                          //                       ),
                          //                       TextButton(
                          //                         child: Text("Update"),
                          //                         onPressed: () {
                          //                           if(selectedCurrentLife != -1){
                          //                             value.updateCurrentLifeStyle(currentLife[selectedCurrentLife]);
                          //                             // updateExerciseType(currentLife[selectedCurrentLife]);
                          //                             Navigator.pop(context);
                          //                           }
                          //                         },
                          //                       ),
                          //                     ],
                          //                   );
                          //                 });
                          //           });
                          //       // selectCurrentLife(context, "Current LifeStyle")
                          //       //     .then((value) {
                          //       //   setState(() {});
                          //       // });
                          //     },
                          //     context: context,
                          //     title: 'Current Lifestyle',
                          //     subtitle: value.currentLifeStyle,
                          //     image: 'assets/svg_icons/lifestyle_svg.svg'),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.02,
                          // ),
                          listTileComponent(
                            oNTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(0),
                                        content: Container(
                                          height: 150,
                                          width: 300,
                                          child: ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: gym.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12.5,
                                                      horizontal: 30),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedGymMember =
                                                            index;
                                                      });
                                                    },
                                                    child: ListTile(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: selectedGymMember ==
                                                                    index
                                                                ? const Color(
                                                                    0xff4885ED)
                                                                : const Color(
                                                                    0xffdfdfdf),
                                                            width:
                                                                selectedGymMember ==
                                                                        index
                                                                    ? 2
                                                                    : 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      minLeadingWidth: 0,
                                                      title: Text(
                                                        gym[index],
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff23233c),
                                                          letterSpacing:
                                                              -0.44999999999999996,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        softWrap: false,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                              if (selectedGymMember != -1) {
                                                updateMembership(
                                                    gym[selectedGymMember]);
                                                value.updateGymMember(
                                                    gym[selectedGymMember]);
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            },
                            context: context,
                            title: 'Gym Membership',
                            subtitle: value.gymMember,
                            image: 'assets/svg_icons/gym_svg.svg',
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.02,
                          // ),
                          // listTileComponent(
                          //     oNTap: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (_) {
                          //             return StatefulBuilder(
                          //                 builder: (context, setState) {
                          //                   return AlertDialog(
                          //                     insetPadding: EdgeInsets.all(0),
                          //                     content: Container(
                          //                       height: 500,
                          //                       width: 300,
                          //                       child: ListView.builder(
                          //                           physics: const BouncingScrollPhysics(),
                          //                           itemCount: exType.length,
                          //                           itemBuilder: (context, index) {
                          //                             return Padding(
                          //                               padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
                          //                               child: InkWell(
                          //                                 onTap: () {
                          //                                   setState((){
                          //                                     selectedExerciseType = index;
                          //                                     exerciseT = exType[index];
                          //                                   });
                          //                                 },
                          //                                 child: ListTile(
                          //                                   shape: RoundedRectangleBorder(
                          //                                     side: BorderSide(
                          //                                         color: exType[index] == exerciseT
                          //                                             ? const Color(0xff4885ED)
                          //                                             : const Color(0xffdfdfdf),
                          //                                         width: exType[index] == exerciseT ? 2 : 1),
                          //                                     borderRadius: BorderRadius.circular(10),
                          //                                   ),
                          //                                   minLeadingWidth: 0,
                          //                                   title: Text(
                          //                                     exType[index],
                          //                                     style: const TextStyle(
                          //                                       fontFamily: 'Open Sans',
                          //                                       fontSize: 15,
                          //                                       color: Color(0xff23233c),
                          //                                       letterSpacing: -0.44999999999999996,
                          //                                       fontWeight: FontWeight.w500,
                          //                                     ),
                          //                                     softWrap: false,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             );
                          //                           }),
                          //                     ),
                          //                     actions: [
                          //                       TextButton(
                          //                         child: Text("Cancel"),
                          //                         onPressed: () {
                          //                           Navigator.pop(context);
                          //                         },
                          //                       ),
                          //                       TextButton(
                          //                         child: Text("Update"),
                          //                         onPressed: () {
                          //                           if(selectedExerciseType != -1){
                          //                             updateExerciseType(exType[selectedExerciseType]);
                          //                             value.updateExerciseType(exType[selectedExerciseType]);
                          //                             Navigator.pop(context);
                          //                           }
                          //                         },
                          //                       ),
                          //                     ],
                          //                   );
                          //                 });
                          //           });
                          //     },
                          //     context: context,
                          //     title: 'Exercise Type',
                          //     subtitle: value.exerciseType,
                          //     image: 'assets/svg_icons/exercise_svg.svg'),
                          // listTileComponent(
                          //     oNTap: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (_) {
                          //             return StatefulBuilder(
                          //                 builder: (context, setState) {
                          //                   return AlertDialog(
                          //                     insetPadding: EdgeInsets.all(0),
                          //                     content: Container(
                          //                       height: 300,
                          //                       width: 300,
                          //                       child: ListView.builder(
                          //                           physics: const BouncingScrollPhysics(),
                          //                           itemCount: bodyType.length,
                          //                           itemBuilder: (context, index) {
                          //                             return Padding(
                          //                               padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
                          //                               child: InkWell(
                          //                                 onTap: () {
                          //                                   setState(() {
                          //                                     selectedBodyType = index;
                          //                                   });
                          //                                 },
                          //                                 child: ListTile(
                          //                                   shape: RoundedRectangleBorder(
                          //                                     side: BorderSide(
                          //                                         color: selectedBodyType == index
                          //                                             ? const Color(0xff4885ED)
                          //                                             : const Color(0xffdfdfdf),
                          //                                         width: selectedBodyType == index ? 2 : 1),
                          //                                     borderRadius: BorderRadius.circular(10),
                          //                                   ),
                          //                                   minLeadingWidth: 0,
                          //                                   title: Text(
                          //                                     bodyType[index],
                          //                                     style: const TextStyle(
                          //                                       fontFamily: 'Open Sans',
                          //                                       fontSize: 15,
                          //                                       color: Color(0xff23233c),
                          //                                       letterSpacing: -0.44999999999999996,
                          //                                       fontWeight: FontWeight.w500,
                          //                                     ),
                          //                                     softWrap: false,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             );
                          //                           }),
                          //                     ),
                          //                     actions: [
                          //                       TextButton(
                          //                         child: Text("Cancel"),
                          //                         onPressed: () {
                          //                           Navigator.pop(context);
                          //                         },
                          //                       ),
                          //                       TextButton(
                          //                         child: Text("Update"),
                          //                         onPressed: () {
                          //                           if(selectedBodyType != -1){
                          //                             updateBodyType(bodyType[selectedBodyType]);
                          //                             value.updateBodyType(bodyType[selectedBodyType]);
                          //                             Navigator.pop(context);
                          //                           }
                          //                         },
                          //                       ),
                          //                     ],
                          //                   );
                          //                 });
                          //           });
                          //     },
                          //     context: context,
                          //     title: 'Body Type',
                          //     subtitle: value.bodyType,
                          //     image: 'assets/svg_icons/bodytype_svg.svg'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponent(
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 150,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: minutesEx.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedCanYouDo =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedCanYouDo ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedCanYouDo ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          minutesEx[index],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff23233c),
                                                            letterSpacing:
                                                                -0.44999999999999996,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          softWrap: false,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                if (selectedCanYouDo != -1) {
                                                  updateMinExercise(minutesEx[
                                                      selectedCanYouDo]);
                                                  value.updatesevenMinuteExercise(
                                                      minutesEx[
                                                          selectedCanYouDo]);
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              },
                              context: context,
                              title: 'Can do 10 minutes exercise',
                              subtitle: value.sevenMinuteExercise,
                              image: 'assets/svg_icons/workout_svg.svg'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponent(
                            oNTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(0),
                                        content: Container(
                                          height: 400,
                                          width: 300,
                                          child: ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: mobilityOptions.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12.5,
                                                      horizontal: 30),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedMobility =
                                                            mobilityOptions[
                                                                index];
                                                      });
                                                    },
                                                    child: ListTile(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: mobilityOptions[
                                                                        index] ==
                                                                    selectedMobility
                                                                ? const Color(
                                                                    0xff4885ED)
                                                                : const Color(
                                                                    0xffdfdfdf),
                                                            width: mobilityOptions[
                                                                        index] ==
                                                                    selectedMobility
                                                                ? 2
                                                                : 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      minLeadingWidth: 0,
                                                      title: Text(
                                                        mobilityOptions[index],
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff23233c),
                                                          letterSpacing:
                                                              -0.44999999999999996,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        softWrap: false,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                              value.updateEverydayMobility(
                                                  selectedMobility);
                                              Navigator.pop(context);
                                              updateLifeStyle(selectedMobility);
                                              // if(selectedGymMember != -1){
                                              //   updateEv(gym[selectedGymMember]);
                                              //   value.updateEverydayMobility(selectedMobility);
                                              //   Navigator.pop(context);
                                              // }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            },
                            context: context,
                            title:
                                'How can you describe your everyday mobility?',
                            subtitle: value.everydayMobility,
                            image: 'assets/svg_icons/gym_svg.svg',
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          // listTileComponent(
                          //   oNTap: () {
                          //     showDialog(
                          //         context: context,
                          //         builder: (_) {
                          //           return StatefulBuilder(
                          //               builder: (context, setState) {
                          //                 return AlertDialog(
                          //                   insetPadding: EdgeInsets.all(0),
                          //                   content: Container(
                          //                     height: 400,
                          //                     width: 300,
                          //                     child: ListView.builder(
                          //                         physics: const BouncingScrollPhysics(),
                          //                         itemCount: howOftenGymOption.length,
                          //                         itemBuilder: (context, index) {
                          //                           return Padding(
                          //                             padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
                          //                             child: InkWell(
                          //                               onTap: () {
                          //                                 setState(() {
                          //                                   selectedHowOftenYouGoToGym = index;
                          //                                 });
                          //                               },
                          //                               child: ListTile(
                          //                                 shape: RoundedRectangleBorder(
                          //                                   side: BorderSide(
                          //                                       color: selectedHowOftenYouGoToGym == index
                          //                                           ? const Color(0xff4885ED)
                          //                                           : const Color(0xffdfdfdf),
                          //                                       width: selectedHowOftenYouGoToGym == index ? 2 : 1),
                          //                                   borderRadius: BorderRadius.circular(10),
                          //                                 ),
                          //                                 minLeadingWidth: 0,
                          //                                 title: Text(
                          //                                   howOftenGymOption[index],
                          //                                   style: const TextStyle(
                          //                                     fontFamily: 'Open Sans',
                          //                                     fontSize: 15,
                          //                                     color: Color(0xff23233c),
                          //                                     letterSpacing: -0.44999999999999996,
                          //                                     fontWeight: FontWeight.w500,
                          //                                   ),
                          //                                   softWrap: false,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           );
                          //                         }),
                          //                   ),
                          //                   actions: [
                          //                     TextButton(
                          //                       child: Text("Cancel"),
                          //                       onPressed: () {
                          //                         Navigator.pop(context);
                          //                       },
                          //                     ),
                          //                     TextButton(
                          //                       child: Text("Update"),
                          //                       onPressed: () {
                          //                         value.updateHowOfterYouGoToGym(selectedHowOftenYouGoToGym + 1);
                          //                         Navigator.pop(context);
                          //                         // if(selectedGymMember != -1){
                          //                         //   updateExerciseType(gym[selectedGymMember]);
                          //                         //   value.updateGymMember(gym[selectedGymMember]);
                          //                         //   Navigator.pop(context);
                          //                         // }
                          //                       },
                          //                     ),
                          //                   ],
                          //                 );
                          //               });
                          //         });
                          //   },
                          //   context: context,
                          //   title: 'How often do you go to a gym?',
                          //   subtitle: howOftenGymOption == null ? '-' : howOftenGymOption[value.howOfterYouGoToGym - 1],
                          //   image: 'assets/svg_icons/gym_svg.svg',
                          // ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('unable to load data'),
                  );
                }
                // By default, show a loading spinner.
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
