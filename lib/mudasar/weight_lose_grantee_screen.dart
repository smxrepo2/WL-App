
import 'package:flutter/material.dart';

class Weight_lose_gurentee extends StatefulWidget {
  const Weight_lose_gurentee({Key key}) : super(key: key);

  @override
  State<Weight_lose_gurentee> createState() => _Weight_lose_gurenteeState();
}

class _Weight_lose_gurenteeState extends State<Weight_lose_gurentee> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///here you can put the logo of your application
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      'WEIGHT ',
                      style: TextStyle(
                          fontSize: height * 0.05, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'LOSER',
                      style: TextStyle(
                          fontSize: height * 0.05, fontWeight: FontWeight.w300),
                    ),
                  ),

                  ///here is the end of the top row
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Container(
                  color: Colors.black,
                  height: height * 0.01,
                ),
              ),

              ///here is the scratch code of you application logo........
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Weight Lose Guarantee',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.04,
                    color: Colors.black87),
              ),

              Text(
                'Money Back Guarantee',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.025,
                    color: Colors.black54),
              ),

              /// this is the first parah garaph
              FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: height * 0.25,
                    width: width,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text( "At our app, we're committed to helping our users achieve their weight loss goals with \n personalized support and expert guidance.",
                          style: TextStyle(fontSize: height * 0.03),
                         ),
                    ),
                  ),
                ),
              ),

              ///end of the first parah graph
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(30)),
                  ),
                  elevation: 40,
                  child: FittedBox(
                    child: Container(
                      height: height * 0.3,
                      width: width,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(  "if you use our app even with 60% compliance we are so confident you are reach 100% of your goal by June 10. if our app do not help to loss weight we will refund your money. So why wait?",
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.02,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 50,vertical: 40),
                child: FittedBox(
                  child: Container(
                    child: Center(
                      child: Text(
                        "Start from today and start your journey\ntowards a healthier, happier you!",
                        style: TextStyle(fontSize: height*0.04),
                          ),
                    ),
                  ),
                ),
              ),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}