import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/utils/ImagePath.dart';

class SelectTimeComponent extends StatefulWidget {
  final String title;

  TimeOfDay startTime;
  TimeOfDay endTime;

  SelectTimeComponent({this.title, this.startTime, this.endTime});

  @override
  State<SelectTimeComponent> createState() => _SelectTimeComponentState();
}

class _SelectTimeComponentState extends State<SelectTimeComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.09,
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(ImagePath.reminderIcon, scale: 1),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.openSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF797A7A)),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  buildTimePick(
                                      context, "Start", true, widget.startTime,
                                      (x) {
                                    setState(() {
                                      print("The picked time is: $x");
                                      widget.startTime = x;
                                    });
                                  }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  buildTimePick(
                                      context, "End", true, widget.endTime,
                                      (x) {
                                    setState(() {
                                      widget.endTime = x;
                                      print("The picked time is: $x");
                                    });
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Divider(
          color: Color(0xFFF8F8FA),
          thickness: 4.0,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}

class SelectTime extends StatefulWidget {
  final String title;

  TimeOfDay startTime;
  TimeOfDay endTime;
  SelectTime({this.title, this.startTime, this.endTime});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.09,
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(ImagePath.reminderIcon, scale: 1),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.openSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF797A7A)),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  buildTimePick(
                                      context, "Start", true, widget.startTime,
                                      (x) {
                                    setState(() {
                                      print("The picked time is: $x");
                                      widget.startTime = x;
                                    });
                                  }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  buildTimePick(
                                      context, "End", true, widget.endTime,
                                      (x) {
                                    setState(() {
                                      widget.endTime = x;
                                      print("The picked time is: $x");
                                    });
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildTimePick(context, String title, bool ifPickedTime,
    TimeOfDay currentTime, Function(TimeOfDay) onTimePicked) {
  return Row(
    children: [
      Card(
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentTime.format(context),
            ),
          ),
          onTap: () {
            selectedTime(context, ifPickedTime, currentTime, onTimePicked);
          },
        ),
      ),
    ],
  );
}

Future selectedTime(BuildContext context, bool ifPickedTime,
    TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
  var _pickedTime =
      await showTimePicker(context: context, initialTime: initialTime);
  if (_pickedTime != null) {
    onTimePicked(_pickedTime);
  }
}
