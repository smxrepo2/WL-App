import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/auth/signup.dart';

import 'Bottom_Navigation/bottom.dart';

class CardInformation extends StatefulWidget {
  CardInformation({Key key, this.signUpBody}) : super(key: key);
  SignUpBody signUpBody;
  @override
  _CardInformationState createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  String countryName = 'United States';
  TextEditingController cardNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cvcNumber = TextEditingController();
  TextEditingController myNumber = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Center(
                child: Image.asset(
                  'assets/images/gPay.png',
                  width: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Center(
                child: Image.asset(
                  'assets/images/paypal.jpeg',
                  width: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: .8,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.01),
                  child: Center(
                    child: Text(
                      'or pay with card',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: .8,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.02)),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Text(
              'Card Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cardNumber,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '1234 1232 1244 2323',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02)),
                    ),
                  ),
                  Image.asset(
                    'assets/images/cards.png',
                    width: MediaQuery.of(context).size.height * 0.25,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width / 2 -
                          MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: TextFormField(
                        controller: myNumber,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'MM / YY',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.02)),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width / 2 -
                            MediaQuery.of(context).size.height * 0.033,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: cvcNumber,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'CVC',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.02)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/images/CVC.png',
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Text(
              'Name On Card',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: TextFormField(
                controller: nameController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.02)),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Text(
              'Card Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          countryName,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            onSelect: (Country country) {
                              print(country.name);
                              countryName = country.name;
                              print(countryName);
                              setState(() {});
                            },
                          );
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: TextFormField(
                controller: zipController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ZIP',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.02)),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: GestureDetector(
              onTap: () {
                var user = FirebaseAuth.instance;
                if (user.currentUser != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                      (route) => false);
                } else {
                  //Get.to(()=>SignUpScreen(signUpBody: widget.signUpBody,));
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(signUpBody: widget.signUpBody,)));
                }
              },
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Center(
                    child: Text(
                      'Pay \$9.99 per month',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ],
      ),
    );
  }
}
