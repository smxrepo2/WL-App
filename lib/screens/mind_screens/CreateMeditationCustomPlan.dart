import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomMindPlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';

import 'package:weight_loser/models/custom_mind_provider_model.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/mind_screens/SelectMeditationPlan.dart';
import 'package:weight_loser/screens/mind_screens/methods/methods.dart';
import 'package:weight_loser/screens/mind_screens/models/added_mind_model.dart';
import 'package:weight_loser/screens/mind_screens/models/custom_mind_model.dart';
import 'package:weight_loser/screens/mind_screens/my_mind_plans.dart';
import 'package:weight_loser/screens/mind_screens/providers/add_mind_provider.dart';
import 'package:weight_loser/screens/mind_screens/providers/custommindProvider.dart';
import 'package:weight_loser/screens/mind_screens/search/search.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/dialog_with_input_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

int meditationSelected = 0;

class CreateMeditationCustomPlan extends StatefulWidget {
  int activeCode;

  CreateMeditationCustomPlan(this.activeCode);

  @override
  State<CreateMeditationCustomPlan> createState() =>
      _CreateMeditationCustomPlanState();
}

class _CreateMeditationCustomPlanState
    extends State<CreateMeditationCustomPlan> {
  int day = 1;
  int daysAdded = 1;
  List<bool> plandays = [];

  List<AddedMindPlanItem> _addedList = [];
  Future<CustomMindModel> _customMindFuture;
  var _custommindProvider = getit<custommindprovider>();
  var _mindProvider = getit<addedmindlistprovider>();
  List<VideosData> mindItems;
  GlobalKey<FormState> _mindCustomDays = GlobalKey<FormState>();
  GlobalKey<FormState> _mindCustomSelectedFood = GlobalKey<FormState>();
  GlobalKey<FormState> _mindCustomSearch = GlobalKey<FormState>();
  GlobalKey<FormState> _mindCustomCuisineList = GlobalKey<FormState>();
  //GlobalKey<FormState> _dietCustomAddFood = GlobalKey<FormState>();
  GlobalKey<FormState> _mindCustomSaveDiet = GlobalKey<FormState>();
  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("custommindshowcaseStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 100; i++) {
      plandays.add(false);
    }
    _customMindFuture = GetCustomMindData();
    _mindProvider.deleteAll();
    _mindProvider.deleteAllItemId();
    _custommindProvider.setPlanId(null);
    print("Plan Id:${_custommindProvider.getPlanId()}");

    _mindProvider.addListener(() {
      if (mounted) setState(() {});
    });
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _mindCustomDays,
            _mindCustomSelectedFood,
            _mindCustomSearch,
            //_mindCustomCuisineList,
            // _dietCustomAddFood,
            _mindCustomSaveDiet
          ]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
  }

  Future addMindToCustomPlan(int planId) {
    mindItems = _mindProvider.getMindList();

    mindItems.forEach((element) async {
      print("Mind id ${element.id}");

      var response = await http.post(
        Uri.parse('$apiUrl/api/plan/mindplan'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "VideoId": int.parse(element.id.toString()),
          "PlanId": planId,
          "Day": day.toString(),
          "Title": element.title ?? "No Title",
        }),
      );

      if (response.statusCode == 200) {
        print("exercise then ${response.statusCode}${response.body} ");
        //statusCodes.add(response.statusCode);
        _mindProvider.deleteAddedMind(int.parse(element.id.toString()));
        _mindProvider.deleteAddedMindId(int.parse(element.id.toString()));
        print("Remaining Items ${_mindProvider.getMindList().length}");
        if (_mindProvider.getMindList().length == 0) {
          setState(() {
            UIBlock.unblock(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  children: [
                    Icon(Icons.done_all_rounded),
                    SizedBox(width: 10),
                    Text("Custom Plan for Day $day is uploaded"),
                  ],
                )));

            if (day <= 100) {
              plandays.insert(day - 1, true);
              day += 1;
              daysAdded += 1;

              //print(plandays[day - 1]);
            }

            //foodItems.clear();
          });
        }
      } else
        print("Response:${response.statusCode}");
    });
  }

  Future<Response> AddPlan(username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');

    Dio dio = new Dio();
    FormData formdata = new FormData();
    //String fileName = imageFile.path.split('/').last;
    int max = 100;

    formdata = FormData.fromMap({
      "PlanTypeId": 4,
      "Title": "${Random().nextInt(max)}",
      "Description": "",
      "Details": "",
      "duration": 7,
      "Calories": 105,
      "UserId": userid,
      //"FileName" : fileName,
      //"ImageFile": await MultipartFile.fromFile(
      //imageFile.path,
      //filename: fileName,
      //contentType: new MediaType("image", "jpeg"),
      //  ),
      "Cuisine": "",
    });
    return dio.post('$apiUrl/api/plan/addplan',
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<CustomMindModel>(
        future: _customMindFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

              break;
            case ConnectionState.done:
            default:
              if (snapshot.hasError)
                return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Create Custom Plan',
                        style: TextStyle(color: Colors.black),
                      ),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    body: Center(child: Text("No Internet Connectivity")));
              else if (snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Create Custom Plan',
                      style: TextStyle(color: Colors.black),
                    ),
                    elevation: 1,
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day--;
                                  if (day < 1) {
                                    day = 1;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios, size: 12.5),
                            ),
                            ShowCaseView(
                              globalKey: _mindCustomDays,
                              title: "Select Day",
                              description:
                                  "Custom plan would be saved for selected day, select another day to save minds in same plan",
                              shapeBorder: BeveledRectangleBorder(),
                              child: Text(
                                'Day ${day > 100 ? 100 : day}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 12,
                                  color: Color(0xcc1e1e1e),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day++;
                                  if (day > 100) {
                                    day = 100;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios, size: 12.5),
                            ),
                            const Spacer(),
                            ShowCaseView(
                              globalKey: _mindCustomSelectedFood,
                              title: "Selected Minds",
                              description: "Number of minds selected for a day",
                              shapeBorder: BeveledRectangleBorder(),
                              child: Text(
                                'Meditation Selected: ${_mindProvider.getMindList().length}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 10,
                                  color: Color(0x991e1e1e),
                                ),
                                softWrap: false,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Select Custom Meditation',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 10,
                              color: const Color(0x991e1e1e),
                            ),
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchMeditations(),
                                      ),
                                    );
                                  },
                                  child: ShowCaseView(
                                    globalKey: _mindCustomSearch,
                                    title: "Search Minds",
                                    description:
                                        "Search for minds to add in custom plan",
                                    shapeBorder: BeveledRectangleBorder(),
                                    child: TextField(
                                      style: lightText12Px,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                  color: Colors.black45,
                                                  width: 0.1)),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            size: 20,
                                            color: Colors.black45,
                                          ),
                                          hintText: "Search"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            indent: 50,
                            endIndent: 50,
                            thickness: 2,
                            height: 10),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  _custommindProvider.getMindList().length,
                              itemBuilder: (context, index) {
                                return MeditationTile(
                                    listItem: snapshot.data.videosData[index],
                                    notifyParent: () => setState(() {}));
                              }),
                        )
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: ShowCaseView(
                    globalKey: _mindCustomSaveDiet,
                    title: "Save Mind",
                    description:
                        "Tap to save mind for a specific day and a plan would be created",
                    child: FloatingActionButton.extended(
                      extendedPadding: const EdgeInsets.symmetric(
                          horizontal: 22.5, vertical: 0),
                      label: const Text('Save Exercises'),
                      extendedTextStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: Color(0xffffffff),
                        height: 0.9333333333333333,
                      ),
                      backgroundColor: Colors.blueAccent,
                      onPressed: () {
                        print("Plan Day $day is: ${plandays[day - 1]}");
                        if (daysAdded <= 100 && plandays[day - 1] == false) {
                          var _foodProvider = getit<addedmindlistprovider>();
                          List<VideosData> foodItems =
                              _foodProvider.getMindList();
                          print("Mind Items Length:" +
                              foodItems.length.toString());

                          if (foodItems.length > 0) {
                            UIBlock.block(context);

                            if (_custommindProvider.getPlanId() == null) {
                              print("Creating Plan Id");
                              AddPlan("").then((value) {
                                if (value.statusCode == 200) {
                                  print("Created Plan:" +
                                      value.data['planId'].toString());
                                  _custommindProvider
                                      .setPlanId(value.data['planId']);
                                  addMindToCustomPlan(value.data['planId']);
                                  //.then((value) {

                                  // });
                                }
                              });
                            } else {
                              addMindToCustomPlan(
                                  _custommindProvider.getPlanId());
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Row(
                                  children: [
                                    Icon(Icons.error_outline_rounded),
                                    SizedBox(width: 10),
                                    Text("Please select items to add in plan"),
                                  ],
                                )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Row(
                                children: [
                                  Icon(Icons.error_outline_rounded),
                                  SizedBox(width: 10),
                                  Text("Already Added"),
                                ],
                              )));
                        }
                      },
                    ),
                  ),
                );
              } else
                return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}

