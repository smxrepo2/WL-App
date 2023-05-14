import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
// import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/selfie_model.dart';
//import 'package:weight_loser/models/upload_selfie.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

//import '../widget/comparison.dart';

//import '../models/upload_selfie.dart';

//import 'package:weight_loser/widget/comparison.dart';
//enum MediaType { Image }

class UltimateSelfieView extends StatefulWidget {
  UltimateSelfieView({
    Key key,
  }) : super(key: key);

  // final String title;

  @override
  _UltimateSelfieViewState createState() => _UltimateSelfieViewState();
}

class _UltimateSelfieViewState extends State<UltimateSelfieView>
    with TickerProviderStateMixin {
  // FlutterUploader uploader = FlutterUploader();
  StreamSubscription _progressSubscription;
  StreamSubscription _resultSubscription;

  // ignore: unused_field
  TabController _tabController;
  bool _isShowDial = false;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];
  bool swapImage = false;
  int userid;
  Future<SelfieModel> fetchSelfies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response =
        await http.get(Uri.parse('$apiUrl/api/selfie/getbyuser/$userid'));
    if (response.statusCode == 200) {
      print("Selfie Data:" + response.body);

      return SelfieModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load selfies');
    }
  }

  var weightContoller = TextEditingController();
  var waistContoller = TextEditingController();
  var dateController = TextEditingController();
  var dateFormat = DateFormat("dd/MM/yyyy");
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
  }

  List<XFile> _imageFileList;

  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

// ########################## FUNCTION TO GET IMAGES FROM GALLERY #####################

  Future getImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = pickedFile;
      });
      return _imageFileList;
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

// ########################## FUNCTION TO GET IMAGES FROM CAMERA #####################
  var selectedImage;
  Future getImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _imageFile = pickedFile;
      });
      return _imageFileList;
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  Future<Response> upload(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    Dio dio = new Dio();
    FormData formdata = new FormData();
    //var datetime = DateTime.fromMillisecondsSinceEpoch(
    //  start.millisecondsSinceEpoch,
    //isUtc: true);
    String fileName = imageFile.path.split('/').last;
    formdata = FormData.fromMap({
      "UserId": userid,
      "Weight": weightContoller.text,
      "Waist": waistContoller.text,
      "Dated": start,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        //contentType: MediaType("image", 'jpg/jpeg'),
      ),
    });

    var response = await dio.post(
      '$apiUrl/api/selfie',
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
      data: formdata,
      options: Options(
          method: 'POST',
          responseType: ResponseType.json // or ResponseType.JSON
          ),
    );
    print("response of uploading:" + response.toString());
    if (response.statusCode == 200) {
      return response;
    }
  }

// ################### IMAGES USED TO SHOW ######################

  List imagesData = [
    {"image": "assets/images/image11.png"},
    {"image": "assets/images/image2.png"},
    {"image": "assets/images/image3.png"},
    {"image": "assets/images/image4.png"},
  ];

