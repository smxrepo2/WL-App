import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/AuthService.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/chatService.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/main.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/screens/paymentScreen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/validation.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/custom_form_fields.dart';

import '../welcome_screen/landingScreen.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  final String text;
  SignUpBody signUpBody;
  SignUpRequestModel signUpRequestModel;
  UserDataModel userDataModel;

  OTPScreen(
      {Key key, this.email,
      this.text,
      this.signUpBody,
      this.signUpRequestModel,
      this.userDataModel}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  SimpleFontelicoProgressDialog _dialog;
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  String _otp;
  int userid;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    // print(
    //     'widget.signUpBody.dietQuestions.height: ${widget.signUpBody.dietQuestions.height}');
    // print(
    //     'widget.signUpBody.dietQuestions.gender: ${widget.signUpBody.dietQuestions.gender}');
    // print(
    //     'widget.signUpBody.dietQuestions.duration: ${widget.signUpBody.dietQuestions.duration}');
    // print('currentWeight${widget.signUpBody.dietQuestions.currentWeight}');
    // print("Age ${widget.signUpBody.age}");
    // print('dOB ${widget.signUpBody.dietQuestions.dOB}');
    // print('favCuisine${widget.signUpBody.dietQuestions.favCuisine}');
    // print('favFoods${widget.signUpBody.dietQuestions.favFoods}');
    // print('favRestuarant${widget.signUpBody.dietQuestions.favRestuarant}');
    // print('goalWeight${widget.signUpBody.dietQuestions.goalWeight}');
    // print('heightUnit${widget.signUpBody.dietQuestions.heightUnit}');
    // print('lifeStyle${widget.signUpBody.dietQuestions.lifeStyle}');
    // print(
    //     'medicalCondition${widget.signUpBody.dietQuestions.medicalCondition}');
    // print('noCuisine${widget.signUpBody.dietQuestions.noCuisine}');
    // print('restrictedFood${widget.signUpBody.dietQuestions.restrictedFood}');
    // print('sleepTime${widget.signUpBody.dietQuestions.sleepTime}');
    // print('weightApps${widget.signUpBody.dietQuestions.weightApps}');
    // print("Food Type ${widget.signUpBody.dietQuestions.foodType}");
    // print('weightUnit${widget.signUpBody.dietQuestions.weightUnit}');

    // print('activityLevel${widget.signUpBody.exerciseQuestions.activityLevel}');
    // print('bodyType${widget.signUpBody.exerciseQuestions.bodyType}');
    // print('exerciseType${widget.signUpBody.exerciseQuestions.exerciseType}');
    // print('memberShip${widget.signUpBody.exerciseQuestions.memberShip}');
    // print('minExercise${widget.signUpBody.exerciseQuestions.minExercise}');
    // print('routine${widget.signUpBody.exerciseQuestions.routine}');

    // print('control${widget.signUpBody.mindQuestions.control}');
    // print('preoccupied${widget.signUpBody.mindQuestions.preoccupied}');
    // print('freeFood${widget.signUpBody.mindQuestions.freeFood}'); //here
    // print('eatingRound${widget.signUpBody.mindQuestions.eatingRound}');

    // print('craveFoods${widget.signUpBody.mindQuestions.craveFoods}');
    // print('cravings${widget.signUpBody.mindQuestions.cravings}');

    // print('stressedEating${widget.signUpBody.mindQuestions.stressedEating}');
    // print('sadEating${widget.signUpBody.mindQuestions.sadEating}'); //here
    // print('lonelyEating${widget.signUpBody.mindQuestions.lonelyEating}');
    // print('boredEating${widget.signUpBody.mindQuestions.boredEating}');

    // print(
    //     'dailyEating${widget.signUpBody.mindQuestions.dailyEating}'); //ubnormal
    // print('sevenSleeping${widget.signUpBody.mindQuestions.sevenSleeping}');
    // print('largeEating${widget.signUpBody.mindQuestions.largeEating}');
    // print('watchingEating${widget.signUpBody.mindQuestions.watchingEating}');
    // print('freeTimeEating${widget.signUpBody.mindQuestions.freeTimeEating}');
    // print('waterHabit${widget.signUpBody.mindQuestions.waterHabit}');
    // print(
    //     'lateNightHabit${widget.signUpBody.mindQuestions.lateNightHabit}'); //here
    // print('waterHabit${widget.signUpBody.customerPackages.name}');
    // print('waterHabit${widget.signUpBody.customerPackages.amount}');
    // print('waterHabit${widget.signUpBody.customerPackages.duration}');
    // print('waterHabit${widget.signUpBody.customerPackages.status}');
    // print("MindType ${widget.signUpBody.facebookToken}");
  } // ignore: missing_return
  Future<dynamic> verifyOTP(String otpNumber) async {
    var requestBody = {"otp": otpNumber};
    final response = await post(
      Uri.parse('$apiUrl/api/login/verifyotp'),
      body: requestBody,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify otp');
    }
  }

  SharedPreferences prefs;
  Map<String, dynamic> userdata = {};

  // ignore: unused_field
  UserDataModel _userDataModel;

  Future createfirebaseAccount() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      UserCredential userCrendetial =
          await _auth.createUserWithEmailAndPassword(
              email: widget.signUpBody.email,
              password: widget.signUpBody.password);
      return userCrendetial.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> signUpUser() async {
    print(widget.signUpBody.email);
    print(widget.signUpBody.password);
    print(widget.signUpBody.age);
    print("restauratns:" + widget.signUpBody.restaurants.toString());
    print("Customer Package:" +
        widget.signUpBody.customerPackages.toJson().toString());
    print("Diet Questions:" +
        widget.signUpBody.dietQuestions.toJson().toString());
    print("Mind Questions:" +
        widget.signUpBody.mindQuestions.toJson().toString());
    print("Exercise Questions:" +
        widget.signUpBody.exerciseQuestions.toJson().toString());
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
        message: "Signing Up", type: SimpleFontelicoProgressDialogType.normal);
    var client = http.Client();

    try {
      var url = Uri.parse('https://weightchoper.somee.com/api/user');
      var response = await client.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept': '*/*',
            'User-Agent': 'PostmanRuntime/7.28.4',
            'Cookie':
                '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
          },
          body: json.encode(widget.signUpBody.toJson()));

      logger.e("SignUp Request Body :" + widget.signUpBody.toJson().toString());
      logger.e("SignUp Response :" + response.body.toString());

      if (response != null && response.statusCode == 200) {
        if (!response.body.contains("User with the name")) {
          await createfirebaseAccount();
          try {
            var headers = {
              'Content-Type': 'application/json',
              'Cookie':
                  '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
            };
            var request = http.Request(
                'POST', Uri.parse('https://weightchoper.somee.com/api/login'));
            request.body = json.encode({
              "Name": widget.signUpBody.email,
              "Password": widget.signUpBody.password
            });
            request.headers.addAll(headers);
            logger.e("Login Request Body :" + request.body.toString());
            http.StreamedResponse response = await request.send();
            var resp = await response.stream.bytesToString();

            logger.e("Login Response :" + resp.toString());

            if (response.statusCode == 200) {
              print(resp.runtimeType);
              userdata = json.decode(resp);
              _userDataModel = UserDataModel.fromJson(userdata);
              final provider =
                  Provider.of<UserDataProvider>(context, listen: false);
              provider.setUserData(_userDataModel);
              ChatService.senderId = _userDataModel.user.id.toString();
              print(userdata.runtimeType);
              AuthService.setUserId(_userDataModel.user.id);
              widget.signUpBody.customerPackages.status = "";
              //print("id ${_userDataModel.user.id}");
              _dialog.hide();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Signup  Successful",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));

              Responsive1.isMobile(context)
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                      (route) => false)
                  : Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SideMenu()),
                      (route) => false);
            } else {
              print(response.statusCode);
              print(response.reasonPhrase);
              _dialog.hide();
            }
          } catch (e) {
            print("hi");
            print(e.toString());
            _dialog.hide();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User with this email already exists")));
          }
        } else {
          _dialog.hide();
        }
      } else {
        print(response.statusCode);
        print(response.body);
        _dialog.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signup error")));
      }
    } on SocketException catch (e) {
      print("hi2");
      print(e);
    } catch (e) {
      print("hi3");
      print(e.toString());
    } finally {
      client.close();
    }
  }
  Future<bool> signUpUserNewAPI() async {
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
        message: "Signing Up", type: SimpleFontelicoProgressDialogType.normal);
    var client = http.Client();

    try {
      var url = Uri.parse("https://weightchoper.somee.com/api/user/signup");
      logger.d(
          "Request Body :${json.encode(widget.signUpRequestModel.toJson())}");
      var response = await client.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept': '*/*',
            'User-Agent': 'PostmanRuntime/7.28.4',
            'Cookie':
                '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
          },
          body: json.encode(widget.signUpRequestModel.toJson()));
      logger.d("SignUpResponse :${response.body.toString()}");
      if (response != null && response.statusCode == 200) {
        print(response.body);
        userdata = json.decode(response.body);
        _userDataModel = UserDataModel(
          user: UserLocal(
            id: userdata["user"]["Id"],
            questionOrder: userdata["user"]["QuestionOrder"],
          ),
          paid: userdata["Paid"],
          keyToken: userdata["token"],
        );
        final provider = Provider.of<UserDataProvider>(context, listen: false);
        provider.setUserData(_userDataModel);
        ChatService.senderId = _userDataModel.user.id.toString();
        AuthService.setUserId(_userDataModel.user.id);
        AuthService.setQuestionOrder(userdata["user"]["QuestionOrder"]);
        AuthService.setPaid(userdata["Paid"]);
        if (response.body.contains("User with the name")) {
          // await createfirebaseAccount();
          // try {
          //   var headers = {
          //     'Content-Type': 'application/json',
          //     'Cookie':
          //         '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
          //   };
          //   var request = http.Request(
          //       'POST', Uri.parse('https://weightchoper.somee.com/api/login'));
          //   request.body = json.encode({
          //     "Name": widget.signUpBody.email,
          //     "Password": widget.signUpBody.password
          //   });
          //   request.headers.addAll(headers);
          //   logger.e("Login Request Body :" + request.body.toString());
          //   http.StreamedResponse response = await request.send();
          //   var resp = await response.stream.bytesToString();
          //
          //   logger.e("Login Response :" + resp.toString());
          //
          //   if (response.statusCode == 200) {
          //     print(resp.runtimeType);
          //     userdata = json.decode(resp);
          //     _userDataModel = UserDataModel.fromJson(userdata);
          //     final provider =
          //         Provider.of<UserDataProvider>(context, listen: false);
          //     provider.setUserData(_userDataModel);
          //     ChatService.senderId = _userDataModel.user.id.toString();
          //     AuthService.setUserId(_userDataModel.user.id);
          //     //widget.signUpBody.customerPackages.status = "";
          //     //print("id ${_userDataModel.user.id}");
          //     _dialog.hide();
          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //       content: Text(
          //         "Signup  Successful",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       backgroundColor: Colors.green,
          //     ));
          //
          //     /// Dont Move to Dashboard
          //     /*Responsive1.isMobile(context)
          //         ? Navigator.pushAndRemoveUntil(
          //             context,
          //             MaterialPageRoute(builder: (context) => BottomBarNew(0)),
          //             (route) => false)
          //         : Navigator.pushAndRemoveUntil(
          //             context,
          //             MaterialPageRoute(builder: (context) => SideMenu()),
          //             (route) => false);*/
          //
          //     ///Redirect to Question's Flow
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 AboutUs(signUpBody: widget.signUpBody)));
          //   } else {
          //     print(response.statusCode);
          //     print(response.reasonPhrase);
          //     _dialog.hide();
          //   }
          // } catch (e) {
          //   logger.e("Exceptiom :${e.toString()}");
          //   _dialog.hide();
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text("User with this email already exists")));
          // }
          _dialog.hide();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User with this email already exists")));
        } else {
          logger.e("Else case");
          _dialog.hide();

          if (_userDataModel.user.questionOrder == 23) {
            if (_userDataModel.paid) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                (route) => false,
              );
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PaymentScreen()));
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LandingScreen(
                  signUpBody: widget.signUpBody,
                  userModel: _userDataModel,
                ),
              ),
            );
          }
        }
      } else {
        print(response.statusCode);
        print(response.body);
        _dialog.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signup error")));
      }
    } on SocketException catch (e) {
      print("hi2");
      print(e);
    } catch (e) {
      print("hi3");
      print(e.toString());
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Responsive1.isMobile(context)
            ? const EdgeInsets.all(8.0)
            : const EdgeInsets.only(left: 400, right: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verification Code",
              style: lightText18Px.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Please check your email and enter 4 digit verification code.",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: darkText12Px,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_fieldOne, true),
                OtpInput(_fieldTwo, false),
                OtpInput(_fieldThree, false),
                OtpInput(_fieldFour, false)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  UIBlock.blockWithData(context);
                  setState(() {
                    _otp = _fieldOne.text +
                        _fieldTwo.text +
                        _fieldThree.text +
                        _fieldFour.text;
                  });
                  print("OTP:- $_otp");
                  if (_fieldOne.text != '' &&
                      _fieldTwo.text != "" &&
                      _fieldThree.text != "" &&
                      _fieldFour.text != "") {
                    verifyOTP(_otp).then((value) {
                      if (value != null) {
                        UIBlock.unblock(context);
                        print(value);
                        if (value.toString() ==
 "{response: OTP code is not valid}") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter valid OTP")));
                        } else {
                          if (widget.text == "Signup") {
                            /*signUpUser().then((value) {
                              //UIBlock.unblock(context);
                            });*/

                            ///Todo: Skip OTP flow when user Filled all the questions
                            /*    Responsive1.isMobile(context)
                                ? Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                                    (route) => false)
                                : Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => SideMenu()),
                                    (route) => false);*/
                          } else if (widget.text == "SignupFirstPage") {
                            //direct from first screen
                            signUpUserNewAPI().then((value) {
                              //UIBlock.unblock(context);
                            });

                            /*       /// first fill the questions and at the end call sign up api
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs(signUpBody: widget.signUpBody)));*/

                            /*       Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AboutUs(
                                                    signUpBody: widget.signUpBody)));*/
                          } else {
                            NewPasswordDialog(
                                context, "Reset New Password", widget.email);
                          }
                        }
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter  OTP")));
                  }
                },
                child: const Text('Submit')),
            const SizedBox(
              height: 30,
            ),
            // Display the entered OTP code
          ],
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpInput(this.controller, this.autoFocus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextFormField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        validator: (value) {
          print(value);
          return Validation.validateValue(value, 'number', true);
        },
      ),
    );
  }
}

