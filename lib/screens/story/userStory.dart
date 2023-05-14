// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
// import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:weight_loser/screens/story/methods.dart';
import 'package:weight_loser/screens/story/story_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';

class MyStory extends StatefulWidget {
  const MyStory({Key key, @required this.profileImage, @required this.username})
      : super(key: key);
  final profileImage;
  final username;

  @override
  State<MyStory> createState() => _MyStoryState();
}

class _MyStoryState extends State<MyStory> {
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  Image _image;
  Future<StoryModel> _future;
  StoryModel _story;
  String selfieImagePath = "https://weightchoper.somee.com/staticfiles/selfie/";
  @override
  void initState() {
    super.initState();
    _future = fetchStoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<StoryModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _story = snapshot.data;
              double diet = double.parse(_story.userDietAvgScore.toString());
              double exe =
                  double.parse(_story.avgExerciseVideoCount.toString());
              double mind = double.parse(_story.mindAvgVideoCount.toString());
              double totalavg = (diet + exe + mind) / 3;
              int weightStatus;
              if (_story.weightHistoryVM.goals.length > 0) {
                weightStatus = _story.weightHistoryVM.goals.last.currentWeight -
                    _story.weightHistoryVM.goals.first.currentWeight;
              }

              return SingleChildScrollView(
                child: RepaintBoundary(
                  key: previewContainer,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '$imageBaseUrl${widget.profileImage}'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff707070)),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${widget.username}',
                          style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 13,
                            color: Color(0xff080808),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        ),
                        const Divider(
                          height: 30,
                          color: Colors.black,
                          indent: 110,
                          endIndent: 110,
                          thickness: 1.25,
                        ),
                        const Text(
                          'My Story',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            color: Color(0xff080808),
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: false,
                        ),
                        const SizedBox(height: 20),
                        IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Compliance',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 13,
                                        color: Color(0xff080808),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      softWrap: false,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${totalavg.toInt()}%',
                                      style: const TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 13,
                                        color: Color(0xff080808),
                                      ),
                                      softWrap: false,
                                    ),
                                  ],
                                ),
                                Transform.translate(
                                  offset: const Offset(-7.5, 0),
                                  child: const VerticalDivider(
                                    width: 0,
                                    thickness: 1,
                                    indent: 15,
                                    endIndent: 5,
                                    color: Colors.black,
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-12.5, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Weight Loss',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        softWrap: false,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${weightStatus}kg',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                        ),
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-15, 0),
                                  child: const VerticalDivider(
                                    width: 0,
                                    thickness: 1,
                                    indent: 15,
                                    endIndent: 5,
                                    color: Colors.black,
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-12.5, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Days',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        softWrap: false,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${_story.activePlanDays}',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                        ),
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 1.0, color: const Color(0x5c5b9ff0)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${widget.username} lost ${weightStatus}kg weight in his first week of \nusing weight loser here the story of ${widget.username} \nhe is on the way to achieve her dream.\nweight through a weight loser ',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: Color(0xff080808),
                                ),
                                softWrap: false,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${_story.totalDays}D Summary ',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: Color(0xff080808),
                                  fontWeight: FontWeight.w700,
                                ),
                                softWrap: false,
                              ),
                              const Divider(
                                height: 20,
                                color: Colors.black,
                                indent: 100,
                                endIndent: 100,
                                thickness: 1.25,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Compliance',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        softWrap: false,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${totalavg.toInt()}%',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                        ),
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Weight Loss',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        softWrap: false,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${weightStatus}kg',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                        ),
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Cheat Days',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        softWrap: false,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${_story.cheatDays}',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                          color: Color(0xff080808),
                                        ),
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 17.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.username}\'s selfies',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 13,
                                        color: Color(0xff080808),
                                      ),
                                      softWrap: false,
                                    ),
                                    const SizedBox(height: 10),
                                    _story.selfieVM.length > 0
                                        ? Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${selfieImagePath}${_story.selfieVM.first.imageName}'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: const Color(
                                                              0xff707070)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  const Text(
                                                    'Before',
                                                    style: TextStyle(
                                                      fontFamily: 'Segoe UI',
                                                      fontSize: 13,
                                                      color: Color(0xff080808),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    softWrap: false,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 25),
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${selfieImagePath}${_story.selfieVM.last.imageName}'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: const Color(
                                                              0xff707070)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  const Text(
                                                    'After',
                                                    style: TextStyle(
                                                      fontFamily: 'Segoe UI',
                                                      fontSize: 13,
                                                      color: Color(0xff080808),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    softWrap: false,
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        : Center(child: Text("No Selfies"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /*
                    ShareFilesAndScreenshotWidgets()
                        .takeScreenshot(previewContainer, originalSize)
                        .then((Image value) {
                      setState(() {
                        _image = value;
                      });
                    });
                    */
                            // ShareFilesAndScreenshotWidgets().shareScreenshot(
                            //     previewContainer,
                            //     originalSize,
                            //     "Weekly Story",
                            //     "Name.png",
                            //     "image/png",
                            //     text:
                            //         "Hey Check Out my Story from weight loser application");
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.share,
                                size: 40,
                              ),
                              Text(
                                'Share',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: Color(0xff231f1f),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
