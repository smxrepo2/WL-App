import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'present_medical_condition_screen.dart';

class SelectYourAgeScreen extends StatefulWidget {
  const SelectYourAgeScreen({Key key}) : super(key: key);

  @override
  State<SelectYourAgeScreen> createState() => _SelectYourAgeWeightState();
}

class _SelectYourAgeWeightState extends State<SelectYourAgeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height - kToolbarHeight;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
              height: height,
              width: width,
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
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.01,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius
                                                  .horizontal(
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
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.01,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius
                                                  .horizontal(
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
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.01,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius
                                                  .horizontal(
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
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.01,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius
                                                  .horizontal(
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
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.01,
                                          width: width * 0.25,
                                          decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius
                                                  .horizontal(
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
                      )),
                  SizedBox(

                    ///this is the stack container........
                    height: height * 0.3,
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          height: height * 0.2,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(215, 226, 241, 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                          child: Center(
                            child: Text(
                              'Let us understand your profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.025),
                            ),
                          ),
                        ),
                        Positioned(
                            top: height * 0.13,
                            left: height * 0.04,
                            child: Container(
                              height: height * 0.17,
                              width: width * 0.85,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            " Select your Age",
                                            style: TextStyle(
                                                fontWeight: FontWeight. w600,
                                                fontSize: height * 0.034),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  color: Colors.white,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Container(
                      height: height * 0.22,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(child: Text('18 Years', style: TextStyle(
                          fontSize: height * 0.04,
                          fontWeight: FontWeight.w400),)),
                    ),
                  ),
                  SizedBox(height: height*0.08,width: width*.8,
                  child:  Container(
                    height: MediaQuery.of(context).copyWith().size.height * 0.25,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                      },
                      initialDateTime: DateTime.now(),
                      minimumYear: 2000,
                      maximumYear: 3000,
                    ),
                  ),),
                  SizedBox(height: height*0.03,),
                  ///this is the third Container ........3
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Slider(
                      value: 0.3,
                      onChanged: (value) {},
                      inactiveColor: Colors.black26,
                      activeColor: Colors.black,
                    ),
                  ),
                  const Text('*Age Should be between 18 to 60 Years',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold),),
                  SizedBox(height: height * 0.023,),
                  InkWell(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const PresentMedicalCondition () ,));
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
                  SizedBox(height: height * 0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height * 0.01,
                        width: width / 2,
                        child: LinearProgressIndicator(
                          minHeight: height * 0.02,
                          color: Colors.black,
                          backgroundColor: Colors.black38,
                          value: 0.1,
                        ),
                      ),
                      const Text('03 % Completed'),
                    ],
                  )
                ],
              ),
            )));
  }
}