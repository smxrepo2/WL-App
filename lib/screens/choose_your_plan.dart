import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/screens/choose_method.dart';

import '../utils/AppConfig.dart';

class ChoosePlan extends StatefulWidget {
  ChoosePlan({Key key, this.signUpBody}) : super(key: key);
  SignUpBody signUpBody;

  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  List<dynamic> allPkg = [];
  SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getPkgs();
  }

  Future<bool> sendOtp(String email, context) async {
    _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(message: "Sending Otp", type: SimpleFontelicoProgressDialogType.normal);
    var requestBody = {'email': email};
    final response = await post(
      Uri.parse('$apiUrl/api/login/EmailVerify'),
      body: requestBody,
    );
    if (response.statusCode == 200) {
      _dialog.hide();
      return true;
      //json.encode(response.body);
    } else {
      _dialog.hide();
      throw Exception('unable to find your email');
    }
  }

  Future<void> getPkgs() async {
    var client = http.Client();
    try {
      var url = Uri.parse('https://weightchoper.somee.com/api/package');
      var response = await client.get(url, headers: {
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
        'User-Agent': 'PostmanRuntime/7.28.4',
      });
      if (response != null && response.statusCode == 200) {
        setState(() {
          allPkg = json.decode(response.body);
        });
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } on SocketException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  int _selected = 1;
  List<String> plans = ['3 MONTHS', '6 MONTHS', '12 MONTHS'];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: allPkg.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                )
              : ListView(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          const Center(
                            child: Text('Choose',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                          const Center(
                            child: Text('Your Plan',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: Image.asset(
                                      'assets/images/Mask Group 45.png',
                                    ).image)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          ListView.builder(
                              itemCount: allPkg.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected = index;
                                          });
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _selected == index
                                                    ? Colors.blueAccent
                                                    : Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.02),
                                                child: Icon(
                                                  _selected == index
                                                      ? Icons
                                                          .check_circle_rounded
                                                      : Icons.circle_outlined,
                                                  color: _selected == index
                                                      ? Colors.blueAccent
                                                      : Colors.black,
                                                  size: 20,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.02),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        '${allPkg[index]['Title']}\n',
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '\$${allPkg[index]['Price']} / Month billed annually',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize:
                                                                      12)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ],
                                );
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.035),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'WEIGHT',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' LOSER',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black45)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'A recearched-backend app made easy to use for your',
                                        style: GoogleFonts.roboto(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        'accessibility and comfort.',
                                        style: GoogleFonts.roboto(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.blueAccent,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: Column(
                                            children: [
                                              Text(
                                                'App customizes your weight-loss program according to\nyour habits and liking so you find your journey easy.',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.blueAccent,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: Text(
                                            'Every individual is unique and we know that, we provide\nresearched-backed programs that help you loose weight\neasy and quick',
                                            style: GoogleFonts.roboto(
                                                fontSize: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.blueAccent,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: Text(
                                            'Motivation and focus is an integral part of weight-loss\nand wemake sure that you stay on track',
                                            style: GoogleFonts.roboto(
                                                fontSize: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.blueAccent,
                                            size: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          child: Text(
                                            'Having trouble in something? No worries our Coaches are\nalways there for your help',
                                            style: GoogleFonts.roboto(
                                                fontSize: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.07,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.07,
                                right:
                                    MediaQuery.of(context).size.height * 0.05,
                                left:
                                    MediaQuery.of(context).size.height * 0.05),
                            child: GestureDetector(
                              onTap: () {
                                // widget.signUpBody.customerPackages.amount = 10;
                                // widget.signUpBody.customerPackages.name = 'basic';
                                // widget.signUpBody.customerPackages.duration = 1;


                                //widget.signUpBody.customerPackages.status =
                                //  'unPaid';
                                // widget.signUpBody.dietQuestions.dOB = "22-04-2000";
                                //  widget.signUpBody.exerciseQuestions.activityLevel = 9;
                                //  widget.signUpBody.dietQuestions.weightApps = 'weightApps';
                                //  widget.signUpBody.di etQuestions.favFoods = 'favFoods';
                                /*var provider = getit<authModeprovider>();
                                if (widget.signUpBody.customerPackages.status == "paid") {
                                  provider.getData()
                                      ? signUpOtherUser(
                                          widget.signUpBody, context)
                                      : sendOtp(
                                              widget.signUpBody.email, context)
                                          .then((value) {
                                          if (value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OTPScreen(
                                                          email: widget
                                                              .signUpBody.email,
                                                          text: 'Signup',
                                                          signUpBody:
                                                              widget.signUpBody,
                                                        )));
                                          }
                                        });
                                } else {

                                }*/


                                Responsive1.isMobile(context)
                                    ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChooseMethod(
                                              signUpBody:
                                              widget.signUpBody,
                                            )))
                                    : Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 430,
                                          right: 430,
                                          top: 30,
                                          bottom: 30),
                                      child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10)),
                                          child: ChooseMethod(
                                            signUpBody:
                                            widget.signUpBody,
                                          )),
                                    )));


                                // dialog(context);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Start Your Weight-loss journey',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showPolicyDialog(
                                      "Privacy Policy",
                                      () {},
                                      () {},
                                      context,
                                      "This section is to show privacy policy");
                                },
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showPolicyDialog(
                                      "Terms and Conditions",
                                      () {},
                                      () {},
                                      context,
                                      "This section is to show Terms and Conditions");
                                },
                                child: const Text(
                                  'Terms and Condition',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'A subscription is required to use the Weightloser app. it can',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  'be canceled at any time in App store Or through website',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

Future<void> _showPolicyDialog(
    String title, Function() onYes, Function() onNo, context, message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.roboto(fontSize: 14),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: GoogleFonts.roboto(fontSize: 10),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.blueAccent,
                        size: 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02),
                      child: Text(
                        'Agree with Weight Loser $title',
                        style: GoogleFonts.roboto(fontSize: 10),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
                onYes();
              },
            ),
          ),
          /*
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          */
        ],
      );
    },
  );
}
