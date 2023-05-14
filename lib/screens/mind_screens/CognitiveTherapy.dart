import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Controller/video.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/MindPlanDashboardModel.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/custom_bottombar.dart';

class CognitiveTherapy extends StatefulWidget {
  List<VideosData> videos;
  String path;

  CognitiveTherapy(this.videos, this.path);

  @override
  _CognitiveTherapyState createState() => _CognitiveTherapyState();
}

class _CognitiveTherapyState extends State<CognitiveTherapy>
    with TickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Today',
    ),
    const Tab(text: 'Diet'),
    const Tab(text: 'Exercise'),
    const Tab(text: 'Mind'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(3);
  }

  int _index;

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // bottomNavigationBar: CustomBottomBar(_index),
        //bottomNavigationBar: CustomStaticBottomNavigationBar(),
        appBar: titleAppBar(title: "Therapy", context: context),
        body: Container(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: const AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.25,
                  child: Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken),
                        child: Image.asset(
                          'assets/images/plans_banner.png',
                          fit: BoxFit.cover,
                          height: height * 0.3,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Cognitive Behavior Therapy",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ),
                      )
                    ],
                  )),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 280 / 350,
                      // childAspectRatio: (itemWidth / itemHeight),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: widget.videos.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Responsive1.isMobile(context)
                              ? Get.to(() => VideoWidget(
                                  url:
                                      '$videosBaseUrl${widget.videos[index].videoFile}',
                                  play: true,
                                  videoId: widget.videos[index].id))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 300,
                                          right: 300,
                                          bottom: 100,
                                          top: 100),
                                      child: VideoWidget(
                                          url:
                                              '$videosBaseUrl${widget.videos[index].videoFile}',
                                          play: true,
                                          videoId: widget.videos[index].id)));
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //       return VideoWidget(
                          //           url: '${widget.videos[index].videoFile}',
                          //           play: true);
                          //     }));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 140,
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.only(
                                    //     topLeft: Radius.circular(5),
                                    //     topRight: Radius.circular(5)),
                                    // child: Image.network(
                                    //   "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                    //   height: 140,
                                    //   fit: BoxFit.cover,
                                    // ),

                                    child: Image.network(
                                      '$imageBaseUrl${widget.videos[index].imageFile}',
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.videos[index].title ?? "",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: black)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            "${widget.videos[index].duration} sec",
                                            style: const TextStyle(
                                                color: lightGrey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: primaryColor,
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
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget homePage() {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: height * 0.25,
              child: Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken),
                    child: Image.asset(
                      'assets/images/cognitive_therapy_banner.png',
                      fit: BoxFit.cover,
                      height: height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Cognitive Behavior Therapy",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: white),
                      ),
                    ),
                  )
                ],
              )),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 280 / 350,
                  // childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: widget.videos.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => VideoWidget(
                          url:
                              '$videosBaseUrl${widget.videos[index].videoFile}',
                          play: true,
                          videoId: widget.videos[index].id));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 140,
                            child: FutureBuilder<File>(
                              future:
                                  getVideoThumb(widget.videos[index].videoFile),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: const Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      child: Image.network(
                                        "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),

                                      // child: Image.file(
                                      //   snapshot.data,
                                      //   height: 140,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    );
                                  } else {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: const Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      child: Image.network(
                                        "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                } else {
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    child: Image.network(
                                      'https://via.placeholder.com/150',
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.videos[index].title,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: black)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "${widget.videos[index].duration} sec",
                                        style: const TextStyle(
                                            color: lightGrey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: primaryColor,
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
              })
        ],
      ),
    );
  }
}
