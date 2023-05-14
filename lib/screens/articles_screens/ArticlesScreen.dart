import 'package:flutter/material.dart';

import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/screens/articles_screens/ArticleDetails.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key key}) : super(key: key);

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with TickerProviderStateMixin {
  List articlesData = [
    {
      "heading": "17 Reasons Healthy Food is Sweeter than Christmas Morning",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/apple.jpg"
    },
    {
      "heading": "12 Exercices you can do at home in the Morning Routine",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/exercise.jpg"
    },
    {
      "heading": "14 Reasons Healthy Food is Sweeter than Christmas Morning",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/fruits5.jpg"
    },
    {
      "heading": "15 Reasons Healthy Food is Sweeter than Christmas Morning",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/fruits4.jpg"
    },
    {
      "heading": "16 Reasons Healthy Food is Sweeter than Christmas Morning",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/fruits5.jpg"
    },
    {
      "heading": "16 Reasons Healthy Food is Sweeter than Christmas Morning",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/fruits3.jpg"
    },
    {
      "heading": "16 Reasons Healthy Food is Sweeter than Christmas Morning",
      "details":
          "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
      "imageUrl": "assets/images/fruits4.jpg"
    },
  ];

  TabController _tabController;

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
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(3);
  }

  @override
  Widget build(BuildContext context) {
    // Responsive responsive = new Responsive();
    MySize().init(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: CustomStaticBottomNavigationBar(),
        drawer: CustomDrawer(),
        appBar: customAppBar(
          context,
          /*tabBar: TabBar(
            onTap: (index) {
              setState(() {
                _tabController.index = 3;
              });
            },
            controller: _tabController,
            labelPadding: EdgeInsets.only(left: MySize.size4),
            indicatorColor: Color(0xff4885ED),
            labelColor: Color(0xff4885ED),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black87,
            tabs: myTabs,
          ),*/
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: articlesData.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        /* Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ArticleDetails(
                              blogs[i].title,
                              blogs[i].description,
                              '$imageBaseUrl${blogs[i].fileName}',
                              blogs[i].createdAt,
                              blogs
                          );
                        }));*/
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                            left: MySize.size10,
                            top: MySize.size5,
                            bottom: MySize.size5),
                        elevation: 1,
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
                                          bottom: MySize.size8,
                                          left: MySize.size8,
                                          right: MySize.size28),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: MySize.size8,
                                              top: MySize.size8,
                                            ),
                                            child: DDText(
                                              line: 3,
                                              title: articlesData[i]["heading"],
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
                                              title:
                                                  "In at laculis lorem. Parsent tempor dictum tellus ut mlestile. Sed Sed ullamcorper lorem, id faucibus odiio. Duis eu nisi ut ligula cursus molestile at at dolor. Nulla est justo",
                                              // textAlign: TextAlign.left,
                                              toverflow: TextOverflow.ellipsis,
                                              center: null,
                                              color: Color(0xff797A7A),
                                              line: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    Container(
                                      height: 100,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                articlesData[i]["imageUrl"],
                                              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
