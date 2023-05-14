import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/timer_screen.dart';

class WeightLoseGuarantee extends StatefulWidget {
  const WeightLoseGuarantee({Key key}) : super(key: key);

  @override
  State<WeightLoseGuarantee> createState() => _WeightLoseGuaranteeState();
}

class _WeightLoseGuaranteeState extends State<WeightLoseGuarantee> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: width*.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: Image.asset(
                    'assets/images/weightchopper.png',
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Weight Lose Guarantee',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.033,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Money Back Guarantee',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height * .03,
                      letterSpacing: .04,
                      color: Colors.black45),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "At our app, we're committed to helping our users achieve "
                  "their weight loss goals with\npersonalized support and expert guidance.",
                  style:
                      TextStyle(fontSize: height * 0.025, color: Colors.black54),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(height * .02)),
                  elevation: 4,
                  child: FittedBox(
                    child: SizedBox(
                      height: height * .25,
                      width: width,
                      child: Center(
                        child: Padding(
                          padding:   EdgeInsets.symmetric(horizontal: width*.04),
                          child: Text(
                            "if you use our app even with 60% compliance we are so confident you are reach 100% of your goal by June 10. if our app do not help to loss weight we will refund your money. So why wait?",
                            style: TextStyle(
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.w500,
                                letterSpacing: height*.001,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Start from today and start your journey ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: height * .025,
                          color: Colors.black45),
                    ),
                    Text(
                      'towards a healthier, happier you!',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: height * .025,
                          color: Colors.black45),
                    ),
                ],),
                SizedBox(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Timer_Screen(),));
                  } ,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.6,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "Let's Start",
                        style: TextStyle(
                            fontSize: height * 0.024,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
