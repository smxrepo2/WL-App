import 'package:flip_widget/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uiblock/uiblock.dart';
import 'dart:math' as math;

import 'package:weight_loser/models/get_cbt_questions.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/cbt/methods.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../Bottom_Navigation/bottom.dart';
import 'cbt_noti_provider.dart';

class CBTScreen extends StatefulWidget {
  const CBTScreen({Key key}) : super(key: key);

  @override
  State<CBTScreen> createState() => _CBTScreenState();
}

class _CBTScreenState extends State<CBTScreen> {
  GlobalKey<FlipWidgetState> _flipKey = GlobalKey();
  Future<CbtQuestions> _cbtQuestions;
  CbtQuestions _Questions;
  int CorrectAnswer = 0;
  TextEditingController _answerTextField = new TextEditingController();
  var _cbtprovider = getit<cbtprovider>();

  Offset _oldPosition = Offset.zero;

  int pageIndex = 1;
  int selectedAnswer = -1;
  bool isAnswerSelected = false;
  int questionIndex = 0;
  List<Options> options;

  double _MinNumber = 0.008;

  double _clampMin(double v) {
    if (v < _MinNumber && v > -_MinNumber) {
      if (v >= 0) {
        v = _MinNumber;
      } else {
        v = -_MinNumber;
      }
    }
    return v;
  }

