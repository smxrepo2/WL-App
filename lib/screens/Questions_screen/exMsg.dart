import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/how_often_do_you_walk.dart';

class ExMsg extends StatefulWidget {
  SignUpBody signUpBody;
  ExMsg({this.signUpBody});

  @override
  State<ExMsg> createState() => _ExMsgState();
}

class _ExMsgState extends State<ExMsg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                SizedBox(height: 25),
                questionHeaderSimple(
                  percent: .99,
                  color: exBorder,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              ImagePath.exMsg,
              height: 290,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                "\“Sorry, there’s no magic bullet.\nYou gotta eat healthy and\nlive healthy to be healthy and\nlook healthy. End of story.\”\n\n- Morgan Spurlock",
                style: msgStyle,
                textAlign: TextAlign.center,
              )),
          Positioned(
            bottom: 10,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: () {
                Responsive1.isMobile(context)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HowOftenDoYouWalk(
                              signUpBody: widget.signUpBody,
                            )))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 430, right: 430, top: 30, bottom: 30),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: HowOftenDoYouWalk(
                                      signUpBody: widget.signUpBody)),
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        "Next",
                        style: buttonStyle,
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
