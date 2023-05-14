// ignore: file_names
import 'dart:convert';
// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/video.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Mind%20_service.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/MindPlanDashboardModel.dart';
import 'package:weight_loser/models/mind_plan_model.dart';
import 'package:weight_loser/screens/articles_screens/ArticleDetails.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/floating_action_button_widget.dart';
import 'package:weight_loser/widget/Shimmer/mind_shimmer_widget.dart';
import 'package:weight_loser/widget/no_internet_dialog.dart';

import '../../Provider/UserDataProvider.dart';
import 'CognitiveTherapy.dart';
import 'PlansScreen.dart';

class MindTabView extends StatefulWidget {
  const MindTabView({Key key}) : super(key: key);

  @override
  _MindTabViewState createState() => _MindTabViewState();
}

class _MindTabViewState extends State<MindTabView>
    with AutomaticKeepAliveClientMixin<MindTabView> {
  @override
  bool get wantKeepAlive => true;
  List<VideosData> sets = [];
  UserDataProvider _userDataProvider;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: true);
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            !_userDataProvider.networkConnection
                ? NoInternetDialogue()
                : FutureBuilder<MindPlanDashboardModel>(
                    future: fetchMindPlan(),
                    builder: (context, snapshot) {
                      print("mind data:" + sets.toString());
                      if (snapshot.hasData) {
                        sets = snapshot.data.videosData;
                        if (sets.isEmpty) {
                          return const Center(
                            child: Text('No any mind data'),
                          );
                        } else {
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: height * 0.26,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken),
                                        child: Image.network(
                                          //"https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                          '$imageBaseUrl${sets[0].imageFile}',
                                          //'${snapshot.data.videoPath}${snapshot.data.videosData[0].videoFile}',
                                          fit: BoxFit.cover,
                                          height: height * 0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              vertical: MySize.size14,
                                              horizontal: MySize.size20,
                                            ),
                                            primary: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )),
                                        onPressed: () {
                                          Responsive1.isMobile(context)
                                              ? Get.to(() => VideoWidget(
                                                    url:
                                                        '$videosBaseUrl${sets[0].videoFile}',
                                                    play: true,
                                                    videoId: sets[0].id,
                                                  ))
                                              : showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 300,
                                                                  right: 300,
                                                                  bottom: 100,
                                                                  top: 100),
                                                          child: VideoWidget(
                                                              url:
                                                                  '$videosBaseUrl${sets[0].videoFile}',
                                                              play: true,
                                                              videoId:
                                                                  sets[0].id)));
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          //   return  VideoWidget(url:'${snapshot.data.videosData[0].videoFile}', play: true);
                                          // }));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.play,
                                          size: MySize.size14,
                                        ),
                                        label: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: DDText(
                                              title: "Play",
                                              size: MySize.size15,
                                              color: white,
                                              weight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: MySize.size2, left: MySize.size8),
                                    child: DDText(
                                        title:
                                            snapshot.data.videosData[0].title,
                                        size: MySize.size15),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: MySize.size2, right: MySize.size8),
                                    child: Row(
                                      children: [
                                        /*Image.asset(
                                  "assets/icons/youtube_icon.png",
                                  fit: BoxFit.cover,
                                ),*/
                                        /*Padding(
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: DDText(
                                      title: "Expert Guidance  ",
                                      size: MySize.size11,
                                      weight: FontWeight.w300),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: DDText(
                                      title: "•",
                                      weight: FontWeight.bold,
                                      size: MySize.size11),
                                ),*/
                                        DDText(
                                          title: "${sets[0].duration} min",
                                          size: MySize.size11,
                                          weight: FontWeight.w300,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MySize.size10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MySize.size8, right: MySize.size8),
                                child: const Divider(),
                              ),
                              SizedBox(
                                height: MySize.size10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: MySize.size14),
                                      child: DDText(
                                        title: "Featured CBT",
                                        size: MySize.size11,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Responsive1.isMobile(context)
                                            ? Get.to(() => CognitiveTherapy(
                                                sets, videosBaseUrl))
                                            : showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 150,
                                                                right: 150,
                                                                bottom: 50,
                                                                top: 50),
                                                        child: CognitiveTherapy(
                                                            sets,
                                                            videosBaseUrl)));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: MySize.size14),
                                        child: DDText(
                                            title: "Browse",
                                            size: MySize.size11,
                                            weight: FontWeight.w300,
                                            color: primaryColor),
                                      ),
                                    ),
                                  ]),
                              Container(
                                height: 180,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sets.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: () {
                                            Responsive1.isMobile(context)
                                                ? Get.to(() => VideoWidget(
                                                    url:
                                                        '$videosBaseUrl${sets[index].videoFile}',
                                                    play: true,
                                                    videoId: sets[index].id))
                                                : showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 300,
                                                                    right: 300,
                                                                    bottom: 100,
                                                                    top: 100),
                                                            child: VideoWidget(
                                                                url:
                                                                    '$videosBaseUrl${sets[index].videoFile}',
                                                                play: true)));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: 100,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              topLeft: Radius
                                                                  .circular(5)),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          '${imageBaseUrl}${sets[index].imageFile}',
                                                          //"${imageBaseUrl}"
                                                          //"https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                Container(
                                                  width: 120,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 0, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              snapshot
                                                                      .data
                                                                      .videosData[
                                                                          index]
                                                                      .title ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0),
                                                            child: Text(
                                                              "${snapshot.data.videosData[index].duration} min",
                                                              style: const TextStyle(
                                                                  color:
                                                                      lightGrey,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5),
                                                            child: const Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: MySize.size20,
                              ),
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('There was error loading data'),
                        );
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                      // return MindShimmerWidget();
                    },
                  ),
            Container(
              width: MediaQuery.of(context).size.width,
              // height: height * 0.26,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: MySize.size10, right: MySize.size10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        ImagePath.minTab,
                        fit: BoxFit.fill,
                        // height: height * 0.3,
                        // width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const PlansScreen());
                        // var route = MaterialPageRoute(
                        //     builder: (context) => PlansScreen());
                        // Navigator.push(context, route);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MySize.size14, left: MySize.size20),
                                child: DDText(
                                  title: "Your Meditation",
                                  color: white,
                                  weight: FontWeight.w500,
                                  size: MySize.size15,
                                ),
                              ),
                              SizedBox(height: MySize.size10),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: MySize.size20),
                                  child: DDText(
                                    title:
                                        "As they say it's all in the mind. the better",
                                    color: white,
                                    weight: FontWeight.w500,
                                    size: MySize.size11,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: MySize.size20),
                                  child: DDText(
                                    title:
                                        "the mind state more likely you succeed",
                                    color: white,
                                    weight: FontWeight.w500,
                                    size: MySize.size11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: MySize.size22, top: MySize.size20),
                            child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(
                                        MySize.size6,
                                      ),
                                      primary: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: const BorderSide(color: white),
                                      ),
                                    ),
                                    onPressed: () {
                                      Responsive1.isMobile(context)
                                          ? Get.to(() => const PlansScreen())
                                          : showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 150,
                                                          right: 150,
                                                          bottom: 50,
                                                          top: 50),
                                                      child:
                                                          const PlansScreen()));
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //       return PlansScreen();
                                      //     }));
                                    },
                                    child: const Text("Discover More"),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MySize.size30,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MySize.size14, bottom: MySize.size10),
                      child: DDText(
                        title: "For You",
                        size: MySize.size15,
                      ),
                    ),
                  ],
                ),
                FutureBuilder<MindPlanDashboardModel>(
                    future: fetchMindPlan(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.blogs.isEmpty) {
                          return const Center(
                            child: const Text('no any blog avaliable'),
                          );
                        } else {
                          return blogSection(snapshot.data.blogs);
                        }
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: const Text('There was error loading data'),
                        );
                      }
                      return const CircularProgressIndicator();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
  // ############################ BLOG SECTION #################################

  Widget blogSection(List<Blogs> blogs) {
    return Padding(
      padding: EdgeInsets.only(
          left: MySize.size6, bottom: MySize.size30, right: MySize.size14),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: blogs.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Responsive1.isMobile(context)
                      ? Get.to(() => ArticleDetails(
                          blogs[i].id,
                          blogs[i].title,
                          blogs[i].content,
                          '$imageBaseUrl${blogs[i].fileName}',
                          blogs[i].createdAt,
                          blogs))
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 200, right: 200, bottom: 50, top: 50),
                              child: ArticleDetails(
                                  blogs[i].id,
                                  blogs[i].title,
                                  blogs[i].content,
                                  '$imageBaseUrl${blogs[i].fileName}',
                                  blogs[i].createdAt,
                                  blogs)));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return ArticleDetails(
                  //       blogs[i].title,
                  //       blogs[i].content,
                  //       '$imageBaseUrl${blogs[i].fileName}',
                  //       blogs[i].createdAt,
                  //       blogs
                  //   );
                  // }));
                },
                child: Card(
                  margin: EdgeInsets.only(
                    left: MySize.size10,
                    top: MySize.size5,
                    bottom: MySize.size5,
                  ),
                  elevation: 0,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[100],
                                  spreadRadius: 1,
                                  blurRadius: 0.2)
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    top: MySize.size8,
                                    // bottom: MySize.size8,
                                    left: MySize.size8,
                                    right: MySize.size28),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: MySize.size8),
                                      child: DDText(
                                        line: 3,
                                        title: blogs[i].title,
                                        weight: FontWeight.w500,
                                        center: null,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              Container(
                                height: MySize.size100,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          '$imageBaseUrl${blogs[i].fileName}',
                                        ),
                                        scale: 4,
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