class MeditationTile extends StatefulWidget {
  MeditationTile({
    Key key,
    this.listItem,
    this.notifyParent,
  }) : super(key: key);
  final VideosData listItem;
  final Function() notifyParent;

  @override
  State<MeditationTile> createState() => _MeditationTileState();
}

class _MeditationTileState extends State<MeditationTile> {
  bool isSelected = false;
  List<int> mindItemsId;
  List<VideosData> mindItems;
  var _exerciseProvider = getit<addedmindlistprovider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mindItems = _exerciseProvider.getMindList();
    mindItemsId = _exerciseProvider.getMindListId();

    _exerciseProvider.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: Image.network(
                                  '$imageBaseUrl${widget.listItem.imageFile ?? 'https://www.verywellfit.com/thmb/J2Nl2AnM4FS2IM_XtGKEn9QWBRs=/500x350/filters:no_upscale():max_bytes(150000):strip_icc()/what-is-vigorous-intensity-exercise-3435408-0973-1602bd0a4ec54abb8808648de38b52cd.jpg'}')
                              .image,
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        widget.listItem.title ?? "No Title",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                          fontWeight: FontWeight.w300,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      Text(
                        '${widget.listItem.duration} mins',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: const Color(0xffafafaf),
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Column(
                    children: [
                      Text(
                        '${widget.listItem.calories} kcal',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                        ),
                        softWrap: false,
                      ),
                      IconButton(
                        onPressed: () {
                          if (!mindItemsId.contains(
                              int.parse(widget.listItem.id.toString()))) {
                            //isSelected = true;

                            _exerciseProvider.setListItem(widget.listItem);
                            _exerciseProvider.setAddedItemId(
                                int.parse(widget.listItem.id.toString()));
                          } else {
                            //isSelected = false;

                            _exerciseProvider.deleteAddedMind(
                                int.parse(widget.listItem.id.toString()));
                            _exerciseProvider.deleteAddedMindId(
                                int.parse(widget.listItem.id.toString()));
                          }
                        },
                        icon: mindItemsId.contains(
                                int.parse(widget.listItem.id.toString()))
                            ? const Icon(Icons.check, color: Colors.blueAccent)
                            : const Icon(Icons.add, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
              height: 20,
              color: Colors.grey.shade200),
        ],
      ),
    );
  }
}