String _pwd = "";
String _pwd2 = "";
TextEditingController pwd = TextEditingController();
TextEditingController pwd2 = TextEditingController();

Future NewPasswordDialog(BuildContext context, String text, email) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 150,
        child: AlertDialog(
          title: const Text("Reset Password"),
          content: SizedBox(
            height: 170,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomFormFields.formFieldWithoutIcon(
                    controller: pwd,
                    hint: 'Password',
                    icon: const Icon(
                      Icons.lock_open_rounded,
                      color: primaryColor,
                      size: 30,
                    ),
                    validator: (value) {
                      print(value);
                      return Validation.validateValue(value, 'Password', true);
                    },
                    onChange: (val) {
                      _pwd = val;
                    },
                    onSaved: (val) {
                      _pwd = val;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomFormFields.formFieldWithoutIcon(
                    controller: pwd2,
                    hint: 'Confirm Password',
                    icon: const Icon(
                      Icons.lock_outline,
                      color: primaryColor,
                      size: 30,
                    ),
                    validator: (value) {
                      print(value);
                      return Validation.validateValue(
                          value, 'Confirm password', true);
                    },
                    onChange: (val) {
                      _pwd2 = val;
                    },
                    onSaved: (val) {
                      _pwd2 = val;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              child: const Text('Submit'),
              onPressed: () {
                if (pwd.text.isEmpty || pwd2.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Enter password")));
                } else {
                  if (_pwd == _pwd2) {
                    UIBlock.block(context);
                    resetPassword(_pwd, email).then((value) {
                      UIBlock.unblock(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Password Updated Successfully")));
                      Get.to(() => const LoginScreen());
                    });
                  } else {
                    UIBlock.unblock(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password doesn't match")));
                  }
                }

                // Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

int userid;

Future<ProfileVM> resetPassword(String Password, email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/Login/UpdatePassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"email": email, "Password": Password}),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return ProfileVM.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Update.');
  }
}