  @override
  void initState() {
    super.initState();

    _cbtQuestions = getCbtQuestions();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(500, 470);
    return Container(
      color: Colors.white,
      child: FutureBuilder<CbtQuestions>(
        future: _cbtQuestions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _cbtprovider.setQuestionsData(snapshot.data);
            _Questions = _cbtprovider.getQuestionsData();
            print("CBT Response:" + _Questions.audioes.length.toString());

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                title: null,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      if (pageIndex - 1 >= 1) {
                        pageIndex -= 1;
                        if (questionIndex - 1 >= 0) questionIndex -= 1;
                      }

                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              body: Center(child: LoadQuestions(size)),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<Options> getOptions(int index) {
    List<Options> options = [];
    for (int i = 0; i < _Questions.audioes[index].options.length; i++) {
      options.add(_Questions.audioes[index].options[i]);
    }
    print(_Questions.audioes[index].type);
    print('opption here');
    print(options);
    return options;
  }

  /*************************************************New Load Questions Widget***************************/
  Widget LoadQuestions(Size size) {
    //var _cbtProvider = getit<cbtprovider>();

    return SingleChildScrollView(
      child: questionIndex >= _Questions.audioes.length
          ? Container(
              width: size.width,
              height: size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/cbt_complete.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "You have completed the CBT",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => BottomBarNew(0));
                        /*
                        setState(() {
                          questionIndex = 0;
                          Navigator.pop(context);
                        });
                        */
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black54, width: .5),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade300),
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontFamily: 'Book Antiqua',
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: -0.6,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
          : Column(
              children: [
                Text(
                  pageIndex == 0 ? 'Do you know?' : '',
                  style: TextStyle(
                    fontFamily: 'Sitka Small',
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                Visibility(
                  visible: pageIndex == 0 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: .001),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        child: GestureDetector(
                          onHorizontalDragStart: (details) {
                            _oldPosition = details.globalPosition;
                            _flipKey.currentState?.startFlip();
                          },
                          onHorizontalDragUpdate: (details) {
                            Offset off = details.globalPosition - _oldPosition;
                            double tilt = 1 / _clampMin((-off.dy + 20) / 100);
                            double percent =
                                math.max(0, -off.dx / size.width * 1.4);
                            percent = percent - percent / 2 * (1 - 1 / tilt);
                            _flipKey.currentState?.flip(percent, tilt);
                          },
                          onHorizontalDragEnd: (details) {
                            _flipKey.currentState?.stopFlip();
                            setState(() {
                              pageIndex += 1;
                            });
                          },
                          onHorizontalDragCancel: () {
                            _flipKey.currentState?.stopFlip();
                          },
                          child: FlipWidget(
                            key: _flipKey,
                            textureSize: size * 2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50, right: 50),
                                  child: Text(
                                    '${_Questions.audioes[questionIndex].questionTitle}',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    // softWrap: false,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '- - - - - - - - - - - - - - - ',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -1.5),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: (1 / .9)),
                                  itemCount: getOptions(questionIndex).length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    options = getOptions(questionIndex);
                                    return Container(
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 130,
                                            height: 90,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // border: Border.all(color: index == selectedIndex ? Colors.blue : Colors.white,width: 1),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                          '$imageBaseUrl${options[index].fileName}')
                                                      .image,
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            '${options[index].title}',
                                            style: TextStyle(
                                              fontFamily: 'Open Sans',
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            softWrap: false,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: pageIndex == 1 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: .001),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        child: FlipWidget(
                          key: _flipKey,
                          textureSize: size * 2,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Card(
                                  elevation: 0.8,
                                  shape: const RoundedRectangleBorder(),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 40,
                                          child: Text(
                                            '${_Questions.audioes[questionIndex].question}',
                                            style: const TextStyle(
                                              fontFamily: 'Open Sans',
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 2,
                                            // softWrap: false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          '- - - - - - - - - -',
                                          style: TextStyle(
                                              fontFamily: 'Open Sans',
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -1.5),
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: (1 / .9)),
                                itemCount: getOptions(questionIndex).length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  options = getOptions(questionIndex);
                                  // if (options![index].isCorrect!) {
                                  //   setState(() {
                                  //     CorrectAnswer = index;
                                  //   });
                                  // }

                                  return Container(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedAnswer = index;
                                              isAnswerSelected = true;
                                            });
                                          },
                                          child: Container(
                                            width: 130,
                                            height: 90,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: selectedAnswer == index
                                                    ? Colors.blue
                                                        .withOpacity(0.1)
                                                    : Colors.white,
                                                border: Border.all(
                                                  color: selectedAnswer == index
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  width: 1,
                                                ),
                                                /*
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                          'https://cdn.pixabay.com/photo/2022/09/16/13/07/woman-7458584__340.jpg')
                                                      .image,
                                                )
                                                */
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                          '$imageBaseUrl${options[index].fileName}')
                                                      .image,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '${options[index].title}',
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // ListView.builder(
                              //   itemCount: getOptions(questionIndex).length,
                              //   physics: NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   itemBuilder: (_, index) {
                              //     var options = getOptions(questionIndex);
                              //     return InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           selectedAnswer = index;
                              //           isAnswerSelected = true;
                              //         });
                              //       },
                              //       child: Container(
                              //         margin: const EdgeInsets.symmetric(
                              //             horizontal: 35, vertical: 5),
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 20, vertical: 25),
                              //         decoration: BoxDecoration(
                              //             color: selectedAnswer == index
                              //                 ? Colors.blue.withOpacity(0.1)
                              //                 : Colors.white,
                              //             borderRadius:
                              //                 BorderRadius.circular(8),
                              //             border: Border.all(
                              //               color: selectedAnswer == index
                              //                   ? Colors.blue
                              //                   : Colors.grey,
                              //               width: 1,
                              //             )
                              //         ),
                              //         child: Text(
                              //           options[index],
                              //           style: TextStyle(fontSize: 14),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 3,
                                indent: 30,
                                endIndent: 30,
                                color: selectedAnswer == CorrectAnswer
                                    ? Colors.green
                                    : selectedAnswer == -1
                                        ? Colors.grey.shade300
                                        : Colors.red,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // reasoning ? Text(
                              //   'Why?',
                              //   style: const TextStyle(
                              //     fontFamily: 'Open Sans',
                              //     fontSize: 15,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.normal,
                              //   ),
                              //   softWrap: false,
                              // ) : Container(),
                              // reasoning ? Padding(
                              //   padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                              //   child: TextFormField(
                              //     minLines: 3,
                              //     maxLines: 3,
                              //     cursorColor: Colors.grey,
                              //     decoration: InputDecoration(
                              //       hintText: 'Enter Something',
                              //       hintStyle: TextStyle(
                              //           color: Colors.grey,
                              //           fontSize: 11,
                              //           fontWeight: FontWeight.w500
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Colors.grey,
                              //             width: .3
                              //         ),
                              //         borderRadius: BorderRadius.circular(10.0),
                              //       ),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Colors.grey,
                              //             width: .3
                              //         ),
                              //         borderRadius: BorderRadius.circular(10.0),
                              //       ),
                              //     ),
                              //   ),
                              // ) : Container(),
                              // reasoning ? Text(
                              //   '9/10',
                              //   style: TextStyle(
                              //     fontFamily: 'Open Sans',
                              //     fontSize: 15,
                              //     color: Color(0xff005690),
                              //     fontWeight: FontWeight.normal,
                              //   ),
                              //   softWrap: false,
                              // ) :
                              Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Container(
                                  width: 90,
                                  height: 80,
                                  child: Center(
                                    child: Text(
                                      '1/${_Questions.audioes.length}',
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 15,
                                        color: Color(0xff005690),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.red
                          //     // image: DecorationImage(
                          //     //   image: AssetImage('assets/images/notepad.png'),
                          //     //   fit: BoxFit.contain,
                          //     // ),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         width: double.infinity,
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 40, vertical: 10),
                          //         child: Text(
                          //           '${_Questions!.audioes![questionIndex].question!}',
                          //           style: TextStyle(fontSize: 16),
                          //         ),
                          //       ),
                          //       SizedBox(height: 25),
                          //       Expanded(
                          //         child: ListView.builder(
                          //             itemBuilder: (context, index) {
                          //               var options = getOptions(questionIndex);
                          //               print('options here');
                          //               print(options);
                          //               return InkWell(
                          //                 onTap: () {
                          //                   setState(() {
                          //                     selectedAnswer = index;
                          //                     isAnswerSelected = true;
                          //                   });
                          //                 },
                          //                 child: Container(
                          //                   margin: const EdgeInsets.symmetric(
                          //                       horizontal: 35, vertical: 5),
                          //                   padding: const EdgeInsets.symmetric(
                          //                       horizontal: 20, vertical: 25),
                          //                   decoration: BoxDecoration(
                          //                       color: selectedAnswer == index
                          //                           ? Colors.blue.withOpacity(0.1)
                          //                           : Colors.white,
                          //                       borderRadius:
                          //                       BorderRadius.circular(8),
                          //                       border: Border.all(
                          //                         color: selectedAnswer == index
                          //                             ? Colors.blue
                          //                             : Colors.grey,
                          //                         width: 1,
                          //                       )),
                          //                   child: Text(
                          //                     options[index],
                          //                     style: TextStyle(fontSize: 14),
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             itemCount: getOptions(questionIndex).length
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    child: GestureDetector(
                      onHorizontalDragStart: (details) {
                        _oldPosition = details.globalPosition;
                        _flipKey.currentState?.startFlip();
                      },
                      onHorizontalDragUpdate: (details) {
                        Offset off = details.globalPosition - _oldPosition;
                        double tilt = 1 / _clampMin((-off.dy + 20) / 100);
                        double percent =
                            math.max(0, -off.dx / size.width * 1.4);
                        percent = percent - percent / 2 * (1 - 1 / tilt);
                        _flipKey.currentState?.flip(percent, tilt);
                      },
                      onHorizontalDragEnd: (details) {
                        _flipKey.currentState?.stopFlip();
                        setState(() {
                          pageIndex += 1;
                        });
                      },
                      onHorizontalDragCancel: () {
                        _flipKey.currentState?.stopFlip();
                      },
                      child: FlipWidget(
                        key: _flipKey,
                        textureSize: size * 2,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/notepad.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                child: Text(
                                  _Questions.audioes[questionIndex].question,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(height: 100),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _answerTextField,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Your answer',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     setState(() {
                    //       questionIndex += 1;
                    //       // pageIndex = 0;
                    //     });
                    //     if(questionIndex >= _Questions!.audioes!.length){
                    //       bool value = await submitCbtAnswer(
                    //           options[0].questionId,
                    //           'null',
                    //           'null'
                    //       );
                    //       print(value);
                    //     }
                    //   },
                    //   child: Text('Skip'),
                    //   style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //       ),
                    //       primary: new Color(0xff4885ED),
                    //       fixedSize: Size(150, 50)),
                    // ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     setState(() {
                    //       questionIndex += 1;
                    //       // pageIndex = 0;
                    //     });
                    //     if (questionIndex >= _Questions!.audioes!.length) {
                    //       bool value = await submitCbtAnswer(
                    //           options[0].questionId, 'null', 'null');
                    //       print(value);
                    //     }
                    //   },
                    //   child: Container(
                    //     width: 100,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //         border:
                    //             Border.all(color: Colors.black54, width: .5),
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.blue.shade300),
                    //     child: const Center(
                    //       child: Text(
                    //         'Skip',
                    //         style: TextStyle(
                    //           fontFamily: 'Book Antiqua',
                    //           fontSize: 20,
                    //           color: Colors.white,
                    //           letterSpacing: -0.6,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //         softWrap: false,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        if (pageIndex == 0) {
                          setState(() {
                            pageIndex++;
                            questionIndex++;
                          });
                          if (questionIndex >= _Questions.audioes.length) {
                            bool value = await submitCbtAnswer(
                                options[selectedAnswer].questionId,
                                options[selectedAnswer].title,
                                'null');
                            print(value);
                          }
                        } else if (pageIndex == 1) {
                          if (!isAnswerSelected) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Answer is mandatory'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            );
                          } else {
                            setState(() {
                              pageIndex--;
                              // questionIndex++;
                            });
                            // if (questionIndex >= _Questions!.audioes!.length) {
                            //   bool value = await submitCbtAnswer(
                            //       options![selectedAnswer].questionId!,
                            //       options![selectedAnswer].title!,
                            //       'null');
                            //   print(value);
                            // }
                          }
                        }
                        // setState(() {
                        //   pageIndex += 1;
                        // });
                        else if (pageIndex == 2 && !isAnswerSelected) {
                          setState(() {
                            pageIndex -= 1;
                          });
                          // show alert
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Answer is mandatory'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        } else if (pageIndex == 3) {
                          UIBlock.block(context);
                          await submitCbtAnswer(
                                  _Questions.audioes[questionIndex].id,
                                  getOptions(questionIndex)[selectedAnswer]
                                      .toString(),
                                  _answerTextField.text.trim().toString())
                              .then((value) {
                            if (value) {
                              UIBlock.unblock(context);
                              setState(() {
                                questionIndex += 1;
                                selectedAnswer = -1;
                                isAnswerSelected = false;
                                _answerTextField.text = '';
                                pageIndex = 0;
                              });
                            } else {
                              UIBlock.unblock(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                "Could not submit the answer",
                                style: TextStyle(color: Colors.red),
                              )));
                            }
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black54, width: .5),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade300),
                        child: pageIndex == 2
                            ? Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontFamily: 'Book Antiqua',
                                    fontSize: 20,
                                    color: Colors.white,
                                    letterSpacing: -0.6,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    fontFamily: 'Book Antiqua',
                                    fontSize: 20,
                                    color: Colors.white,
                                    letterSpacing: -0.6,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  /****************************************************************************************************** */

  // Widget OldLoadQuestions(Size size) {
  //   //var _cbtProvider = getit<cbtprovider>();
  //
  //   return SingleChildScrollView(
  //     child: questionIndex >= _Questions!.audioes!.length
  //         ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       Image.asset(
  //         'assets/icons/cbt_complete.png',
  //         width: 100,
  //         height: 100,
  //       ),
  //       SizedBox(height: 20),
  //       Text(
  //         "You have completed the CBT",
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: MediaQuery.of(context).size.height * 0.1),
  //       ElevatedButton(
  //         onPressed: () {
  //           // Get.to(() => BottomBarNew(0));
  //           //setState(() {
  //           //questionIndex = 0;
  //           //Navigator.pop(context);
  //           //});
  //         },
  //         child: Padding(
  //           padding:
  //           const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
  //           child: Text("Back to Dashboard",
  //               style:
  //               TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //         ),
  //         style: ElevatedButton.styleFrom(
  //           primary: Color(0xff4885ED),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ),
  //       ),
  //     ])
  //         : Column(
  //       children: [
  //         // Text(
  //         //   pageIndex == 0
  //         //       ? 'Do you know?'
  //         //       : pageIndex == 1
  //         //           ? 'Quiz'
  //         //           : pageIndex == 2
  //         //               ? 'Why?'
  //         //               : '',
  //         //   style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
  //         // ),
  //         SizedBox(height: 50),
  //         Visibility(
  //           visible: pageIndex == 0 ? true : false,
  //           child: Container(
  //             width: size.width,
  //             height: size.height,
  //             child: GestureDetector(
  //               onHorizontalDragStart: (details) {
  //                 _oldPosition = details.globalPosition;
  //                 _flipKey.currentState?.startFlip();
  //               },
  //               onHorizontalDragUpdate: (details) {
  //                 Offset off = details.globalPosition - _oldPosition;
  //                 double tilt = 1 / _clampMin((-off.dy + 20) / 100);
  //                 double percent =
  //                 math.max(0, -off.dx / size.width * 1.4);
  //                 percent = percent - percent / 2 * (1 - 1 / tilt);
  //                 _flipKey.currentState?.flip(percent, tilt);
  //               },
  //               onHorizontalDragEnd: (details) {
  //                 _flipKey.currentState?.stopFlip();
  //                 setState(() {
  //                   pageIndex += 1;
  //                 });
  //               },
  //               onHorizontalDragCancel: () {
  //                 _flipKey.currentState?.stopFlip();
  //               },
  //               child: FlipWidget(
  //                 key: _flipKey,
  //                 textureSize: size * 2,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.red,
  //                     image: DecorationImage(
  //                       image: AssetImage('assets/images/notepad.png'),
  //                       fit: BoxFit.contain,
  //                     ),
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       // Container(
  //                       //   width: double.infinity,
  //                       //   padding: const EdgeInsets.symmetric(
  //                       //       horizontal: 40, vertical: 12),
  //                       //   child: Text(
  //                       //     _Questions!.audioes![questionIndex].questionTitle!,
  //                       //     style: TextStyle(fontSize: 14),
  //                       //   ),
  //                       // ),
  //                       SizedBox(height: 25),
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                             left: 25, right: 25, bottom: 25),
  //                         child: Text(
  //                           _Questions!.audioes![questionIndex].question!,
  //                           style: TextStyle(fontSize: 14),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Visibility(
  //           visible: pageIndex == 1 ? true : false,
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 10, right: 10),
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                 side: BorderSide(color: Colors.grey, width: .001),
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Container(
  //                 width: size.width,
  //                 height: size.height,
  //                 child: GestureDetector(
  //                   onHorizontalDragStart: (details) {
  //                     _oldPosition = details.globalPosition;
  //                     _flipKey.currentState?.startFlip();
  //                   },
  //                   onHorizontalDragUpdate: (details) {
  //                     Offset off = details.globalPosition - _oldPosition;
  //                     double tilt = 1 / _clampMin((-off.dy + 20) / 100);
  //                     double percent =
  //                     math.max(0, -off.dx / size.width * 1.4);
  //                     percent = percent - percent / 2 * (1 - 1 / tilt);
  //                     _flipKey.currentState?.flip(percent, tilt);
  //                   },
  //                   onHorizontalDragEnd: (details) {
  //                     _flipKey.currentState?.stopFlip();
  //                     setState(() {
  //                       pageIndex += 1;
  //                     });
  //                     if (pageIndex == 2 && !isAnswerSelected) {
  //                       setState(() {
  //                         pageIndex -= 1;
  //                       });
  //                       // show alert
  //                       showDialog(
  //                         context: context,
  //                         builder: (context) => AlertDialog(
  //                           title: Text('Answer is mandatory'),
  //                           actions: [
  //                             TextButton(
  //                               child: Text('OK'),
  //                               onPressed: () {
  //                                 Navigator.pop(context);
  //                               },
  //                             )
  //                           ],
  //                         ),
  //                       );
  //                     }
  //                   },
  //                   onHorizontalDragCancel: () {
  //                     _flipKey.currentState?.stopFlip();
  //                   },
  //                   child: FlipWidget(
  //                     key: _flipKey,
  //                     textureSize: size * 2,
  //                     child: Column(
  //                       children: [
  //                         Card(
  //                           elevation: 0.5,
  //                           shape: const RoundedRectangleBorder(),
  //                           child: Container(
  //                             width: double.infinity,
  //                             height: 100,
  //                             child: Column(
  //                               children: [
  //                                 SizedBox(
  //                                   height: 20,
  //                                 ),
  //                                 Text(
  //                                   '${_Questions!.audioes![questionIndex].question}',
  //                                   style: const TextStyle(
  //                                     fontFamily: 'Open Sans',
  //                                     fontSize: 15,
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.normal,
  //                                   ),
  //                                   softWrap: false,
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 20,
  //                                 ),
  //                                 const Text(
  //                                   '- - - - - - - - - -',
  //                                   style: TextStyle(
  //                                       fontFamily: 'Open Sans',
  //                                       fontSize: 15,
  //                                       color: Colors.black,
  //                                       fontWeight: FontWeight.w700,
  //                                       letterSpacing: -1.5),
  //                                   softWrap: false,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                         GridView.builder(
  //                           gridDelegate:
  //                           const SliverGridDelegateWithFixedCrossAxisCount(
  //                               crossAxisCount: 2,
  //                               childAspectRatio: (1 / .7)),
  //                           itemCount: getOptions(questionIndex).length,
  //                           physics: NeverScrollableScrollPhysics(),
  //                           shrinkWrap: true,
  //                           itemBuilder: (_, index) {
  //                             options = getOptions(questionIndex);
  //                             return Container(
  //                               child: Column(
  //                                 children: [
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       setState(() {
  //                                         selectedAnswer = index;
  //                                         isAnswerSelected = true;
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       width: 130,
  //                                       height: 90,
  //                                       decoration: BoxDecoration(
  //                                           borderRadius:
  //                                           BorderRadius.circular(10),
  //                                           color: selectedAnswer == index
  //                                               ? Colors.blue
  //                                               .withOpacity(0.1)
  //                                               : Colors.white,
  //                                           border: Border.all(
  //                                             color:
  //                                             selectedAnswer == index
  //                                                 ? Colors.blue
  //                                                 : Colors.grey,
  //                                             width: 1,
  //                                           ),
  //                                           image: DecorationImage(
  //                                             fit: BoxFit.cover,
  //                                             image: Image.network(
  //                                                 '$imageBaseUrl${options![index].fileName}')
  //                                                 .image,
  //                                           )
  //                                         // image: DecorationImage(
  //                                         //   fit: BoxFit.cover,
  //                                         //   image: Image.network('$imageBaseUrl${options[index].fileName}').image,
  //                                         // )
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 10,
  //                                   ),
  //                                   Text(
  //                                     '${options![index].title}',
  //                                     style: const TextStyle(
  //                                       fontFamily: 'Open Sans',
  //                                       fontSize: 15,
  //                                       color: Colors.black,
  //                                       fontWeight: FontWeight.normal,
  //                                     ),
  //                                     softWrap: false,
  //                                   ),
  //                                 ],
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                         // ListView.builder(
  //                         //   itemCount: getOptions(questionIndex).length,
  //                         //   physics: NeverScrollableScrollPhysics(),
  //                         //   shrinkWrap: true,
  //                         //   itemBuilder: (_, index) {
  //                         //     var options = getOptions(questionIndex);
  //                         //     return InkWell(
  //                         //       onTap: () {
  //                         //         setState(() {
  //                         //           selectedAnswer = index;
  //                         //           isAnswerSelected = true;
  //                         //         });
  //                         //       },
  //                         //       child: Container(
  //                         //         margin: const EdgeInsets.symmetric(
  //                         //             horizontal: 35, vertical: 5),
  //                         //         padding: const EdgeInsets.symmetric(
  //                         //             horizontal: 20, vertical: 25),
  //                         //         decoration: BoxDecoration(
  //                         //             color: selectedAnswer == index
  //                         //                 ? Colors.blue.withOpacity(0.1)
  //                         //                 : Colors.white,
  //                         //             borderRadius:
  //                         //                 BorderRadius.circular(8),
  //                         //             border: Border.all(
  //                         //               color: selectedAnswer == index
  //                         //                   ? Colors.blue
  //                         //                   : Colors.grey,
  //                         //               width: 1,
  //                         //             )
  //                         //         ),
  //                         //         child: Text(
  //                         //           options[index],
  //                         //           style: TextStyle(fontSize: 14),
  //                         //         ),
  //                         //       ),
  //                         //     );
  //                         //   },
  //                         // ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         Divider(
  //                           thickness: 3,
  //                           indent: 30,
  //                           endIndent: 30,
  //                           color: selectedAnswer == CorrectAnswer
  //                               ? Colors.green
  //                               : selectedAnswer == -1
  //                               ? Colors.grey.shade300
  //                               : Colors.red,
  //                         ),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                         // reasoning ? Text(
  //                         //   'Why?',
  //                         //   style: const TextStyle(
  //                         //     fontFamily: 'Open Sans',
  //                         //     fontSize: 15,
  //                         //     color: Colors.black,
  //                         //     fontWeight: FontWeight.normal,
  //                         //   ),
  //                         //   softWrap: false,
  //                         // ) : Container(),
  //                         // reasoning ? Padding(
  //                         //   padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
  //                         //   child: TextFormField(
  //                         //     minLines: 3,
  //                         //     maxLines: 3,
  //                         //     cursorColor: Colors.grey,
  //                         //     decoration: InputDecoration(
  //                         //       hintText: 'Enter Something',
  //                         //       hintStyle: TextStyle(
  //                         //           color: Colors.grey,
  //                         //           fontSize: 11,
  //                         //           fontWeight: FontWeight.w500
  //                         //       ),
  //                         //       enabledBorder: OutlineInputBorder(
  //                         //         borderSide: BorderSide(
  //                         //             color: Colors.grey,
  //                         //             width: .3
  //                         //         ),
  //                         //         borderRadius: BorderRadius.circular(10.0),
  //                         //       ),
  //                         //       focusedBorder: OutlineInputBorder(
  //                         //         borderSide: BorderSide(
  //                         //             color: Colors.grey,
  //                         //             width: .3
  //                         //         ),
  //                         //         borderRadius: BorderRadius.circular(10.0),
  //                         //       ),
  //                         //     ),
  //                         //   ),
  //                         // ) : Container(),
  //                         // reasoning ? Text(
  //                         //   '9/10',
  //                         //   style: TextStyle(
  //                         //     fontFamily: 'Open Sans',
  //                         //     fontSize: 15,
  //                         //     color: Color(0xff005690),
  //                         //     fontWeight: FontWeight.normal,
  //                         //   ),
  //                         //   softWrap: false,
  //                         // ) :
  //                         Card(
  //                           shape: RoundedRectangleBorder(
  //                             side: BorderSide(
  //                               color: Colors.grey.shade300,
  //                             ),
  //                             borderRadius: BorderRadius.circular(100),
  //                           ),
  //                           child: Container(
  //                             width: 90,
  //                             height: 80,
  //                             child: Center(
  //                               child: Text(
  //                                 '1/${_Questions!.audioes!.length}',
  //                                 style: TextStyle(
  //                                   fontFamily: 'Open Sans',
  //                                   fontSize: 15,
  //                                   color: Color(0xff005690),
  //                                   fontWeight: FontWeight.normal,
  //                                 ),
  //                                 softWrap: false,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                       ],
  //                     ),
  //
  //                     // Container(
  //                     //   decoration: BoxDecoration(
  //                     //     color: Colors.red
  //                     //     // image: DecorationImage(
  //                     //     //   image: AssetImage('assets/images/notepad.png'),
  //                     //     //   fit: BoxFit.contain,
  //                     //     // ),
  //                     //   ),
  //                     //   child: Column(
  //                     //     children: [
  //                     //       Container(
  //                     //         width: double.infinity,
  //                     //         padding: const EdgeInsets.symmetric(
  //                     //             horizontal: 40, vertical: 10),
  //                     //         child: Text(
  //                     //           '${_Questions!.audioes![questionIndex].question!}',
  //                     //           style: TextStyle(fontSize: 16),
  //                     //         ),
  //                     //       ),
  //                     //       SizedBox(height: 25),
  //                     //       Expanded(
  //                     //         child: ListView.builder(
  //                     //             itemBuilder: (context, index) {
  //                     //               var options = getOptions(questionIndex);
  //                     //               print('options here');
  //                     //               print(options);
  //                     //               return InkWell(
  //                     //                 onTap: () {
  //                     //                   setState(() {
  //                     //                     selectedAnswer = index;
  //                     //                     isAnswerSelected = true;
  //                     //                   });
  //                     //                 },
  //                     //                 child: Container(
  //                     //                   margin: const EdgeInsets.symmetric(
  //                     //                       horizontal: 35, vertical: 5),
  //                     //                   padding: const EdgeInsets.symmetric(
  //                     //                       horizontal: 20, vertical: 25),
  //                     //                   decoration: BoxDecoration(
  //                     //                       color: selectedAnswer == index
  //                     //                           ? Colors.blue.withOpacity(0.1)
  //                     //                           : Colors.white,
  //                     //                       borderRadius:
  //                     //                       BorderRadius.circular(8),
  //                     //                       border: Border.all(
  //                     //                         color: selectedAnswer == index
  //                     //                             ? Colors.blue
  //                     //                             : Colors.grey,
  //                     //                         width: 1,
  //                     //                       )),
  //                     //                   child: Text(
  //                     //                     options[index],
  //                     //                     style: TextStyle(fontSize: 14),
  //                     //                   ),
  //                     //                 ),
  //                     //               );
  //                     //             },
  //                     //             itemCount: getOptions(questionIndex).length
  //                     //         ),
  //                     //       )
  //                     //     ],
  //                     //   ),
  //                     // ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Visibility(
  //           visible: pageIndex == 2 ? true : false,
  //           child: Container(
  //             width: size.width,
  //             height: size.height,
  //             child: GestureDetector(
  //               onHorizontalDragStart: (details) {
  //                 _oldPosition = details.globalPosition;
  //                 _flipKey.currentState?.startFlip();
  //               },
  //               onHorizontalDragUpdate: (details) {
  //                 Offset off = details.globalPosition - _oldPosition;
  //                 double tilt = 1 / _clampMin((-off.dy + 20) / 100);
  //                 double percent =
  //                 math.max(0, -off.dx / size.width * 1.4);
  //                 percent = percent - percent / 2 * (1 - 1 / tilt);
  //                 _flipKey.currentState?.flip(percent, tilt);
  //               },
  //               onHorizontalDragEnd: (details) {
  //                 _flipKey.currentState?.stopFlip();
  //                 setState(() {
  //                   pageIndex += 1;
  //                 });
  //               },
  //               onHorizontalDragCancel: () {
  //                 _flipKey.currentState?.stopFlip();
  //               },
  //               child: FlipWidget(
  //                 key: _flipKey,
  //                 textureSize: size * 2,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     image: DecorationImage(
  //                       image: AssetImage('assets/images/notepad.png'),
  //                       fit: BoxFit.contain,
  //                     ),
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         width: double.infinity,
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 40, vertical: 12),
  //                         child: Text(
  //                           _Questions!.audioes![questionIndex].question!,
  //                           style: TextStyle(fontSize: 14),
  //                         ),
  //                       ),
  //                       SizedBox(height: 100),
  //                       Container(
  //                         margin: const EdgeInsets.symmetric(
  //                             horizontal: 30, vertical: 5),
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: TextField(
  //                           controller: _answerTextField,
  //                           decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             labelText: 'Your answer',
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             ElevatedButton(
  //               onPressed: () async {
  //                 setState(() {
  //                   questionIndex += 1;
  //                   // pageIndex = 0;
  //                 });
  //                 if (questionIndex >= _Questions!.audioes!.length) {
  //                   bool value = await submitCbtAnswer(
  //                       options![0].questionId!, 'null', 'null');
  //                   print(value);
  //                 }
  //               },
  //               child: Text('Skip'),
  //               style: ElevatedButton.styleFrom(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(25),
  //                   ),
  //                   primary: new Color(0xff4885ED),
  //                   fixedSize: Size(150, 50)),
  //             ),
  //             ElevatedButton(
  //               onPressed: () async {
  //                 if (pageIndex == 1) {
  //                   if (!isAnswerSelected) {
  //                     showDialog(
  //                       context: context,
  //                       builder: (context) => AlertDialog(
  //                         title: Text('Answer is mandatory'),
  //                         actions: [
  //                           TextButton(
  //                             child: Text('OK'),
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                           )
  //                         ],
  //                       ),
  //                     );
  //                   } else {
  //                     setState(() {
  //                       questionIndex++;
  //                     });
  //                     if (questionIndex >= _Questions!.audioes!.length) {
  //                       bool value = await submitCbtAnswer(
  //                           options![selectedAnswer].questionId!,
  //                           options![selectedAnswer].title!,
  //                           'null');
  //                       print(value);
  //                     }
  //                   }
  //                 }
  //                 // setState(() {
  //                 //   pageIndex += 1;
  //                 // });
  //                 if (pageIndex == 2 && !isAnswerSelected) {
  //                   setState(() {
  //                     pageIndex -= 1;
  //                   });
  //                   // show alert
  //                   showDialog(
  //                     context: context,
  //                     builder: (context) => AlertDialog(
  //                       title: Text('Answer is mandatory'),
  //                       actions: [
  //                         TextButton(
  //                           child: Text('OK'),
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                         )
  //                       ],
  //                     ),
  //                   );
  //                 }
  //                 if (pageIndex == 3) {
  //                   UIBlock.block(context);
  //                   await submitCbtAnswer(
  //                       _Questions!.audioes![questionIndex].id!,
  //                       getOptions(questionIndex)[selectedAnswer]
  //                           .toString(),
  //                       _answerTextField.text.trim().toString())
  //                       .then((value) {
  //                     if (value) {
  //                       UIBlock.unblock(context);
  //                       setState(() {
  //                         questionIndex += 1;
  //                         selectedAnswer = -1;
  //                         isAnswerSelected = false;
  //                         _answerTextField.text = '';
  //                         pageIndex = 0;
  //                       });
  //                     } else {
  //                       UIBlock.unblock(context);
  //                       Scaffold.of(context).showSnackBar(SnackBar(
  //                           content: Text(
  //                             "Could not submit the answer",
  //                             style: TextStyle(color: Colors.red),
  //                           )));
  //                     }
  //                   });
  //                 }
  //               },
  //               child: pageIndex == 2 ? Text('Submit') : Text('Next'),
  //               style: ElevatedButton.styleFrom(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(25),
  //                   ),
  //                   primary: new Color(0xff4885ED),
  //                   fixedSize: Size(150, 50)),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
