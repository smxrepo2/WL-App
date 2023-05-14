import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/screens/auth/methods.dart';
import 'package:weight_loser/screens/welcome_screen/landingScreen.dart';

import '../../../CustomWidgets/SizeConfig.dart';
import '../../../Model/UserDataModel.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../Service/chatService.dart';
import '../../../utils/Responsive.dart';
import '../../../utils/sizeconfig.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key key}) : super(key: key);
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserDataModel _userDataModel = UserDataModel();

  bool isloading = false;
  SignUpBody signUpBody = SignUpBody();
  Future myFuture;
  
  @override
  void initState() {
    super.initState();
    myFuture = futurelogin(context);
    //futurelogin();
  }
  @override
  Widget build(BuildContext context) {
   
    MySize().init(context);
    SizeConfig().init(context);
    Responsive().setContext(context);
    return Scaffold(
        body: _auth.currentUser != null || AuthService.getUserId() != null
            ? FutureBuilder(
                future: myFuture,
                builder: ((context, snapshot) {
                  return _userDataModel.user.id == null? const LoginScreen(): _userDataModel.paid? BottomBarNew(0): LandingScreen(signUpBody: signUpBody, userModel: _userDataModel);
                }),
              )
            : const LoginScreen());
  }
/*
  futurelogin(context) async {
    await otherloginUser(_auth.currentUser.email, context, _userDataModel)
        .then((value) {
      if (value == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (value != null) {
        _userDataModel = value;
        print("Snapshot Data:${_userDataModel.user.id}");

        ChatService.senderId = _userDataModel.user.id.toString();
        Provider.of<UserDataProvider>(context, listen: false)
            .setUserData(_userDataModel);
        AuthService.setUserId(_userDataModel.user.id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SideMenu()),
        );
      }

      return Center(child: CircularProgressIndicator());
    });
  }
  */
  futurelogin(BuildContext context) async {
   final   provider= Provider.of<UserDataProvider>(context, listen: false);
    if (_auth.currentUser != null) {
      debugPrint('${_auth.currentUser}');
      await otherloginUser(_auth.currentUser.email, context, _userDataModel)
          .then((value) {
        if (value == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          provider.setUserData(_userDataModel);
          _userDataModel = value;
          print("Snapshot Data:${_userDataModel.user.id}");
          ChatService.senderId = _userDataModel.user.id.toString();
          AuthService.setUserId(_userDataModel.user.id);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomBarNew(0)),
            (route) => false,
          );
        }
      });
    }
    int userId;
    int questionOrder;
    bool paid;
    await AuthService.getTokens().then((value) {
      userId = value;
    });
    await AuthService.getQuestionOrder().then((value) {
      questionOrder = value;
    });
    await AuthService.getPaid().then((value) {
      paid = value;
      paid ??= false;
    });

    setState(() {
      _userDataModel = UserDataModel(
        user: UserLocal(
          id: userId,
          questionOrder: questionOrder,
        ),
        paid: paid,
      );
    });
    provider.setUserData(_userDataModel);
    ChatService.senderId = _userDataModel.user.id.toString();
    await AuthService.setUserId(_userDataModel.user.id);
    print("Snapshot Data:${_userDataModel.user.id}");
  }
}
