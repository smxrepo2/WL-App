import 'package:flutter/material.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../../../mudasar/current_weight_screen.dart';

class GenderScreen extends StatefulWidget {
  SignUpBody signUpBody;
  GenderScreen({Key key, this.signUpBody}) : super(key: key);
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  
  String gender = '';
  List<Data> Gender = [
    Data('Male', ImagePath.male),
    Data('Female', ImagePath.female),
    Data('Non Binary', ImagePath.nonBinary)
  ];

    @override
  void initState() {
    super.initState();
    widget.signUpBody=SignUpBody();
  }


  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
              width: width,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Biology',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Diet',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Excersie',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Mind',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sleep/Habit',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
                height: height * 0.3,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.2,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(227, 194, 247, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Text(
                          'Let us understand your Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.02),
                        ),
                      ),
                    ),
                    Positioned(
                        top: height * 0.13,
                        left: height * 0.04,
                        child: Container(
                          height: height * 0.15,
                          width: width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Select Your Gender",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.03),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
           
           SizedBox(height: height*.05,),
            SizedBox(
              height: height * .25,
              child: ListView.builder(
                  itemCount: Gender.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:   EdgeInsets.symmetric(horizontal: width*.05,vertical: height*.01),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            gender = Gender[index].text;
                          });
                        },
                        child: Container(
                          width: width * .7,
                          height: height * .063,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * .05,
                              ),
                              Text(
                                Gender[index].text,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: semiBold,
                                    fontFamily: 'Open Sans'),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: gender == Gender[index].text
                                  ? buttonColor
                                  : Colors.white,
                            borderRadius: BorderRadius.circular(height * .01),
                            border: Border.all(
                              color: gender == Gender[index].text
                                  ? buttonColor
                                  : Colors.black26,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: height*.1,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const  HieghtScreen() ,));
                // if (gender == 'Female') {
                //    widget.signUpBody.dietQuestions.gender = gender;
                //   Responsive1.isMobile(context)
                //       ? Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => SelectYourAge(
                //               signUpBody: widget.signUpBody,
                //             ),
                //           ),
                //         )
                //       : Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 430, right: 430, top: 30, bottom: 30),
                //               child: Card(
                //                 elevation: 5,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child:  SelectYourAge(signUpBody: widget.signUpBody),
                //               ),
                //             ),
                //           ),
                //         );
                // } else if (gender == 'Male' || gender == 'Non Binary') {
                //   widget.signUpBody.dietQuestions.gender = gender;
                //   Responsive1.isMobile(context)
                //       ? Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => SelectYourAge(
                //               signUpBody: widget.signUpBody,
                //             ),
                //           ),
                //         )
                //       : Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 430, right: 430, top: 30, bottom: 30),
                //               child: Card(
                //                   elevation: 5,
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(10)),
                //                   child:
                //                       SelectYourAge(signUpBody: widget.signUpBody)),
                //             ),
                //           ),
                //         );
                // } else {
                //   AltDialog(context, 'Please select options.');
                // }
                // if (gender == "Female") {
                //   widget.signUpBody.dietQuestions.gender = gender;
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => GoalWeightScreen(
                //             signUpBody: widget.signUpBody,
                //           )));
                // } else if (gender == 'Male' || gender == 'Intersex') {
                //   widget.signUpBody.dietQuestions.gender = gender;
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => GoalWeightScreen(
                //             signUpBody: widget.signUpBody,
                //           )));
                // } else {
                //   AltDialog(context, 'Please select options.');
                // }
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.6,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontSize: height * 0.024,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 