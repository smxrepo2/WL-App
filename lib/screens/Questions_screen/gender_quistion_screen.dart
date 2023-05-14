import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/do_you_know.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

class TypesOfBody extends StatefulWidget {
  SignUpBody signUpBody;

  TypesOfBody({Key key, this.signUpBody}) : super(key: key);

  @override
  _TypesOfBodyState createState() => _TypesOfBodyState();
}

class _TypesOfBodyState extends State<TypesOfBody> {
  String gender = '';
  List<Data> bodyType = [
    Data('Apple-shaped', ImagePath.appleShape),
    Data('Pear-shaped', ImagePath.pearShape),
    Data('Pot Belly', ImagePath.potShape)
  ];

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    questionHeader(
                      queNo: 17,
                      percent: .63,
                      color: exBorder,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         print("tapped");
                    //       },
                    //       child: Container(
                    //         child: Icon(
                    //           Icons.arrow_back,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Text(
                    //           '22/$totalQuestion',
                    //           style: TextStyle(color: Colors.black),
                    //         )
                    //       ],
                    //     ),
                    //     Container()
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 5,
                    //   color: Colors.grey[300],
                    //   child: LinearPercentIndicator(
                    //     // width: double.infinity,
                    //     lineHeight: 5.0,
                    //     percent: .52,
                    //
                    //     padding: EdgeInsets.all(0),
                    //     backgroundColor: Colors.grey[300],
                    //     progressColor: primaryColor,
                    //   ),
                    // ),
                    SizedBox(
                        height: mobile ? Get.height * .83 : Get.height * .80,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: height * .01,
                            ),
                            SizedBox(height: height * .03),
                          ]),
                        ))
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: mobile ? Get.width * .15 : 25,
              child: Container(
                child: InkWell(
                  onTap: () {
                    if (gender != '') {
                      print(
                          "BodyType:- ${widget.signUpBody.exerciseQuestions.bodyType}");
                      mobile
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DoyouknowScreen(
                                  signUpBody: widget.signUpBody,
                                ),
                              ),
                            )
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 430,
                                        right: 430,
                                        top: 30,
                                        bottom: 30),
                                    child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DoyouknowScreen(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                    } else {
                      AltDialog(context, 'Please select options.');
                    }
                  },
                  child: Padding(
                    padding: mobile
                        ? const EdgeInsets.only(bottom: 20.0, left: 20)
                        : const EdgeInsets.only(bottom: 30.0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: mobile ? Get.width * .6 : Get.width * .3,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            child: const Center(
                              child: Text(
                                "Next",
                                style: buttonStyle,
                              ),
                            )),
                      ],
                    ),
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

/// Thıs ıs gender screen
/// thıs is not in use
// class GenderScreen extends StatefulWidget {
//   const GenderScreen({Key key}) : super(key: key);
//
//   @override
//   State<GenderScreen> createState() => _GenderScreenState();
// }
//
// class _GenderScreenState extends State<GenderScreen> {
//   bool isSelected =  true;
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height - kToolbarHeight;
//     double width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//           body: Container(
//         height: height,
//         width: width,
//         child: Column(
//           children: [
//             SizedBox(
//                 height: height * 0.1,
//                 width: width,
//                 child: Row(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(Icons.arrow_back_ios),
//                     ),
//                     Expanded(
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           Container(
//                             height: height * 0.05,
//                             width: width * 0.25,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Biology',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: height * 0.01,
//                                     width: width * 0.25,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black54,
//                                         borderRadius: BorderRadius.horizontal(
//                                           left: Radius.circular(20),
//                                           right: Radius.circular(20),
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: height * 0.05,
//                             width: width * 0.25,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Diet',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: height * 0.01,
//                                     width: width * 0.25,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black54,
//                                         borderRadius: BorderRadius.horizontal(
//                                           left: Radius.circular(20),
//                                           right: Radius.circular(20),
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: height * 0.05,
//                             width: width * 0.25,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Excersie',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: height * 0.01,
//                                     width: width * 0.25,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black54,
//                                         borderRadius: BorderRadius.horizontal(
//                                           left: Radius.circular(20),
//                                           right: Radius.circular(20),
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: height * 0.05,
//                             width: width * 0.25,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Mind',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: height * 0.01,
//                                     width: width * 0.25,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black54,
//                                         borderRadius: BorderRadius.horizontal(
//                                           left: Radius.circular(20),
//                                           right: Radius.circular(20),
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: height * 0.05,
//                             width: width * 0.25,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Sleep/Habit',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: height * 0.01,
//                                     width: width * 0.25,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black54,
//                                         borderRadius: BorderRadius.horizontal(
//                                           left: Radius.circular(20),
//                                           right: Radius.circular(20),
//                                         )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//               height: height * 0.3,
//               width: width,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: height * 0.2,
//                     decoration: const BoxDecoration(
//                         color: Color(0xffD7E2F1),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(25),
//                             bottomRight: Radius.circular(25))),
//                     child: Center(
//                       child: Text(
//                         'Let us understand your Profile',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: height * 0.02),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       top: height * 0.13,
//                       left: height * 0.04,
//                       child: Container(
//                         height: height * 0.15,
//                         width: width * 0.85,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               FittedBox(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Please Select Your Gender",
//                                   style: TextStyle(fontSize: height * 0.04),
//                                 ),
//                               )),
//                               FittedBox(
//                                   child: Text(
//                                 "you have",
//                                 style: TextStyle(fontSize: height * 0.032),
//                               )),
//                             ],
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black38),
//                             color: Colors.white,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10))),
//                       )),
//                 ],
//               ),
//             ),
//
//             /// gender fıelds card
//
//             Padding(
//               padding:   EdgeInsets.symmetric(horizontal: height*0.04),
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: (){
//                       setState(() {
//                         isSelected=false;
//                       });
//
//                     },
//                     child: Container(
//                         height: height * 0.07,
//                         width: width,
//                         decoration: BoxDecoration(border: Border.all()),
//                         child: isSelected ? const Text('Male') : _selectedItem()),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: height*0.04,),
//             /// thıs ıs next button
//             Container(
//               height: height * 0.07,
//               width: width * 0.6,
//               color: Colors.black,
//               child: Center(
//                 child: Text(
//                   'Next',
//                   style: TextStyle(
//                       fontSize: height * 0.024,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: height * 0.07,
//             ),
//
//             /// thıs ıs lınaarprogressındıcator
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   height: height * 0.01,
//                   width: width / 2,
//                   child: LinearProgressIndicator(
//                     minHeight: height * 0.02,
//                     color: Colors.black87,
//                     value: 1.6,
//                   ),
//                 ),
//                 const Text('60 % Completed'),
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }
//
//   Widget _selectedItem() {
//     return Container(
//         height: 30,
//         width: 30,
//         decoration: BoxDecoration(color: Colors.black),
//         child: Center(
//             child: Icon(
//           Icons.verified_user_sharp,
//           color: Colors.white,
//         )));
//   }
// }

