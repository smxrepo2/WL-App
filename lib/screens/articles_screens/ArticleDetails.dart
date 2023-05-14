import 'package:flutter/material.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';

import 'package:weight_loser/models/MindPlanDashboardModel.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/SizeConfig.dart';

class ArticleDetails extends StatefulWidget {
  final id;
  final heading;
  final details;
  final imageUrl;
  final publishDate;
  List<Blogs> blogs;

  ArticleDetails(this.id, this.heading, this.details, this.imageUrl,
      this.publishDate, this.blogs);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails>
    with TickerProviderStateMixin {
  TabController _tabController;
  int contentMaxLines = 4;
  String readText = "Read More";
  bool isFavourite = false;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];

  @override
  void initState() {
    super.initState();
    print('publishded date : ${widget.publishDate}');
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(3);
    print("id ${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(context: context, title: "Blogs Detail"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            padding: EdgeInsets.only(
              top: MySize.size14,
              left: MySize.size14,
              right: MySize.size14,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MySize.size8,
                        right: MySize.size8,
                      ),
                      child: DDText(
                        title: widget.heading,
                        color: Color(0xff23233C),
                        weight: FontWeight.bold,
                        size: 20,
                        line: 3,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MySize.size8),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MySize.size10,
                        ),
                        child: DDText(
                          title: "Published On",
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: MySize.size8),
                      child: Row(
                        children: [
                          DDText(
                            title: widget.publishDate ?? '',
                            color: Colors.grey[400],
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       isFavourite = !isFavourite;
                          //     });
                          //   },
                          //   child: Icon(
                          //     Icons.favorite,
                          //     color: isFavourite == true
                          //         ? Colors.red
                          //         : Colors.grey,
                          //     size: 16,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MySize.size8, bottom: MySize.size8),
                      child: Image.network(
                        widget.imageUrl,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MySize.size26,
                          right: MySize.size10,
                          left: MySize.size12),
                      child: DDText(
                        title: widget.details,
                        color: greyColor,
                        line: contentMaxLines,
                      ),
                    ),
                    // Spacer(),
                    Container(
                      margin: EdgeInsets.only(
                        top: MySize.size26,
                        bottom: MySize.size4,
                        left: MySize.size16,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (contentMaxLines == 4) {
                                setState(() {
                                  contentMaxLines = 50000;
                                  readText = "Read Less";
                                });
                              } else {
                                setState(() {
                                  contentMaxLines = 4;
                                  readText = "Read More";
                                });
                              }
                            },
                            child: DDText(
                                title: readText,
                                size: MySize.size16,
                                weight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MySize.size20,
                ),
                ListView.builder(
                  itemCount: widget.blogs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return widget.blogs[index].id == widget.id
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              Responsive1.isMobile(context)?
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ArticleDetails(
                                          widget.blogs[index].id,
                                          widget.blogs[index].title,
                                          widget.blogs[index].description,
                                          '$imageBaseUrl${widget.blogs[index].fileName}',
                                          widget.blogs[index].createdAt,
                                          widget.blogs))):showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Padding(
                                  padding: const EdgeInsets.only(left: 250,right: 250,bottom: 100,top: 100),
                                  child:ArticleDetails(
                                      widget.blogs[index].id,
                                      widget.blogs[index].title,
                                      widget.blogs[index].description,
                                      '$imageBaseUrl${widget.blogs[index].fileName}',
                                      widget.blogs[index].createdAt,
                                      widget.blogs)));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: MySize.size10,
                                bottom: MySize.size10,
                                left: MySize.size10,
                              ),
                              decoration: BoxDecoration(
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffEFEFEF),
                                      spreadRadius: 1,
                                      blurRadius: 0.2)
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MySize.size8),
                                          child: DDText(
                                            line: 3,
                                            title: widget.blogs[index].title,
                                            weight: FontWeight.w500,
                                            center: null,
                                            size: 15,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: MySize.size10,
                                              top: MySize.size10,
                                              bottom: MySize.size10,
                                              right: MySize.size10),
                                          child: DDText(
                                            size: 10,
                                            title: widget.blogs[index]
                                                .description, // textAlign: TextAlign.left,
                                            toverflow: TextOverflow.ellipsis,
                                            center: null,
                                            color: greyColor,
                                            line: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: SizeConfig.safeBlockHorizontal * 30,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '$imageBaseUrl${widget.blogs[index].fileName}'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
