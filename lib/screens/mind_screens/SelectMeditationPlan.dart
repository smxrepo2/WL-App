import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomMindPlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/custom_mind_provider_model.dart';
import 'package:weight_loser/models/mind_video_list_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/dialog_upload_video_widget.dart';

import 'CreateMeditationCustomPlan.dart';

class SelectMeditationPlan extends StatefulWidget {
  const SelectMeditationPlan({Key key}) : super(key: key);

  @override
  _SelectMeditationPlanState createState() => _SelectMeditationPlanState();
}

class _SelectMeditationPlanState extends State<SelectMeditationPlan>
    with TickerProviderStateMixin {
  List<Videos> videoList = [];
  TabController _tabController;
  int userid;
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
    return Scaffold(
      appBar: titleAppBar(context: context, title: "Select Plan"),
      body: Container(
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MySize.size26,
            ),
            Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                border: Border.all(
                  color: Colors.grey[100],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: MySize.size63,
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffdfdfdf),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.search,
                              color: Color(0xffafafaf),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(bottom: 4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Color(0xffdfdfdf),
                              )),
                          // filled: true,
                          hintStyle: GoogleFonts.openSans(
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                          hintText: "Search..",
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: storagePermission,
                      child: Icon(
                        Icons.ios_share,
                        color: primaryColor,
                        // size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MySize.size20,
            ),
            FutureBuilder<Widget>(
              future: fetchAllVideos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('No Internet Connectivity'),
                  );
                }
                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> fetchAllVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    videoList.clear();
    final response = await get(
      Uri.parse('$apiUrl/api/video/all/$userid'),
    );
    if (response.statusCode == 200) {
      videoList.addAll(
          MindVideoListModel.fromJson(jsonDecode(response.body)).videos);
      videoList.addAll(
          MindVideoListModel.fromJson(jsonDecode(response.body)).userVideos);
      print(jsonDecode(response.body));
      if (videoList.length > 0) {
        return showData();
      } else {
        return Center(child: Text('No Plans'));
      }
    } else {
      throw Exception('Failed to load videos');
    }
  }

  showData() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    var fileData;
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 280 / 350,
            // childAspectRatio: (itemWidth / itemHeight),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: videoList.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              _showFoodDialog(
                title: videoList[index].title,
                imageUrl: '$imageBaseUrl${videoList[index].imageFile}',
                videos: videoList[index],
              );
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
                      child: videoList[index].imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: Image.network(
                                '$imageBaseUrl${videoList[index].imageFile}',
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: Image.network(
                                '$imageBaseUrl${videoList[index].imageFile}',
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(videoList[index].title ?? "Not Available",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "${videoList[index].duration} sec",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  File videoFile = File("");
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile = File(pickedFile.path);
      showDialog(
        context: context,
        builder: (_) => DialogUploadVideoWidget(videoFile, () {
          fetchAllVideos();
        }),
      );
    }
  }

  storagePermission() async {
    PermissionStatus statuses = await Permission.storage.request();
    if (statuses.isGranted) {
      pickImage();
    } else {
      print('You need to allow permission in order to continue');
    }
  }

  Container trendingGrid(BuildContext context, {image1, image2}) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showFoodDialog(
                    title: "Lorem", imageUrl: 'assets/images/cognitive_1.png');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      image1,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Lorem",
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expanded(
          // Expanded(
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      image2,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lorem",
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showFoodDialog({title, imageUrl, Videos videos}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            var mobile = Responsive1.isMobile(context);
            var size = MediaQuery.of(context).size.width;
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.46,
                width: mobile ? MediaQuery.of(context).size.width : 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.38,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    height: MediaQuery.of(context).size.height *
                                        0.38,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://via.placeholder.com/150',
                                    height: MediaQuery.of(context).size.height *
                                        0.38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20.0, left: 20),
                              child: DDText(title: title),
                            ),
                            GestureDetector(
                              onTap: () {
                                final provider = Provider.of<UserDataProvider>(
                                    context,
                                    listen: false);
                                if (provider.customPlanStatusCode == 0) {
                                  print(
                                      "provider type Id ${provider.foodTypeId}");
                                  int id = provider.foodTypeId;
                                } else if (provider.customPlanStatusCode == 1) {
                                  final tempProvider =
                                      Provider.of<CustomMindPlanProvider>(
                                          context,
                                          listen: false);
                                  CustomMindProviderModel tempModel =
                                      tempProvider.customMindPlanModel;
                                  MindVideoModel videoModel =
                                      new MindVideoModel(
                                    videos.id.toString(),
                                    tempProvider.selectDay.toString(),
                                    videos.videoFile.toString(),
                                    videos.imageFile.toString(),
                                    videos.duration.toString(),
                                    videos.title.toString(),
                                  );

                                  print("my data: " +
                                      videos.id.toString() +
                                      " " +
                                      tempProvider.selectDay.toString() +
                                      " " +
                                      videos.videoFile.toString() +
                                      " " +
                                      videos.imageFile.toString() +
                                      " " +
                                      videos.duration.toString() +
                                      " " +
                                      videos.title.toString());

                                  if (tempModel.mindItem.length == 0)
                                    tempModel.mindItem = [];
                                  tempModel.mindItem.add(videoModel);
                                  tempProvider
                                      .setTempCustomDietPlanData(tempModel);
                                  Get.to(() => CreateMeditationCustomPlan(1));
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             CreateMeditationCustomPlan(1)));
                                }
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddExerciseCustomPlan()));*/
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0, right: 20),
                                child:
                                    DDText(title: "Add", color: primaryColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget leftRightheading(left, iconName, right, route) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DDText(
            title: left,
            size: MySize.size15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Row(
              children: [
                Icon(
                  iconName,
                  size: 18,
                  color: primaryColor,
                ),
                DDText(
                  title: right,
                  size: MySize.size15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headingView(title, bottomPadding) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size30, bottom: bottomPadding),
      child: Row(
        children: [
          DDText(
            title: title,
            size: MySize.size15,
          ),
        ],
      ),
    );
  }
}
