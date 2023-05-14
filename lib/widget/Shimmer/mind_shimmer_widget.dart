import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';

class MindShimmerWidget extends StatelessWidget{
  const MindShimmerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                        Colors.black.withOpacity(0.2), BlendMode.darken),
                    child: Image.network(
                      "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      //'${snapshot.data.videoPath}${snapshot.data.videosData[0].videoFile}',
                      fit: BoxFit.cover,
                      height: height * 0.3,
                      width: MediaQuery.of(context).size.width,
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
                        primary: Color(0xff4885ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    icon: Icon(
                      FontAwesomeIcons.play,
                      size: MySize.size14,
                    ),
                    label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: DDText(
                          title: "Play",
                          size: MySize.size15,
                          color: Colors.white,
                          weight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MySize.size2, left: MySize.size8),
                child:
                DDText(title: 'Lesson', size: MySize.size15),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: MySize.size2, right: MySize.size8),
                child: Row(
                  children: [
                    DDText(
                      title: "10 min",
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
            padding: EdgeInsets.only(left: MySize.size8, right: MySize.size8),
            child: Divider(),
          ),
          SizedBox(
            height: MySize.size10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.only(left: MySize.size14),
              child: DDText(
                title: "Featured CBT",
                size: MySize.size11,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: MySize.size14),
              child: DDText(
                  title: "Browse",
                  size: MySize.size11,
                  weight: FontWeight.w300,
                  color: Color(0xff4885ED)),
            ),
          ]),
          Container(
            height: 180,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height:100,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5)
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                    // "${snapshot.data.videoPath}${snapshot.data.videosData[index].videoFile}",
                                  ),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                          Container(
                            width: 120,
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Lesson',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "10 min",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.blue,
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
                  );
                }),
          ),

          SizedBox(
            height: MySize.size20,
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
                      'assets/images/susan_4.png',
                      fit: BoxFit.fill,
                      // height: height * 0.3,
                      // width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
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
                              color: Colors.white,
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
                                color: Colors.white,
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
                                color: Colors.white,
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
                                  primary: Color(0xff4885ED),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onPressed: () {

                                },
                                child: Text("Discover More"),
                              ),
                            ]),
                      ),
                    ],
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

              blogSection(),
            ],
          )
        ],
      ),
    );
  }

  Widget blogSection() {
    return Padding(
      padding: EdgeInsets.only(
          left: MySize.size6, bottom: MySize.size30, right: MySize.size14),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, i) {
              return Card(
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
                          color: Colors.white,
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
                                          title: 'How to cook brown rice',
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}