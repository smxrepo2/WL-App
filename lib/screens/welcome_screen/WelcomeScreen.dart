import 'package:flutter/material.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/screens/auth/signup.dart';
import 'package:weight_loser/screens/chat/ChatBotScreen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/Responsive.dart';
import 'package:weight_loser/widget/SizeConfig.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    SizeConfig().init(context);
    Responsive().setContext(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Lets get your journey started \ntowards a healthy life",
                  textAlign: TextAlign.center,
                  style: darkText18Px.copyWith(
                      fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                "Are you familiar with calorie tracker?",
                style: darkText16Px.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 4,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.3,
                height: 30,
                // ignore: deprecated_member_use
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => ChatBotScreen()));
                  },
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "No",
                    style: darkText12Px,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.3,
                height: 30,
                // ignore: deprecated_member_use
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                  },
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Yes",
                    style: darkText12Px,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "SIGN IN TO EXISTING ACCOUNT",
                    style: darkText12Px,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
