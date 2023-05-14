import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/AuthService.dart';
import 'package:weight_loser/Service/chatService.dart';
import 'package:weight_loser/screens/auth/forgot_password_screen.dart';
import 'package:weight_loser/screens/auth/methods.dart';
import 'package:weight_loser/screens/auth/signup.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/utils/Responsive.dart';
import 'package:weight_loser/utils/validation.dart';
import 'package:weight_loser/widget/SizeConfig.dart';
import 'package:weight_loser/widget/custom_form_fields.dart';

import '../../main.dart';
import '../../theme/TextStyles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool isObscure = true;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _firebaseAuth;
  SharedPreferences prefs;
  String _email = '';
  String _pwd = '';
  double heigh;
  double width;
  @override
  void initState() {
    // _emailController.text = "Shabby123";
    // _passwordController.text = "12354555";
    // _emailController.text = "Abhi@gmail.com";
    // _passwordController.text = "123123";
    // _emailController.text="pranav1@gmail.com";
    // _passwordController.text="56789";
    // _emailController.text="omnivore@test.com";
    // _passwordController.text="123123123";
    _emailController.text = "";
    _passwordController.text = "";
    // _emailController.text="alergi@test.com";
    // _passwordController.text="123123123";
    // _emailController.text="newu@gmail.com";
    // _passwordController.text="123123123";
    // _emailController.text="test@test547.com";
    // _passwordController.text="12345678";
    // _emailController.text="Kairav@gmail.com";
    // _passwordController.text="123456";
    _firebaseAuth = FirebaseAuth.instance;
    super.initState();

    //   var androidSettings = AndroidInitializationSettings('app_icon');
    //   var iOSSettings = IOSInitializationSettings(
    //     requestSoundPermission: false,
    //     requestBadgePermission: false,
    //     requestAlertPermission: false,
    //   );
    //   var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    //   flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onClickNotification);
    // }
    // Future onClickNotification(String payload) {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //     return BottomBarNew(
    //       0
    //     );
    //   }));
  }

  /*
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
  }
  */

  final form = GlobalKey<FormState>();

  Map<String, dynamic> userdata;

  // ignore: unused_field
  UserDataModel _userDataModel;

  // ignore: unused_element
  Future firebaselogIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim().toString(),
          password: _passwordController.text.trim().toString());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> _loginUser() async {
    UIBlock.block(context);
    await firebaselogIn();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
      };
      var request = http.Request(
          'POST', Uri.parse('https://weightchoper.somee.com/api/login'));
      request.body = json.encode({
        "Name": _emailController.text,
        "Password": _passwordController.text
      });
      request.headers.addAll(headers);

      logger.e("Login Request Body :" + request.toString());
      http.StreamedResponse response = await request.send();
      var resp = await response.stream.bytesToString();

      logger.e("Login Response :" + resp.toString());
      if (response.statusCode == 200) {
        UIBlock.unblock(context);
        userdata = json.decode(resp);
        _userDataModel = UserDataModel.fromJson(userdata);
        if (_userDataModel.responseDto.status) {
          final provider =
              Provider.of<UserDataProvider>(context, listen: false);
          provider.setUserData(_userDataModel);
          ChatService.senderId = _userDataModel.user.id.toString();
          print(userdata.runtimeType);
          AuthService.setUserId(_userDataModel.user.id);
          print(_userDataModel.user.id);
          return true;
        } else {
          return false;
        }
      } else {
        print(response.reasonPhrase);
        //UIBlock.unblock(context);
        return false;
      }
    } catch (e) {
      print(e.toString());
      //UIBlock.unblock(context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    heigh = MediaQuery.of(context).size.height - kToolbarHeight;
    width = MediaQuery.of(context).size.width;

    MySize().init(context);
    SizeConfig().init(context);
    Responsive().setContext(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: heigh * .08,
                    ),
                    SizedBox(
                      height: heigh * 0.05,
                      child: Image.asset(
                        'assets/images/weightchopper.png',
                      ),
                    ),
                    SizedBox(height: heigh * 0.02),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontSize: heigh * 0.04, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: heigh * 0.01),
                    Text(
                      'Enter your details below',
                      style: lightText18Px.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 19),
                    ),
                     SizedBox(height: heigh * 0.07),
                    CustomFormFields.formFieldWithoutIcon(
                      controller: _emailController,
                      hint: 'Email*',
                      //errorText:
                      //  Validation.validateValue(_email, 'Email', true),
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      validator: (value) {
                        return Validation.validateValue(_email, 'Email', true);
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

                    SizedBox(height: heigh * 0.03),
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
                      controller: _passwordController,
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgotPasswordScreen());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ForgotPasswordScreen();
                            }));
                          },
                          child: Text(
                            'Forgot password? ',
                            style: TextStyle(
                                color: Colors.blue, fontSize: heigh * 0.02),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigh * 0.06),

                    /// this is login button
                    _loginButton(),
                    SizedBox(height: heigh * 0.03),

                    /// do you have and account field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: heigh * 0.02),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: heigh * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: heigh * 0.06),

                    ///  or text field
                    _orContanerText(),
                    SizedBox(height: heigh * 0.06),

                    /// google and facebook button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// signInWithGoogle
                        _googleSignInButton(),

                        /// signinWithFacebookAndGoogle
                        _facebookSignInButton(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const ForgotPasswordScreen() ,));
        // FocusScope.of(context).unfocus();
        // final FormState formState = form.currentState;
        // //if (_emailController.text.isEmpty ||
        // //  _passwordController.text.isEmpty)
        // if (!formState.validate()) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text("Please fill the required information"),
        //     backgroundColor: Colors.red,
        //   ));
        //   return;
        // } else {
        //   ChatService.senderId = _emailController.text;
        //   _loginUser().then((value) {
        //     if (value) {
        //       print("logged in");
        //       Provider.of<UserDataProvider>(context, listen: false)
        //           .setUserData(_userDataModel);
        //       AuthService.setQuestionOrder(_userDataModel.user.questionOrder);
        //       AuthService.setPaid(_userDataModel.paid);

        //       SignUpBody signupBody = SignUpBody();
        //       if (_userDataModel.user.questionOrder == 23) {
        //         if (_userDataModel.paid) {
        //           print(
        //               '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@user paid BottomBarNew user well come to the app');
        //           Navigator.pushAndRemoveUntil(
        //             context,
        //             MaterialPageRoute(builder: (context) => BottomBarNew(0)),
        //             (route) => false,
        //           );
        //         } else {
        //           print(
        //               '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ paid user well come to the app payment screeb');
        //           Navigator.of(context).push(MaterialPageRoute(
        //               builder: (context) => const PaymentScreen()));
        //         }
        //       } else {
        //         print(
        //             '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Landing screen well come to the app landing screen');
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => LandingScreen(
        //               signUpBody: signupBody,
        //               userModel: _userDataModel,
        //             ),
        //           ),
        //         );
        //       }
        //     } else {
        //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //         content: Text("Email or Password Incorrect"),
        //         backgroundColor: Colors.red,
        //       ));
        //     }
        //   }).onError((error, stackTrace) {
        //     ScaffoldMessenger.of(context)
        //         .showSnackBar(const SnackBar(content: Text("Error 404")));
        //   });
        // }
      },
      child: Container(
        height: heigh * 0.065,
        width: width * 0.8,
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white, fontSize: heigh * 0.02),
          ),
        ),
      ),
    );
  }

  Widget signinWithFacebookAndGoogle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Container(
            width: width * 0.4,
            height: heigh * 0.06,
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
              shape: BoxShape.circle,
// borderRadius:
//     BorderRadius.all(Radius.circular(40))
            ),
