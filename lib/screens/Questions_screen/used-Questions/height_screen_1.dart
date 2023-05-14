import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/theme/TextStyles.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({Key key}) : super(key: key);

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  SignUpBody signUpBody = SignUpBody();
  final int _currentIntValue = 10;
  final double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  int _currentValue1 = 3;
  int _currentValue2 = 5;
  int _currentCmValue = 173;
  String mode = 'feet';
  @override
  void initState() {
    super.initState();
    // signUpBody.customerPackages = CustomerPackages();
    // signUpBody.dietQuestions = DietQuestions();
    // signUpBody.mindQuestions = MindQuestions();
    //signUpBody.exerciseQuestions = ExerciseQuestions();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height; //683
    var width = MediaQuery.of(context).size.width; //411

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
                )),
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
                        'Let us Understand Your Profile ',
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                  child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "Please Select Your Height",
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
            SizedBox(
              height: height * .02,
            ),
            Container(
                width: Get.width * .53,
                height: height * 0.06,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(40.0))),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          mode = 'feet';
                        });
                      },
                      child: Container(
                        width: width * .26,
                        decoration: BoxDecoration(
                          color: mode == 'feet'
                              ? const Color(0xffD7E2F1)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Ft',
                            style: TextStyle(
                                color: mode == 'feet'
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          mode = 'Cm';
                        });
                      },
                      child: Container(
                        width: width * .263,
                        decoration: BoxDecoration(
                          color: mode == 'Cm'
                              ? const Color(0xffD7E2F1)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cm',
                            style: TextStyle(
                                color:
                                    mode == 'Cm' ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: height * .04,
            ),
            Container(
              height: height * .18,
              width: width * .7,
              decoration: BoxDecoration(
                  color:   Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: mode == 'feet'
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NumberPicker(
                            value: _currentValue1,
                            itemWidth: 40,
                            selectedTextStyle: selectedStyle,
                            minValue: 0,
                            maxValue: 12,
                            onChanged: (value) =>
                                setState(() => _currentValue1 = value),
                          ),
                          const Center(
                            child: Text(
                              'ft',
                              style: wordStyle,
                            ),
                          ),
                          Container(
                            width: 1.5,
                            height: 150,
                            color: Colors.black38,
                          ),
                          NumberPicker(
                            value: _currentValue2,
                            itemWidth: 60,
                            selectedTextStyle: selectedStyle,
                            minValue: 0,
                            maxValue: 12,
                            onChanged: (value) =>
                                setState(() => _currentValue2 = value),
                          ),
                          const Center(
                            child: Text(
                              'in',
                              style: wordStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: 1.5,
                            height: 150,
                            color: Colors.grey[300],
                          ),
                        ),
                        NumberPicker(
                          value: _currentCmValue,
                          itemWidth: 60,
                          selectedTextStyle: selectedStyle,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            border: Border.all(color: Colors.black26),
                          ),
                          minValue: 0,
                          maxValue: 10000,
                          onChanged: (value) =>
                              setState(() => _currentCmValue = value),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: 1.5,
                            height: 150,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                          child: Center(
                            child: Text(
                              'Cm',
                              style: wordStyle,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: height * .06,
            ),
            InkWell(
              onTap: () {
              
                // if (mode == 'feet') {
                //   var a = '$_currentValue1.$_currentValue2'.trim();
                //   var b = _currentValue1 * _currentValue2;
                //   signUpBody.dietQuestions.height =
                //       double.parse('$_currentValue1.$_currentValue2');
                //   signUpBody.dietQuestions.heightUnit = 'feet';
                //   print(a + signUpBody.dietQuestions.heightUnit);

                //   Responsive1.isMobile(context)
                //       ? Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) =>
                //               WeightScreen(signUpBody: signUpBody)))
                //       : Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => Padding(
                //                 padding: const EdgeInsets.only(
                //                     left: 430, right: 430, top: 30, bottom: 30),
                //                 child: Card(
                //                     elevation: 5,
                //                     shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(10)),
                //                     child:
                //                         WeightScreen(signUpBody: signUpBody)),
                //               )));
                // } else if (mode == 'Cm') {
                //   signUpBody.dietQuestions.height =
                //       double.parse('$_currentCmValue');
                //   signUpBody.dietQuestions.heightUnit = 'cm';
                //   print(
                //       '$_currentCmValue' + signUpBody.dietQuestions.heightUnit);
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => WeightScreen(
                //             signUpBody: signUpBody,
                //           )));
                // }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: buttonStyle,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.01,
                  width: width / 2,
                  child: LinearProgressIndicator(
                    minHeight: height * 0.02,
                    color: Colors.black,
                    value: 1.6,
                  ),
                ),
                const Text('60 % Completed'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