// ############################## DIALOG FOR GALLERY AND CAMERA OPTION ###########################

  dialogForCamera() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: this.context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: MySize.size240,
            child: SizedBox.expand(
                child: Column(
              children: [
                SizedBox(
                  height: MySize.size15,
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
                              Navigator.pop(this.context);
                              showAlert(this.context, value);
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
                          getImageFromCamera().then((image) {
                            setState(() {
                              selectedImage = image;
                            });
                            Navigator.pop(this.context);
                            showAlert(this.context, image);
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

// ############################## DIALOG FOR IMAGE ###########################
  DateTime start = DateTime.now();
  _selectDate(BuildContext context) async {
    start = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (start != null)
      setState(() {
        print("selected date:" + start.toIso8601String());
        dateController.text = dateFormat.format(start).toString();
      });
  }

  showAlert(BuildContext context, value) {
    print(value);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  actions: <Widget>[
                    Column(
                      children: [
                        value == null
                            ? CircularProgressIndicator()
                            : Image.file(
                                File(value[0].path),
                              ),
                        SizedBox(
                          height: MySize.size20,
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        Row(
                          children: [
                            Text("Add Weight: ",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                )),
                            Container(
                                width: MySize.size105,
                                // height: 40,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else if (int.parse(value) < 50) {
                                      return 'Weight can not be less than 50';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: weightContoller,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                      hintText: "",
                                      hintStyle: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold)),
                                )),
                            Container(
                              width: MySize.size50,
                              child: DropdownButton<String>(
                                iconSize: 0.0,
                                value: weightDropValue,
                                underline: SizedBox(),
                                isExpanded: true,
                                items: <String>['kg'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        Row(
                          children: [
                            Text("Add Waist: ",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: MySize.size105,

                                      // height: 40,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: waistContoller,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                            hintText: "",
                                            hintStyle: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  Container(
                                    width: MySize.size50,
                                    child: DropdownButton<String>(
                                      iconSize: 0.0,
                                      value: waitDropDownValue,
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      items: <String>['in'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        Row(
                          children: [
                            Text("Date: ",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                )),
                            Container(
                                width: MySize.size200,

                                // height: 40,
                                child: TextFormField(
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: dateController,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                      hintText: "Select Date",
                                      hintStyle: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold)),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: MySize.size40,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("Discard",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xffE55864))),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  final ProgressDialog pr =
                                      ProgressDialog(context);
                                  pr.show();
                                  upload(File(value[0].path)).then((value) {
                                    if (value.statusCode == 200) {
                                      pr.hide();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UltimateSelfieView(),
                                        ),
                                      );
                                    } else {
                                      pr.hide();
                                      print(
                                          "res error ${value.statusCode} ${value.statusMessage}");
                                      Navigator.pop(context);
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(value.statusMessage),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }).onError((error, stackTrace) {
                                    print("error ${error.toString()}");
                                    Navigator.pop(context);
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(error.toString()),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                }
                              },
                              child: Text(
                                "Save",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff4885ED)),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// ############################## COMPARE IMAGES DIALOG ###########################

  showAlert2(BuildContext context, SelfieModel selfies) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: Responsive1.isMobile(context)
              ? const EdgeInsets.all(8.0)
              : EdgeInsets.only(left: 200, right: 200, bottom: 50, top: 50),
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: AlertDialog(
                // contentPadding: EdgeInsets.all(0),
                insetPadding:
                    EdgeInsets.only(bottom: MySize.size2, top: MySize.size2),
                clipBehavior: Clip.antiAlias,
                // contentPadding: EdgeInsets.fromLTRB(50, 50, 50, 50),
                actions: <Widget>[
                  Container(
                    // padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // padding: EdgeInsets.only(right: 2),
                                height:
                                    MediaQuery.of(context).size.height / 1.4,
                                width: Responsive1.isMobile(context)
                                    ? MediaQuery.of(context).size.width / 2
                                    : 300,
                                child: Image.network(
                                  '${selfies.imagePath}${selfies.ultimateSelfies[0].imageName}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(left: 2, right: 0),
                                height:
                                    MediaQuery.of(context).size.height / 1.4,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  '${selfies.imagePath}${selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1].imageName}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Weight: ",
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w300,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${selfies.ultimateSelfies[0].weight}",
                                                style: GoogleFonts.openSans(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("kg"),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: MySize.size10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Waist: ",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                            "${selfies.ultimateSelfies[0].waist}",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold)),
                                        Text("in")
                                      ],
                                    ),
                                    SizedBox(height: MySize.size10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Date: ",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                            dateFormat.format(DateTime.parse(
                                                selfies
                                                    .ultimateSelfies[0].dated)),
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.green,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 2.0),
                                    child: SizedBox(
                                      height: 70.0,
                                      child: SolidLineConnector(
                                        color: Color(0xffdfdfdf),
                                      ),
                                    ),
                                  ),
                                  OutlinedDotIndicator(
                                    size: 10,
                                    color: Color(0xffdfdfdf),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                // color: Colors.blue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Weight: ",
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w300,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                            selfies
                                                .ultimateSelfies[selfies
                                                        .ultimateSelfies
                                                        .length -
                                                    1]
                                                .weight
                                                .toString(),
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold)),
                                        Text("kg"),
                                      ],
                                    ),
                                    SizedBox(height: MySize.size10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Waist: ",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                            selfies
                                                .ultimateSelfies[selfies
                                                        .ultimateSelfies
                                                        .length -
                                                    1]
                                                .waist
                                                .toString(),
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold)),
                                        Text("in")
                                      ],
                                    ),
                                    SizedBox(height: MySize.size10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Date: ",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                            dateFormat.format(DateTime.parse(
                                                selfies
                                                    .ultimateSelfies[selfies
                                                            .ultimateSelfies
                                                            .length -
                                                        1]
                                                    .dated)),
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MySize.size10,
                  ),
                  SizedBox(
                    height: MySize.size30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if ((selfies.ultimateSelfies[0].weight -
                              selfies
                                  .ultimateSelfies[
                                      selfies.ultimateSelfies.length - 1]
                                  .weight) >
                          0)
                        Text(
                          "You gained ",
                          style:
                              GoogleFonts.openSans(fontWeight: FontWeight.w300),
                        )
                      else if ((selfies.ultimateSelfies[0].weight -
                              selfies
                                  .ultimateSelfies[
                                      selfies.ultimateSelfies.length - 1]
                                  .weight) ==
                          0)
                        Text(
                          "Your weight didn't changed",
                          style:
                              GoogleFonts.openSans(fontWeight: FontWeight.w300),
                        )
                      else
                        Text(
                          "Congratulation you lost ",
                          style:
                              GoogleFonts.openSans(fontWeight: FontWeight.w300),
                        ),
                      if ((selfies.ultimateSelfies[0].weight -
                              selfies
                                  .ultimateSelfies[
                                      selfies.ultimateSelfies.length - 1]
                                  .weight) !=
                          0)
                        Text(
                          "${'${(selfies.ultimateSelfies[0].weight - selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1].weight).abs()}'}",
                          style: GoogleFonts.openSans(
                              color: Color(0xff4885ED),
                              fontWeight: FontWeight.w300),
                        ),
                      if ((selfies.ultimateSelfies[0].weight -
                              selfies
                                  .ultimateSelfies[
                                      selfies.ultimateSelfies.length - 1]
                                  .weight) !=
                          0)
                        Text(
                          "Kg",
                          style:
                              GoogleFonts.openSans(fontWeight: FontWeight.w300),
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();

  var waitDropDownValue = "in";
  var weightDropValue = "kg";
// ########################### BODY VIEW #####################
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: _getFloatingActionButton(),
        drawer: CustomDrawer(),
        // bottomNavigationBar: CustomStaticBottomNavigationBar(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? customAppBar(
                  context,
                  elevation: 0.5,
                )
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        // appBar: customAppBar(
        //   context,
        //   elevation: 0.5,
        // ),
        // tabBar: TabBar(
        //   onTap: (index) {
        //     setState(() {
        //       _tabController.index = 2;
        //     });
        //   },
        //   controller: _tabController,
        //   labelPadding: EdgeInsets.only(left: MySize.size4),
        //   indicatorColor: Colors.transparent,
        //   labelColor: Colors.black,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   unselectedLabelColor: Colors.black87,
        //   tabs: myTabs,
        // ),
        // ),
        body: Padding(
          padding: Responsive1.isMobile(context)
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.only(left: 100, right: 100),
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                SizedBox(
                  height: MySize.size30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MySize.size20,
                    right: MySize.size20,
                    bottom: MySize.size10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Ultimate Selfie",
                        style: GoogleFonts.openSans(fontSize: MySize.size15),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () async {
                                // final XFile photo = await _picker.pickImage(
                                //     source: ImageSource.camera);
                                dialogForCamera();
                                // print(photo);
                              },
                              child:
                                  //Image.asset("assets/icons/camera_alt.png")
                                  Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              )),
                          SizedBox(
                            width: MySize.size10,
                          ),
                          GestureDetector(
                              onTap: () => fetchSelfies().then(
                                  (value) => value.ultimateSelfies.isNotEmpty
                                      ? showAlert2(context, value)
                                      : Flushbar(
                                          title: 'Message',
                                          message: 'No Selfies',
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                        )
                                    ..show(context)),
                              child:
                                  Image.asset("assets/icons/image_compare.png"))
                        ],
                      )
                    ],
                  ),
                ),
                OutlinedDotIndicator(),
                FutureBuilder<SelfieModel>(
                  future: fetchSelfies(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      snapshot.data.ultimateSelfies
                          .sort((a, b) => b.dated.compareTo(a.dated));
                      if (snapshot.data.ultimateSelfies.length == 0)
                        return Center(
                          child: Text('No selfies'),
                        );
                      else
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.ultimateSelfies.length,
                            itemBuilder: (BuildContext ctx, index) {
                              if (index % 2 == 0)
                                return TimelineTile(
                                  oppositeContents: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(dateFormat.format(
                                        DateTime.parse(snapshot.data
                                            .ultimateSelfies[index].dated))),
                                  ),
                                  contents: Container(
                                    width: MySize.size200,
                                    height: MySize.size250,
                                    padding: EdgeInsets.only(
                                        left: MySize.size30,
                                        right: MySize.size30),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return DetailScreen(
                                                counter: 0,
                                                imageUrl:
                                                    '${snapshot.data.imagePath}${snapshot.data.ultimateSelfies[index].imageName}',
                                              );
                                            }));
                                          },
                                          child: Hero(
                                            tag:
                                                '${snapshot.data.imagePath}${snapshot.data.ultimateSelfies[index].imageName}',
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    '${snapshot.data.imagePath}${snapshot.data.ultimateSelfies[index].imageName}',
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            DDText(
                                              title: "Weight:",
                                              weight: FontWeight.w300,
                                            ),
                                            DDText(
                                              title: snapshot.data
                                                  .ultimateSelfies[index].weight
                                                  .toString(),
                                              weight: FontWeight.w500,
                                            ),
                                            DDText(
                                              title: "Kg",
                                              weight: FontWeight.w300,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            DDText(
                                              title: "Waist:",
                                              weight: FontWeight.w300,
                                            ),
                                            DDText(
                                              title:
                                                  "${snapshot.data.ultimateSelfies[index].waist}",
                                              weight: FontWeight.w500,
                                            ),
                                            DDText(
                                              title: "in",
                                              weight: FontWeight.w300,
                                            ),
                                          ],
                                        ),
                                        /*Row(
                                        children: [
                                          DDText(
                                            title: "Lost:",
                                            weight: FontWeight.w300,
                                          ),
                                          DDText(
                                            title: " 4",
                                            weight: FontWeight.w500,
                                          ),
                                          DDText(
                                            title: "Kg",
                                            weight: FontWeight.w300,
                                          ),
                                        ],
                                      ),*/
                                      ],
                                    ),
                                  ),
                                  node: TimelineNode(
                                    indicator: OutlinedDotIndicator(),
                                    startConnector: SolidLineConnector(),
                                    endConnector: SolidLineConnector(),
                                  ),
                                );
                              else
                                return TimelineTile(
                                  oppositeContents: Container(
                                    width: MySize.size200,
                                    height: MySize.size250,
                                    padding: EdgeInsets.only(
                                        left: MySize.size30,
                                        right: MySize.size30),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return DetailScreen(
                                                counter: 0,
                                                imageUrl:
                                                    '${snapshot.data.imagePath}${snapshot.data.ultimateSelfies[index].imageName}',
                                              );
                                            }));
                                          },
                                          child: Hero(
                                            tag:
                                                '${snapshot.data.imagePath}${snapshot.data.ultimateSelfies[index].imageName}',
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    '${snapshot.data.imagePath}${snapshot.data.ultimateSelfies[index].imageName}',
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            DDText(
                                              title: "Weight:",
                                              weight: FontWeight.w300,
                                            ),
                                            DDText(
                                              title: snapshot.data
                                                  .ultimateSelfies[index].weight
                                                  .toString(),
                                              weight: FontWeight.w500,
                                            ),
                                            DDText(
                                              title: "Kg",
                                              weight: FontWeight.w300,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            DDText(
                                              title: "Waist:",
                                              weight: FontWeight.w300,
                                            ),
                                            DDText(
                                              title:
                                                  "${snapshot.data.ultimateSelfies[index].waist}",
                                              weight: FontWeight.w500,
                                            ),
                                            DDText(
                                              title: "in",
                                              weight: FontWeight.w300,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  contents: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(dateFormat.format(
                                        DateTime.parse(snapshot.data
                                            .ultimateSelfies[index].dated))),
                                  ),
                                  node: TimelineNode(
                                    indicator: OutlinedDotIndicator(),
                                    startConnector: SolidLineConnector(),
                                    endConnector: SolidLineConnector(),
                                  ),
                                );
                            });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('No Internet Connectivity'),
                      );
                    }

                    // By default, show a loading spinner.
                    return Shimmer.fromColors(
                      child: TimelineTile(
                        oppositeContents: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(dateFormat.format(DateTime.now())),
                        ),
                        contents: Container(
                          width: MySize.size200,
                          height: MySize.size250,
                          padding: EdgeInsets.only(
                              left: MySize.size30, right: MySize.size30),
                          child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Row(
                                children: [
                                  DDText(
                                    title: "Weight:",
                                    weight: FontWeight.w300,
                                  ),
                                  DDText(
                                    title: '0',
                                    weight: FontWeight.w500,
                                  ),
                                  DDText(
                                    title: "Kg",
                                    weight: FontWeight.w300,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  DDText(
                                    title: "Waist:",
                                    weight: FontWeight.w300,
                                  ),
                                  DDText(
                                    title: "0",
                                    weight: FontWeight.w500,
                                  ),
                                  DDText(
                                    title: "in",
                                    weight: FontWeight.w300,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        node: TimelineNode(
                          indicator: OutlinedDotIndicator(),
                          startConnector: SolidLineConnector(),
                          endConnector: SolidLineConnector(),
                        ),
                      ),
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      isEnableAnimation: true,

      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        _isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          isExtended: true,
          heroTag: "floating_button_menu",
          backgroundColor: primaryColor,
          mini: false,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {},
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: primaryColor),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          heroTag: "water",
          mini: true,
          child: Icon(
            Icons.water,
            color: Colors.grey,
          ),
          onPressed: () {
            //if need to close menu after click
            _isShowDial = false;
            setState(() {});
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "exercise",
          mini: true,
          child: Icon(
            FontAwesomeIcons.running,
            color: Colors.grey,
          ),
          onPressed: () {
            //if need to toggle menu after click
            _isShowDial = !_isShowDial;
            setState(() {});
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "food",
          mini: true,
          child: Icon(
            Icons.food_bank,
            color: Colors.grey,
          ),
          onPressed: () {
            //if no need to change the menu status
            Navigator.push(this.context,
                MaterialPageRoute(builder: (context) => SearchFood(false)));
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "weight",
          mini: true,
          child: Icon(
            Icons.monitor_weight,
            color: Colors.grey,
          ),
          onPressed: () {
            //if no need to change the menu status
          },
          backgroundColor: Colors.white,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }
}

class DetailScreen extends StatefulWidget {
  final counter;
  final imageUrl;

  const DetailScreen({Key key, this.imageUrl, this.counter}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: widget.imageUrl + widget.counter.toString(),
            child: Image.network(
              widget.imageUrl,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
