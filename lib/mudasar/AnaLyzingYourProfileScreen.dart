import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/weight_lose_guarantee.dart';
class AnaLyzingYourProfileScreen extends StatefulWidget {
  const AnaLyzingYourProfileScreen({Key key}) : super(key: key);
  @override
  State<AnaLyzingYourProfileScreen> createState() =>
      _AnaLyzingYourProfileScreenState();
}
class _AnaLyzingYourProfileScreenState
    extends State<AnaLyzingYourProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kTextTabBarHeight;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .08),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              FittedBox(
                child: Text(
                  'Analyzing Your profile',
                  style: TextStyle(
                      fontSize: height * 0.033, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FittedBox(
                child: Text(
                  'We  Create Best Plan for You',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.025,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              // firstColumn of biological
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Biological',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * .013,
                        width: width * .65,
                        child: const LinearProgressIndicator(
                            color: Colors.black12,
                            value: .2,
                            minHeight: 1,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xffD7E2F1)),
                            backgroundColor: Colors.grey),
                      ),
                      FittedBox(
                        child: Text(
                          '20%',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.black12,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Exercise',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * .013,
                        width: width * .65,
                        child: const LinearProgressIndicator(
                            color: Colors.black12,
                            value: .35,
                            valueColor:
                                AlwaysStoppedAnimation(Color(0xffFFC5C4)),
                            minHeight: 1,
                            backgroundColor: Colors.grey),
                      ),
                      FittedBox(
                        child: Text(
                          '35%',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.black12,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Diet',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * .013,
                        width: width * .65,
                        child: const LinearProgressIndicator(
                            color: Colors.black12,
                            value: .65,
                            valueColor:
                                AlwaysStoppedAnimation(Color(0xffE3C2F7)),
                            minHeight: 1,
                            backgroundColor: Colors.grey),
                      ),
                      FittedBox(
                        child: Text(
                          '65%',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.black12,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Sleep/Habit',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * .013,
                        width: width * .65,
                        child: const LinearProgressIndicator(
                            color: Colors.black12,
                            value: .85,
                            minHeight: 1,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xffF4C2AB)),
                            backgroundColor: Colors.grey),
                      ),
                      FittedBox(
                        child: Text(
                          '85%',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.black12,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeightLoseGuarantee(),
                    ),
                  );
                },
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
    );
  }
}
