import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/TextConstant.dart';
import 'package:weight_loser/widget/dialog.dart';

import 'I_am_preoccupied.dart';

//Poor Self-Control
class ICantControlMySelf extends StatefulWidget {
  SignUpBody signUpBody;

  ICantControlMySelf({Key key, this.signUpBody}) : super(key: key);

  @override
  _ICantControlMySelfState createState() => _ICantControlMySelfState();
}

class _ICantControlMySelfState extends State<ICantControlMySelf> {
  String gender = '';

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
                    SizedBox(height: height * .03),
                    ListView.builder(
                        itemCount: TextConstant.option.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      gender = TextConstant.option[index];
                                    });
                                  },
                                  child: Container(
                                    width: Get.width * .9,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          TextConstant.option[index],
                                          style: listStyle,
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          gender == TextConstant.option[index]
                                              ? mindSelect
                                              : Colors.white,
                                      border: Border.all(
                                        color:
                                            gender == TextConstant.option[index]
                                                ? mindBorder
                                                : Colors.grey,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ],
            ),
            Container(
              child: InkWell(
                onTap: () {
                  if (gender != '') {
                    widget.signUpBody.mindQuestions.control = gender;
                    print("Control ${widget.signUpBody.mindQuestions.control}");

                    mobile
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IAmPreoccupied(
                                  signUpBody: widget.signUpBody,
                                )))
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
                                      child: IAmPreoccupied(
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
          ],
        ),
      ),
    );
  }
}