//margin: EdgeInsets.only(right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    ImagePath.facebook,
                    height: 30,
                    width: 30,
                  ),
                ),
                const Text(
                  'Facebooke',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
//if (Platform.isAndroid)
        /// this is google signin
        InkWell(
          onTap: () async {
            bool isOnline = await hasNetwork();
            if (isOnline) {
              if (_firebaseAuth.currentUser == null) {
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
            width: 60,
            height: 60,
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
              shape: BoxShape.circle,
              // borderRadius:
              //     BorderRadius.all(Radius.circular(40))
            ),
            //margin: EdgeInsets.only(right: 8, top: 8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                ImagePath.google,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
        //if (Platform.isIOS)
        InkWell(
          onTap: () {
// Navigator.push(
//   context,
//   MaterialPageRoute(
//       builder: (context) =>
//           CardDetailScreen()),
// );
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Not Integrated Yet.')));
          },
          child: Container(
            width: 60,
            height: 60,
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
              shape: BoxShape.circle,
// borderRadius:
//     BorderRadius.all(Radius.circular(40))
            ),
//margin: EdgeInsets.only(right: 8, top: 8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                ImagePath.apple,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// this is sign in with facebooke
  Widget _facebookSignInButton() {
    return InkWell(
      onTap: () async {
        bool isOnline = await hasNetwork();
        if (isOnline) {
          if (_firebaseAuth.currentUser == null) {
            debugPrint('facebooke medthod call @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
            await facebookSignIn(context, _firebaseAuth, prefs);
          } else {
            await _firebaseAuth.signOut();
            await facebookSignIn(context, _firebaseAuth, prefs);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Check internet connection'),
            ),
          );
        }
      },
      child: Container(
        width: width * 0.4,
        height: heigh * 0.065,
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
              height: heigh * 0.04,
              child: Image.asset(
                ImagePath.facebook,
                height: 30,
                width: 30,
              ),
            ),
            Text(
              'Facebook',
              style: TextStyle(
                  fontSize: heigh * 0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  /// this is sign in with google
  Widget _googleSignInButton() {
    return InkWell(
      onTap: () async {
        bool isOnline = await hasNetwork();
        if (isOnline) {
          if (_firebaseAuth.currentUser == null) {
            debugPrint(
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
        height: heigh * 0.065,
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
              height: heigh * 0.04,
              child: Image.asset(
                ImagePath.google,
                height: 30,
                width: 30,
              ),
            ),
            Text(
              'Google',
              style: TextStyle(
                  fontSize: heigh * 0.02, fontWeight: FontWeight.w600),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  /// this is or container text widget
  Widget _orContanerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: heigh * 0.002,
          width: width * 0.36,
          decoration: const BoxDecoration(color: Colors.black12),
        ),
        const FittedBox(child: Text('  or  ')),
        Container(
          height: heigh * 0.002,
          width: width * 0.36,
          decoration: const BoxDecoration(color: Colors.black12),
        )
      ],
    );
  }

  Future<String> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    return 'signInWithGoogle succeeded: $user';
  }

  Widget _checkGoogleSignIn() {
    return ElevatedButton(
        onPressed: () async {
          await signInWithGoogle();
        },
        child: const Text('this is foo signIn Google '));
  }
}
