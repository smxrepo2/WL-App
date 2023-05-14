import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../Model/SignupBody.dart';
import '../../Model/UserDataModel.dart';
import '../../Service/Responsive.dart';
import '../../utils/AppConfig.dart';
import '../../utils/ImagePath.dart';
import '../../utils/validation.dart';
import '../../widget/custom_form_fields.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';
import 'methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpBody signUpBody = SignUpBody();
  SimpleFontelicoProgressDialog _dialog;
  final form = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth;
  String _name = "";
  String _email = "";
  String _pwd = "";
  // String _pwd2 = "";

  SharedPreferences prefs;
  Map<String, dynamic> userdata = {};
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pas = TextEditingController();
  // TextEditingController confirmPas = TextEditingController();

  // ignore: unused_field
  UserDataModel _userDataModel;

  @override
  void initState() {
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
    // get();
  }

  Future<bool> VerifyUser(String email) async {
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
        message: "Verifying User",
        type: SimpleFontelicoProgressDialogType.normal);
    var client = http.Client();

    try {
      var url = Uri.parse('$apiUrl/api/user/email/?Email=$email');
      var response = await client.get(url);

      if (response != null && response.statusCode == 200) {
        if (!response.body.contains("IsConfirmed")) {
          _dialog.hide();
          return true;
        } else {
          _dialog.hide();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("User with this email already exists")));
        }
      } else {
        print(response.statusCode);
        print(response.body);
        _dialog.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "There is a problem in sign up. Please check internet or try again"),
          ),
        );
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

  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height - kToolbarHeight;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: Responsive1.isDesktop(context)
                  ? const EdgeInsets.only(
                      top: 150, bottom: 100, left: 450, right: 450)
                  : EdgeInsets.symmetric(horizontal: width * .05),
              child: SingleChildScrollView(
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .06,
                        child: Image.asset(
                          'assets/images/weightchopper.png',
                        ),
                      ),
                      SizedBox(height: height * .02),
                      Text(
                        'Getting Started',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: height * .036),
                      ),
                      SizedBox(height: height * .01),
                      Text(
                        'Promotion Line, Action Line',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: height * .031),
                      ),
                      SizedBox(height: height * .05),
                      CustomFormFields.formFieldWithoutIcon(
                        controller: name,
                        hint: 'Name*',
                        //errorText:
                        //  Validation.validateValue(_email, 'Email', true),
                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.black,
                          size: 30,
                        ),
                        validator: (value) {
                          return Validation.validateValue(_name, 'Name', false);
                        },
                        onChange: (val) {
                          setState(() {
                            _name = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            _name = val;
                          });
                        },
                        keyboardType: TextInputType.name,
                      ),
                      // TextFormField(
                      //   controller: name,
                      //   cursorColor: Colors.grey,
                      //   validator: (value) {
                      //     return Validation.validateValue(
                      //         value, 'Name', false);
                      //   },
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _name = val;
                      //     });
                      //   },
                      //   onSaved: (val) {
                      //     setState(() {
                      //       _name = val;
                      //     });
                      //   },
                      //   keyboardType: TextInputType.name,
                      //   decoration: const InputDecoration(
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .3),
                      //       ),
                      //       //errorText: Validation.validateValue(
                      //       //  _name, 'Name', false),
                      //       prefixIcon: Icon(
                      //         Icons.person_outline,
                      //         color: Color(0xff4885ED),
                      //         size: 30,
                      //       ),
                      //       isDense: true,
                      //       contentPadding: EdgeInsets.only(
                      //         top: 8,
                      //       ),
                      //       prefixIconConstraints: BoxConstraints(
                      //         minWidth: 35,
                      //         minHeight: 35,
                      //       ),
                      //       enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .1),
                      //       ),
                      //       hintText: ' Name*',
                      //       hintStyle: TextStyle(
                      //           color: Colors.black38,
                      //           fontSize: 13,
                      //           letterSpacing: 0.3)),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormFields.formFieldWithoutIcon(
                        controller: email,
                        hint: 'Email*',
                        //errorText:
                        //  Validation.validateValue(_email, 'Email', true),
                        icon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        validator: (value) {
                          return Validation.validateValue(
                              _email, 'Email', true);
                        },
                        onChange: (val) {
                          setState(() {
                            _email = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            _email = val;
                          });
                        },
                        keyboardType: TextInputType.name,
                      ),
                      // TextFormField(
                      //   controller: email,
                      //   cursorColor: Colors.grey,
                      //   validator: (value) {
                      //     return Validation.validateValue(
                      //         value, 'Email', true);
                      //   },
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _email = val;
                      //     });
                      //   },
                      //   onSaved: (val) {
                      //     setState(() {
                      //       _email = val;
                      //     });
                      //   },
                      //   keyboardType: TextInputType.emailAddress,
                      //   decoration: const InputDecoration(
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .3),
                      //       ),
                      //       prefixIcon: Icon(
                      //         Icons.email_outlined,
                      //         color: Color(0xff4885ED),
                      //         size: 30,
                      //       ),
                      //       isDense: true,
                      //       contentPadding: EdgeInsets.only(
                      //         top: 8,
                      //       ),
                      //       prefixIconConstraints: BoxConstraints(
                      //         minWidth: 35,
                      //         minHeight: 35,
                      //       ),
                      //       enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .1),
                      //       ),
                      //       hintText: ' Email*',
                      //       //errorText: Validation.validateValue(
                      //       //  _email, 'Email', true),
                      //       hintStyle: TextStyle(
                      //           color: Colors.black38,
                      //           fontSize: 13,
                      //           letterSpacing: 0.3)),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormFields.formFieldWithoutIcon(
                        suffixIcon: isObscure
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                child: const Icon(FontAwesomeIcons.eyeSlash))
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                child: const Icon(FontAwesomeIcons.eye)),
                        isObscure: isObscure,
                        controller: pas,
                        hint: 'Password*',
                        //errorText:
                        //  Validation.validatePassword(_pwd, 'Password'),
                        icon: const Icon(Icons.lock_open_rounded,
                            color: Colors.black, size: 30),
                        validator: (value) {
                          return Validation.validatePassword(_pwd, 'Password');
                        },
                        onChange: (val) {
                          setState(() {
                            _pwd = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            _pwd = val;
                          });
                        },
                        keyboardType: TextInputType.name,
                      ),
                      // TextFormField(
                      //   controller: pas,
                      //   cursorColor: Colors.grey,
                      //   validator: (value) {
                      //     return Validation.validatePassword(
                      //         value, 'Password');
                      //   },
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _pwd = val;
                      //     });
                      //   },
                      //   onSaved: (val) {
                      //     setState(() {
                      //       _pwd = val;
                      //     });
                      //   },
                      //   keyboardType: TextInputType.visiblePassword,
                      //   decoration: const InputDecoration(
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .3),
                      //       ),
                      //       prefixIcon: Icon(
                      //         Icons.lock_open_rounded,
                      //         color: Color(0xff4885ED),
                      //         size: 30,
                      //       ),
                      //       isDense: true,
                      //       contentPadding: EdgeInsets.only(
                      //         top: 8,
                      //       ),
                      //       prefixIconConstraints: BoxConstraints(
                      //         minWidth: 35,
                      //         minHeight: 35,
                      //       ),
                      //       enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .1),
                      //       ),
                      //       hintText: ' Password*',
                      //       //errorText: Validation.validatePassword(
                      //       //  _pwd, 'Password'),
                      //       hintStyle: TextStyle(
                      //           color: Colors.black38,
                      //           fontSize: 13,
                      //           letterSpacing: 0.3)),
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // TextFormField(
                      //   controller: confirmPas,
                      //   cursorColor: Colors.grey,
                      //   validator: (value) {
                      //     return Validation.validatePassword(
                      //         _pwd2, "Confirm Password", true, _pwd);
                      //   },
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _pwd2 = val;
                      //     });
                      //   },
                      //   onSaved: (val) {
                      //     setState(() {
                      //       _pwd2 = val;
                      //     });
                      //   },
                      //   keyboardType: TextInputType.visiblePassword,
                      //   decoration: const InputDecoration(
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .3),
                      //       ),
                      //       prefixIcon: Icon(
                      //         Icons.lock_outline,
                      //         color: Color(0xff4885ED),
                      //         size: 30,
                      //       ),
                      //       isDense: true,
                      //       contentPadding: EdgeInsets.only(
                      //         top: 8,
                      //       ),
                      //       prefixIconConstraints: BoxConstraints(
                      //         minWidth: 35,
                      //         minHeight: 35,
                      //       ),
                      //       enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(width: .1),
                      //       ),
                      //       hintText: ' Confirm Password*',
                      //       //errorText: Validation.validatePassword(
                      //       //  _pwd2, "Confirm Password", true, _pwd),
                      //       hintStyle: TextStyle(
                      //           color: Colors.black38,
                      //           fontSize: 13,
                      //           letterSpacing: 0.3)),
                      // ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen(),
                                      ));
                                },
                                child: Text(
                                  "Forget Password ?",
                                  style: TextStyle(
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: width * .03,
                              )
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: height * .03,
                      ),
                      // signUp Button
                      _SignUpButton(),
                      SizedBox(
                        height: height * .02,
                      ),
                      //  already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: height * 0.022,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: width * .03,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .04,
                      ),
                      // thi is or signup Container for decaration
                      _orContanerText(),
                      SizedBox(
                        height: height * .04,
                      ),

                      // this row is indicate google signin button and facebooke login button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           // google signin widget
                          _googleSignInButtonWidget(),
                          /// facebooke signin widget
                          _facebookeSigninWidget(),
                         
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> sendOtp(String email, context) async {
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
      message: "Sending Verification Code",
      type: SimpleFontelicoProgressDialogType.normal,
      height: 125,
      width: 200,
    );
    var requestBody = {'email': email};
    final response = await post(
      Uri.parse('https://weightchoper.somee.com/api/login/EmailVerify'),
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

  Future createfirebaseAccount(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCrendetial = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCrendetial.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Widget _orContanerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * 0.002,
          width: width * 0.31,
          decoration: const BoxDecoration(color: Colors.black12),
        ),
        const FittedBox(child: Text('or sign up with')),
        Container(
          height: height * 0.002,
          width: width * 0.31,
          decoration: const BoxDecoration(color: Colors.black12),
        )
      ],
    );
  }

  Widget _SignUpButton() {
    return TextButton(
      onPressed: () {

        Navigator.push(context,MaterialPageRoute(builder: (context) =>const  LoginScreen(),));
  //       /*
  // if (_pwd.isNotEmpty &&
  //   _pwd2.isNotEmpty &&
  //   _pwd == _pwd2)
  //   */
  //       final FormState formState = form.currentState;

  //       if (formState.validate()) {
  //         var provider = getit<AuthModeprovider>();
  //         provider.setData(false);
  //         signUpBody.userName = _name;
  //         signUpBody.name = _name;
  //         signUpBody.email = _email;
  //         signUpBody.password = _pwd;
  //         var datetime = DateTime.now();
  //         //var datetime = "2022-06-21T12:22:47259Z";
  //         SignUpRequestModel requestModel = SignUpRequestModel(
  //             userName: _name,
  //             name: _name,
  //             email: _email,
  //             password: _pwd,
  //             UserDateTime: datetime.toIso8601String());

  //         ///* verify email API Call
  //         VerifyUser(_email).then((value) {
  //           if (value) {
  //             /* Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => AboutUs(
  //                 signUpBody: signUpBody)));*/

  //             // signUpUser(signUpBody).then((value) {
  //             //
  //             // });

  //             ///* Send OTP API Call
  //             sendOtp(signUpBody.email, context).then((value) {
  //               print('asdlAAAAAAAAAAAAAAAsend Api Call${signUpBody.email}');
  //               if (value) {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => OTPScreen(
  //                       email: signUpBody.email,
  //                       text: 'SignupFirstPage',
  //                       signUpBody: signUpBody,
  //                       signUpRequestModel: requestModel,
  //                       userDataModel: _userDataModel,
  //                     ),
  //                   ),
  //                 );
  //               }
  //             });
  //           }
  //         });
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text("Please fill the required information"),
  //           backgroundColor: Colors.red,
  //         ));
  //       }
      },
      child: Container(
        height: height * .064,
        width: width * .7,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: const Center(
          child: Text(
            'SignUp',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

 Widget _googleSignInButtonWidget() {
    return InkWell(
      onTap: () async {
        bool isOnline = await hasNetwork();
        if (isOnline) {
          if (_firebaseAuth.currentUser == null) {
            print(
                "${_firebaseAuth.currentUser}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            await googleSignIn(context, _firebaseAuth, prefs);
          } else {
            await _firebaseAuth.signOut();
            await googleSignIn(context, _firebaseAuth, prefs);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Check internet connection')));
        }
         
      },
      child: Container(
        width: width * 0.4,
        height: height * 0.065,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                0,
                4,
              ), // changes position of shadow
            ),
          ],

          // borderRadius:
          //     BorderRadius.all(Radius.circular(40))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            SizedBox(
              height: height * 0.04,
              child: Image.asset(
                ImagePath.google,
                height: 30,
                width: 30,
              ),
            ),
            Text(
              'Google',
              style: TextStyle(
                  fontSize: height * 0.02, fontWeight: FontWeight.w600),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _facebookeSigninWidget() {
    return InkWell(
      onTap: () async {
        bool isOnline = await hasNetwork();
        if (isOnline) {
          if (_firebaseAuth.currentUser == null) {
            await facebookSignIn(context, _firebaseAuth, prefs);
          } else {
            await _firebaseAuth.signOut();
            await facebookSignIn(context, _firebaseAuth, prefs);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Check internet connection')));
        }
      },
      child: Container(
        width: width * 0.4,
        height: height * 0.065,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                0,
                4,
              ), // changes position of shadow
            ),
          ],

          // borderRadius:
          //     BorderRadius.all(Radius.circular(40))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            SizedBox(
              height: height * 0.04,
              child: Image.asset(
                ImagePath.facebook,
                height: 30,
                width: 30,
              ),
            ),
            Text(
              'Facebook',
              style: TextStyle(
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }




}
 