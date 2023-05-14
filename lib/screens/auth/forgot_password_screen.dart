import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/utils/validation.dart';
import 'package:weight_loser/widget/custom_form_fields.dart';

import '../../Service/AuthService.dart';
import '../../theme/TextStyles.dart';
import '../Questions_screen/used-Questions/gender_screen.dart';
import 'Otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String _email = "";
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height - kToolbarHeight;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: Responsive1.isMobile(context)
                ? EdgeInsets.symmetric(horizontal: width * 0.05)
                : const EdgeInsets.only(left: 400, right: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.35,
                ),
                Text(
                  'Forgot Password',
                  style: lightText18Px.copyWith(
                      fontWeight: FontWeight.bold, fontSize: height * 0.025),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Form(
                  key: form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormFields.formFieldWithoutIcon(
                        controller: emailController,
                        hint: 'Email Address',
                        icon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black38,
                          size: 30,
                        ),
                        validator: (value) {
                          print(value);
                          return Validation.validateValue(value, 'Email', true);
                        },
                        onChange: (val) {
                          _email = val;
                        },
                        onSaved: (val) {
                          _email = val;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      TextButton(
                        onPressed: () {
                          print(_email);
                          if (_email != "") {
                            if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(_email)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Please Enter valid email")));
                              return;
                            }
                            UIBlock.block(context);
                            forgetPassword(_email).then((value) {
                              print(value.toString());
                              if (value != null) {
                                UIBlock.unblock(context);
                                if (value.toString().contains(
                                    "User with the email doesn't exists")) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text(
                                              "unable to find your email")));
                                } else {
                                  Get.to(() => OTPScreen(
                                        email: _email,
                                        text: 'Reset',
                                      ));
                                  Flushbar(
                                    title: 'Message',
                                    message:
                                        'Otp generated successfully',
                                    duration: const Duration(seconds: 3),
                                    backgroundColor: Colors.green,
                                  ).show(context);
                                }
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please Enter your registered email")));
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenderScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width * 0.8,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white, fontSize: height * 0.02),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
