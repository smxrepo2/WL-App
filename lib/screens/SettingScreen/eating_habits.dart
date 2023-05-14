import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/widget/dialog.dart';

import 'components.dart';

class EatingHabits extends StatefulWidget {
  const EatingHabits({Key key}) : super(key: key);

  @override
  _EatingHabitsState createState() => _EatingHabitsState();
}

class _EatingHabitsState extends State<EatingHabits> {
  List<String> options = [
    'Agree',
    'Disagree',
    'I don\'t know',
  ];
  int selectedOption = -1;
  Future<Map<String, dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = getHabitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdfcfa),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/icons/back_arrow.png')),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Eating Habits',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  var p = Provider.of<UserDataProvider>(context, listen: false);
                  p.updateCanControlWhenFood(
                      snapshot.data["Control"] ?? 'I don\'t know');
                  p.updatePreoccupied(
                      snapshot.data["Preoccupied"] ?? 'I don\'t know');
                  p.updateCanControlWhenFoodFree(
                      snapshot.data["FreeFood"] ?? 'I don\'t know');
                  p.updateCanControlWhenFoodAround(
                      snapshot.data["EatingRound"] ?? 'I don\'t know');
                  p.updateFailedDueToCraving(
                      snapshot.data["Cravings"] ?? 'I don\'t know');
                  p.updateEatWhenSad(
                      snapshot.data["SadEating"] ?? 'I don\'t know');
                  p.updateStressedEating(
                      snapshot.data["StressedEating"] ?? 'I don\'t know');
                  p.updateEatWhenLonely(
                      snapshot.data["LonelyEating"] ?? 'I don\'t know');
                  p.updateEatWhenBored(
                      snapshot.data["BoredEating"] ?? 'I don\'t know');
                  p.updateEatInLargePortion(
                      snapshot.data["LargeEating"] ?? 'I don\'t know');
                  p.updateEatWhileWatchingTv(
                      snapshot.data["WatchingEating"] ?? 'I don\'t know');
                  p.updateEatWhenNothingToDo(
                      snapshot.data["FreeTimeEating"] ?? 'I don\'t know');
                  p.updateDrinkLessWater(
                      snapshot.data["WaterHabit"] ?? 'I don\'t know');
                  p.updateFreeNightMunching(
                      snapshot.data["LateNightHabit"] ?? 'I don\'t know');
                  return Consumer<UserDataProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          questionAnswer(
                              question:
                                  'I cannot control myself when it comes to food',
                              answer: value.canControlWhenFood,
                              context: context,
                              onTap: () {
                                if (value.canControlWhenFood == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.canControlWhenFood ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value
                                                      .updateCanControlWhenFood(
                                                          options[
                                                              selectedOption]);
                                                  updateMindControl(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          questionAnswer(
                              question:
                                  'I am preoccupied with food most of the time.',
                              answer: value.preoccupied,
                              context: context,
                              onTap: () {
                                if (value.preoccupied == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.preoccupied == 'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updatePreoccupied(
                                                      options[selectedOption]);
                                                  updatePreoccupied(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          /*
                          questionAnswer(
                              question:
                                  'I just cannot control myself to eat when there is free food',
                              answer: value.canControlWhenFreeFood,
                              context: context,
                              onTap: () {
                                if (value.canControlWhenFreeFood == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.canControlWhenFreeFood ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value
                                                      .updateCanControlWhenFoodFree(
                                                          options[
                                                              selectedOption]);
                                                  updateFreeFood(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          
                          questionAnswer(
                              question:
                                  'I eat more when I see people eating around me',
                              answer: value.canControlWhenEatingAroundMe,
                              context: context,
                              onTap: () {
                                if (value.canControlWhenEatingAroundMe ==
                                    'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.canControlWhenEatingAroundMe ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value
                                                      .updateCanControlWhenFoodAround(
                                                          options[
                                                              selectedOption]);
                                                  updateEatingRound(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          */
                          questionAnswer(
                              question:
                                  'My past diets failed due to my cravings',
                              answer: value.failedDueToCraving,
                              context: context,
                              onTap: () {
                                if (value.failedDueToCraving == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.failedDueToCraving ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value
                                                      .updateFailedDueToCraving(
                                                          options[
                                                              selectedOption]);
                                                  updateCravingMind(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          questionAnswer(
                              question:
                                  'I eat more than normal when I am stressed',
                              answer: value.stressedEating,
                              context: context,
                              onTap: () {
                                if (value.stressedEating == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.stressedEating == 'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 300,
                                            width: 400,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateStressedEating(
                                                      options[selectedOption]);
                                                  updateStress(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          /*
                          questionAnswer(
                              question: 'I eat more when I am sad',
                              answer: value.eatWhenSad,
                              context: context,
                              onTap: () {
                                if (value.eatWhenSad == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.eatWhenSad == 'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateEatWhenSad(
                                                      options[selectedOption]);
                                                  updateSad(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          questionAnswer(
                              question: 'I eat more whenever I feel lonely',
                              answer: value.eatWhenLonely,
                              context: context,
                              onTap: () {
                                if (value.eatWhenLonely == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.eatWhenLonely == 'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateEatWhenLonely(
                                                      options[selectedOption]);
                                                  updateLonely(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          */
                          questionAnswer(
                              question: 'I eat more than usual when I am bored',
                              answer: value.eatWhenBored,
                              context: context,
                              onTap: () {
                                if (value.eatWhenBored == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.eatWhenBored == 'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateEatWhenBored(
                                                      options[selectedOption]);
                                                  updateBored(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          /*
                          questionAnswer(
                              question: 'I eat in large portions',
                              answer: value.eatInLargePortion,
                              context: context,
                              onTap: () {
                                if (value.eatInLargePortion == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.eatInLargePortion ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateEatInLargePortion(
                                                      options[selectedOption]);
                                                  updateLarge(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          */
                          questionAnswer(
                              question:
                                  'I eat meals or snacks while watching TV',
                              answer: value.eatWhileWatchingTv,
                              context: context,
                              onTap: () {
                                if (value.eatWhileWatchingTv == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.eatWhileWatchingTv ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value
                                                      .updateEatWhileWatchingTv(
                                                          options[
                                                              selectedOption]);
                                                  updateWatching(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          /*
                          questionAnswer(
                              question: 'I eat when I have nothing to do',
                              answer: value.eatWhenNothingToDo,
                              context: context,
                              onTap: () {
                                if (value.eatWhenNothingToDo == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.eatWhenNothingToDo ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value
                                                      .updateEatWhenNothingToDo(
                                                          options[
                                                              selectedOption]);
                                                  updateNothing(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          */
                          questionAnswer(
                              question:
                                  'I drink less than 8 (16 oz.) of glass of water every day',
                              answer: value.drinkLessWater,
                              context: context,
                              onTap: () {
                                if (value.drinkLessWater == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.drinkLessWater == 'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateDrinkLessWater(
                                                      options[selectedOption]);
                                                  updateWater(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          /*
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          
                          questionAnswer(
                              question: 'I have a habit of late-night munching',
                              answer: value.freeNightMunching,
                              context: context,
                              onTap: () {
                                if (value.freeNightMunching == 'Agree') {
                                  setState(() {
                                    selectedOption = 0;
                                  });
                                } else if (value.freeNightMunching ==
                                    'Disagree') {
                                  setState(() {
                                    selectedOption = 1;
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = 2;
                                  });
                                }
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        title: Text(
                                                          options[index],
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
                                                if (selectedOption != -1) {
                                                  value.updateFreeNightMunching(
                                                      options[selectedOption]);
                                                  updateLateNight(
                                                      options[selectedOption]);
                                                  setState(() {
                                                    selectedOption = -1;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              })
                              */
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