/*
class CreateMeditationCustomPlan extends StatefulWidget {
  int activeCode;

  CreateMeditationCustomPlan(this.activeCode);

  @override
  _CreateMeditationCustomPlanState createState() =>
      _CreateMeditationCustomPlanState();
}

class _CreateMeditationCustomPlanState extends State<CreateMeditationCustomPlan>
    with TickerProviderStateMixin {
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
    if (widget.activeCode == 1) {
      final provider =
          Provider.of<CustomMindPlanProvider>(context, listen: false);
      setState(() {
        titleController.text = provider.customMindPlanModel.title;
        selectDaysController.text = provider.customMindPlanModel.duration;
        mindVideos = provider.customMindPlanModel.mindItem;
        selectedImage = provider.customMindPlanModel.imageFile;
      });
      for (int i = 0;
          i < int.parse(provider.customMindPlanModel.duration);
          i++) {
        if (i == 0) {
          days.add(true);
        } else
          days.add(false);
      }
    } else {
      for (int i = 0; i < 7; i++) {
        if (i == 0) {
          days.add(true);
        } else
          days.add(false);
      }
    }
  }

  List<bool> days = [];

  List<MindVideoModel> mindVideos = [];
  int dayNumber = 1;
  var selectDaysController = TextEditingController();
  var titleController = TextEditingController();
  var selectedImage;
  int userid;
  // #################################### GETTING IMAGE FROM GALLERY ################################

  Future getImageFromGallery() async {
    var pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    return pickedFile;
  }

  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  List<XFile> _imageFileList;
  dynamic _pickImageError;

// #################################### GETTING IMAGE FROM CAMERA ################################
  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera() async {
    var pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    return pickedFile;
  }

  ProgressDialog pr;
  Future<Response> upload(var imageFile) async {
    pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    Dio dio = new Dio();

    FormData formdata = new FormData();
    String fileName = imageFile.path.split('/').last;
    print("file data ${titleController.text} ${days.length}");
    print("file data ${imageFile.path} ${imageFile.name}");
    formdata = FormData.fromMap({
      "PlanTypeId": 3,
      "Title": titleController.text == "" ? "unnamed" : titleController.text,
      "Description": "",
      "Details": "",
      "duration": days.length,
      "Calories": 0,
      "UserId": userid,
      //"FileName" : fileName,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        //contentType: new MediaType("image", "jpeg"),
      )
    });
    return dio.post('$apiUrl/api/plan/addplan',
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
  }

  addMindVideosToCustomPlan(planId) {
    print("Hello");
    List<int> statusCodes = [];

    mindVideos.forEach((element) {
      print(jsonEncode(<String, dynamic>{
        "VideoId": int.parse(element.videoId),
        "PlanId": planId,
        "Day": element.day,
        "Title": element.name,
      }));

      http
          .post(
        Uri.parse('$apiUrl/api/plan/mindplan'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "VideoId": int.parse(element.videoId),
          "PlanId": planId,
          "Day": element.day,
          "Title": element.name,
        }),
      )
          .then((value) {
        print("mind then ${value.statusCode}  ${value.body} ");
        statusCodes.add(value.statusCode);
      }).onError((error, stackTrace) {
        print("error $error");
      });
    });
    statusCodes.forEach((element) {
      print("mind  codes $element");
    });
    _showDialog("Successfully Added", "Your custom mind plan has been created");
  }

  dialogForCamera() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: Responsive1.isMobile(context) ? null : 300,
            height: MySize.size250,
            child: SizedBox.expand(
                child: Column(
              children: [
                SizedBox(
                  height: MySize.size20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DDText(
                      title: "Choose an Action",
                      size: MySize.size16,
                      weight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: MySize.size10,
                ),
                Divider(
                  color: primaryColor,
                  thickness: 2,
                ),
                Container(
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20)
                              // primary: Colors.transparent,

                              ),
                          icon: Icon(FontAwesomeIcons.images),
                          onPressed: () async {
                            getImageFromGallery().then((value) {
                              setState(() {
                                selectedImage = value;
                              });
                              Navigator.pop(context);
                            });
                          },
                          label: DDText(
                            title: "Choose From Gallery",
                          )),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    TextButton.icon(
                        style:
                            ElevatedButton.styleFrom(padding: EdgeInsets.all(20)
                                // primary: Colors.transparent,

                                ),
                        icon: Icon(FontAwesomeIcons.camera),
                        onPressed: () async {
                          getImageFromCamera().then((value) {
                            setState(() {
                              selectedImage = value;
                            });
                            Navigator.pop(context);
                          });
                        },
                        label: DDText(
                          title: "Capture From Camera",
                        )),
                  ],
                ),

                // Divider(),
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (title == "Successfully Added") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyMindPlansView()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    pr = ProgressDialog(context);
    int initialIndex;

    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double margin = height * 0.02;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: titleAppBar(context: context, title: "Create Mediation Program"),
      body: Container(
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: height * 0.26,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      dialogForCamera();
                    },
                    child: selectedImage == null
                        ? Image.asset(
                            ImagePath.mindPlan,
                            fit: BoxFit.cover,
                            height: height * 0.3,
                            width: MediaQuery.of(context).size.width,
                          )
                        : Image.file(
                            File(selectedImage.path),
                            fit: BoxFit.cover,
                            height: height * 0.3,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: titleController,
                        readOnly: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => DialogWithInputFieldWidget((text) {
                              setState(() {
                                titleController.text = text;
                              });
                            }, titleController.text, "Name"),
                          );
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // counterStyle: TextStyle(color: Colors.red),
                          hintText: "Name",

                          hintStyle: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MySize.size30,
            ),
            headingView("Select Days", MySize.size0),
            //daysRowUpdated(margin, height),
            Container(
                margin: EdgeInsets.only(
                  left: height * 0.025,
                ),
                height: orientation==Orientation.landscape?MediaQuery.of(context).size.height * 0.09:MediaQuery.of(context).size.height * 0.06,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        for (int i = 0; i < days.length; i++) {
                          setState(() {
                            days[i] = false;
                          });
                        }
                        setState(() {
                          days[index] = true;
                          dayNumber = index + 1;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.08,
                        padding: EdgeInsets.only(
                          top: MySize.size4,
                          bottom: MySize.size4,
                        ),
                        // padding: EdgeInsets.fromLTRB(height * 0.001,
                        //     height * 0.018, height * 0.002, height * 0.015),
                        margin: EdgeInsets.only(
                          right: height * 0.025,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: days[index]
                                ? selectedBgColor
                                : unSelectedBgColor),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DDText(
                                title: "Day",
                                size: 11,
                                weight: FontWeight.w300,
                                color: days[index]
                                    ? selectedTextColor
                                    : unSelectedTextColor,
                              ),
                              DDText(
                                title: (index + 1).toString(),
                                size: 11,
                                weight: FontWeight.w300,
                                color: days[index]
                                    ? selectedTextColor
                                    : unSelectedTextColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
            SizedBox(
              height: MySize.size20,
            ),
            /*Container(
              padding: EdgeInsets.only(
                left: MySize.size16,
                right: MySize.size16,
              ),
              child: DDText(title: "Morning"),
            ),


            SizedBox(height: MySize.size10),
            gridSectionforAddFood(null, null, null, null),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: MySize.size16,
                right: MySize.size16,
              ),
              child: DDText(title: "Lunch"),
            ),
            SizedBox(height: MySize.size10),
            gridSectionforAddFood(null, null, null, null),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: MySize.size16,
                right: MySize.size16,
              ),
              child: DDText(title: "Dinner"),
            ),*/
            if (widget.activeCode == 1)
              mindVideos.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mindVideos.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("length of mindvideos:" +
                            mindVideos.length.toString());
                        return gridSectionforAddFood(mindVideos[index], index);
                      },
                    )
                  : Container(),
            SizedBox(height: MySize.size10),
            InkWell(
              onTap: () {
                final tempProvider =
                    Provider.of<CustomMindPlanProvider>(context, listen: false);
                final provider =
                    Provider.of<UserDataProvider>(context, listen: false);

                CustomMindProviderModel tempModel = new CustomMindProviderModel(
                    titleController.text,
                    days.length.toString(),
                    selectedImage,
                    mindVideos);
                provider.setCustomPlanStatusCode(1);
                tempProvider.setTempCustomDietPlanData(tempModel);
                // tempProvider.setSelectSet("Hello");
                tempProvider.setSelectedDay(dayNumber);
                Responsive1.isMobile(context)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectMeditationPlan()))
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) => Padding(
                            padding: const EdgeInsets.only(
                                left: 250, right: 250, bottom: 50, top: 50),
                            child: SelectMeditationPlan()));
              },
              child: Container(
                height: 90,
                width: 60,
                margin: EdgeInsets.fromLTRB(
                    10, 0, MediaQuery.of(context).size.width * 0.8, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage("assets/images/food_add.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size42),
              child: Divider(),
            ),
            SizedBox(height: MySize.size10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    if (selectedImage == null) {
                      _showDialog("No Image", "Please upload an image");
                      //DDToast().showToast("No Image", "Please upload an image", true);
                    } else if (mindVideos.length == 0) {
                      _showDialog("No videos", "Please add at least one video");
                      //DDToast().showToast("No meal", "Please add atleast one meal", true);
                    } else {
                      SimpleFontelicoProgressDialog _dialog =
                          SimpleFontelicoProgressDialog(
                              context: context, barrierDimisable: true);
                      //_dialog.show(message: 'Please Wait', type: SimpleFontelicoProgressDialogType.normal);
                      upload(selectedImage).then((value) {
                        print(
                            "dio response data ${value.data} code ${value.statusCode} message ${value.statusMessage}");
                        pr.hide();
                        addMindVideosToCustomPlan(value.data['planId']);
                        //_dialog.hide();
                      }).onError((error, stackTrace) {
                        //_dialog.hide();
                        print("dio response error ${error.toString()}");
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: DDText(
                      title: "Save",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget gridSectionforAddFood(MindVideoModel model, int index) {
    print("mindvideomodel:" + model.toString());
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: MySize.size16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Container(
                        height: 90,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: Image.network(
                            '$imageBaseUrl${model.imageFile}',
                            height: 90,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: MySize.size16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DDText(
                              title: model.name,
                              size: MySize.size15,
                              weight: FontWeight.w300),
                          DDText(
                            title: "${model.duration} sec",
                            size: MySize.size11,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: MySize.size14),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mindVideos.removeAt(index);
                      });
                      Flushbar(
                        backgroundColor: Colors.red,
                        title: "Message",
                        message: "Tapped on delete Icon",
                        duration: Duration(seconds: 3),
                      )..show(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(Icons.delete),
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size42),
          child: Divider(),
        ),
      ],
    );
  }

  Widget headingView(title, bottomPadding) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size16, bottom: bottomPadding),
      child: Container(
        // margin: const EdgeInsets.only(right: 100, left: 10),
        child: TextField(
          controller: selectDaysController,
          keyboardType: TextInputType.number,
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => DialogWithInputFieldWidget((text) {
                setState(() {
                  selectDaysController.text = text;
                  days.clear();
                  for (int i = 0;
                      i < int.parse(selectDaysController.text);
                      i++) {
                    if (i == 0) {
                      days.add(true);
                    } else
                      days.add(false);
                  }
                });
              }, selectDaysController.text, "Days"),
            );
          },
          style: GoogleFonts.openSans(
              fontSize: MySize.size15, color: Colors.black),
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: 'Select Days',
            hintStyle: GoogleFonts.openSans(
                fontSize: MySize.size15, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget leftRightheading(left, right) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              style: GoogleFonts.openSans(
                  fontSize: MySize.size15, color: Colors.black),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: left,
                hintStyle: GoogleFonts.openSans(
                    fontSize: MySize.size15, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.openSans(
                  fontSize: MySize.size15, color: Colors.black),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: right,
                hintStyle: GoogleFonts.openSans(
                    fontSize: MySize.size15, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
