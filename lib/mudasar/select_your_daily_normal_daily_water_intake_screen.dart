import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectyourDailynormaldailywaterintake extends StatefulWidget {
  const SelectyourDailynormaldailywaterintake({Key key}) : super(key: key);

  @override
  State<SelectyourDailynormaldailywaterintake> createState() =>
      _SelectyourDailynormaldailywaterintakeState();
}

class _SelectyourDailynormaldailywaterintakeState extends State<SelectyourDailynormaldailywaterintake> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    print(check);
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                SizedBox(
                    height: height * 0.1,
                    width: width,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Biology',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.01,
                                        width: width * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(20),
                                              right: Radius.circular(20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Diet',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.01,
                                        width: width * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(20),
                                              right: Radius.circular(20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Excersie',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.01,
                                        width: width * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(20),
                                              right: Radius.circular(20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Mind',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.01,
                                        width: width * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(20),
                                              right: Radius.circular(20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sleep/Habit',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.01,
                                        width: width * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(20),
                                              right: Radius.circular(20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: height * 0.68,
                  width: width,
                  child: Stack(
                    children: [
                      Container(
                        height: height * 0.2,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(227, 194, 247, 1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        child: Center(
                          child: Text(
                            'Let us Understand Your Profile ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.02),
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.13,
                          left: height * 0.04,
                          child: Container(
                            height: height * 0.15,
                            width: width * 0.85,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Select your Daily Normal   ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.04),
                                        ),
                                      )),
                                  FittedBox(
                                      child: Text(
                                        "daily water intake",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: height * 0.032),
                                      )),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          )),

                      ///these are the text form fields
                      Positioned(
                        top: height * 0.35,
                        child: Container(
                          height: height * 0.4,
                          width: width,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  print('tabperhehr *************');
                                  check = true;
                                  setState(() {
                                  });
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: check==false? Colors.white : Colors.lightBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(height*0.02)),
                                          border: Border.all(color: Colors.black)),

                                      height: height * 0.078,
                                      child: Padding(
                                        padding:   EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(

                                              children: [
                                                SizedBox(
                                                    height: height*0.04,
                                                    child: Image.asset('assets/glass.png')),
                                                SizedBox(
                                                    height: height*0.04,
                                                    child: Image.asset('assets/glass.png')),
                                                SizedBox(
                                                    height: height*0.04,
                                                    child: Image.asset('assets/glass.png')),
                                                SizedBox(
                                                    height: height*0.04,
                                                    child: Image.asset('assets/glass.png')),
                                                SizedBox(
                                                    height: height*0.04,
                                                    child: Image.asset('assets/glass.png')),
                                                SizedBox(width: width*0.03,),
                                                Text('More then Eight Glasses',style: TextStyle(
                                                    fontSize: height*0.02,
                                                    fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            Icon(Icons.check_circle)
                                          ],),
                                      ),
                                    )),
                              ),

                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(height*0.02)),
                                        border: Border.all(color: Colors.black)),

                                    height: height * 0.078,
                                    child: Padding(
                                      padding:   EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              height: height*0.04,
                                              child: Image.asset('assets/glass.png')),
                                          SizedBox(
                                              height: height*0.04,
                                              child: Image.asset('assets/glass.png')),
                                          SizedBox(
                                              height: height*0.04,
                                              child: Image.asset('assets/glass.png')),
                                          SizedBox(width: width*0.03,),
                                          Text('Less then Eight Glasses',style: TextStyle(
                                              fontSize: height*0.02,
                                              fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(height*0.02)),
                                        border: Border.all(color: Colors.black)),

                                    height: height * 0.078,
                                    child: Padding(
                                      padding:   EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text("?",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold,fontSize: height*0.03),),
                                          SizedBox(width: width*0.03,),
                                          Text('Do Not Count',style: TextStyle(
                                              fontSize: height*0.02,
                                              fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.07,
                  width: width * 0.6,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: height * 0.024,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.01,
                      width: width / 2,
                      child: LinearProgressIndicator(
                        minHeight: height * 0.02,
                        color: Colors.black,
                        value: 1.6,
                      ),
                    ),
                    Text('60 % Completed'),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}