import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomExercisePlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/custom_exercise_provider_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/screens/exercise_screens/MyPlansExercise.dart';

import 'package:weight_loser/screens/exercise_screens/SelectExercisePlan.dart';

import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/AppBarView.dart';

import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/dialog_with_input_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:weight_loser/theme/TextStyles.dart';

class CreateExerciseCustomPlan extends StatefulWidget {
  int activeCode;

  CreateExerciseCustomPlan(this.activeCode);

  @override
  _CreateExerciseCustomPlanState createState() =>
      _CreateExerciseCustomPlanState();
}

class _CreateExerciseCustomPlanState extends State<CreateExerciseCustomPlan>
    with TickerProviderStateMixin {
  TabController _tabController;

  int _stepIndex = 0;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];

  List<ExerciseSetModel> exercises = [];
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

  List<bool> days = [];

  int dayNumber = 1;
  List<List<ExerciseSetModel>> sets = [];
  var selectDaysController = TextEditingController();
  var setController = TextEditingController();
  var repsController = TextEditingController();
  var titleController = TextEditingController();
  var selectedImage;

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

  int userid;
  Future<Response> upload(var imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    Dio dio = new Dio();
    FormData formdata = new FormData();
    String fileName = imageFile.path.split('/').last;
    print("file data ${titleController.text} ${days.length}");
    print("file data ${imageFile.path} ${imageFile.name}");
    formdata = FormData.fromMap({
      "PlanTypeId": 2,
      "Title": titleController.text == "" ? "unnamed" : titleController.text,
      "Description": "",
      "Details": "",
      "duration": days.length,
      "Calories": 105,
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

  addExerciseToCustomPlan(int planId) {
    List<int> statusCodes = [];
    sets.forEach((setItem) {
      print("SetItem:" + setItem.toString());
      setItem.forEach((element) {
        print("SetItem:" + element.toString());
        print("plan id ${element.burnerId}");
        print("plan day ${element.day}");
        http
            .post(
          Uri.parse('$apiUrl/api/plan/ExercisePlan'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "BurnerId": element.burnerId,
            "PlanId": planId,
            "Day": element.day,
            "Title": element.setName
          }),
        )
            .then((value) {
          print("Mind then ${value.statusCode}  ${value.body} ");
          statusCodes.add(value.statusCode);
        }).onError((error, stackTrace) {
          print("error $error");
        });
      });
    });
    statusCodes.forEach((element) {
      print("exercise codes $element");
    });
    print("Plan id $planId");
    _showDialog(
        "Successfully Added", "Your custom exercise plan has been created", () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyPlansExercise()));
    });
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
            height: MySize.size240,
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

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(2);
    print("active code ${widget.activeCode}");
    if (widget.activeCode == 1) {
      final provider =
          Provider.of<CustomExercisePlanProvider>(context, listen: false);
      setState(() {
        sets = provider.customExercisePlanModel.sets;
        titleController.text = provider.customExercisePlanModel.title;
        selectDaysController.text = provider.customExercisePlanModel.duration;
        exercises = provider.customExercisePlanModel.exerciseItem;
        selectedImage = provider.customExercisePlanModel.imageFile;
      });
      for (int i = 0;
          i < int.parse(provider.customExercisePlanModel.duration);
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

  Future<void> _showDialog(
      String title, String message, Function() onpress) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
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
                onPressed: onpress,
              ),
            ],
          ),
        );
      },
    );
  }

  int _count = 1;
  void _addNewSetRow() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int initialIndex;
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double margin = height * 0.02;
    var orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? titleAppBar(context: context, title: "Custom Plan")
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        body: Padding(
          padding: Responsive1.isDesktop(context)
              ? const EdgeInsets.all(15.0)
              : const EdgeInsets.all(8.0),
          child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
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
                                ImagePath.runTab,
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
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      DialogWithInputFieldWidget((text) {
                                    setState(() {
                                      titleController.text = text;
                                    });
                                  }, titleController.text, "Name"),
                                );
                              },
                              child: Icon(
                                FontAwesomeIcons.edit,
                                size: 14,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: MySize.size300,
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: titleController,
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    DialogWithInputFieldWidget((text) {
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
                    height: orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.height * 0.09
                        : MediaQuery.of(context).size.height * 0.06,
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
                leftRightheading(left: "Set", right: "Reps"),

                SizedBox(height: MySize.size10),
                if (widget.activeCode == 1)
                  exercises.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: exercises.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (int.parse(exercises[index].day) == dayNumber) {
                              return gridSectionforAddFood(
                                  exercises[index], index);
                            } else {
                              return Container();
                            }
                          },
                        )
                      : Container(),

                // new Container(
                //   height: 40.0,
                //   child: new ListView(
                //     children: _contatos,
                //     scrollDirection: Axis.vertical,
                //   ),
                // ),
                InkWell(
                    onTap: () {
                      final tempProvider =
                          Provider.of<CustomExercisePlanProvider>(context,
                              listen: false);
                      final provider =
                          Provider.of<UserDataProvider>(context, listen: false);

                      CustomExerciseProviderModel tempModel =
                          new CustomExerciseProviderModel(
                              titleController.text,
                              days.length.toString(),
                              selectedImage,
                              exercises,
                              sets);
                      provider.setCustomPlanStatusCode(1);
                      tempProvider.setTempCustomDietPlanData(tempModel);
                      tempProvider.setSelectSet(setController.text);
                      tempProvider.setSelectedDay(dayNumber);
                      Responsive1.isMobile(context)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectExercisePlan(true))).then((value) {
                              //setState(() {
                              //_stepIndex += 1;
                              //});
                            })
                          : showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 200,
                                          right: 200,
                                          bottom: 50,
                                          top: 50),
                                      child: SelectExercisePlan(true)))
                              .then((value) {
                              //setState(() {
                              //_stepIndex += 1;
                              //});
                            });
                    },
                    child: //_stepIndex == 2
                        Container(
                      height: 90,
                      width: 60,
                      margin: EdgeInsets.fromLTRB(
                          10, 0, MediaQuery.of(context).size.width * 0.8, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(ImagePath.foodAdd),
                              fit: BoxFit.cover)),
                    )
                    //: Container(),
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySize.size42),
                  child: Divider(),
                ),
                /*GestureDetector(
                  onTap: () {
                    _addNewSetRow();
                  },
                  child: ;p,lPadding(
                    padding: EdgeInsets.only(left: MySize.size20),
                    child: DDText(title: "Add Set", color: Color(0xff4885ED)),
                  ),
                ),*/
                SizedBox(
                  height: MySize.size50,
                ),
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
                        if (setController.text == "") {
                          _showDialog("No Set Name", "Please a set name", () {
                            Navigator.pop(context);
                          });
                          //DDToast().showToast("No Image", "Please upload an image", true);
                        } else if (exercises.length == 0) {
                          _showDialog("No exercises",
                              "Please add at least one exercise", () {
                            Navigator.pop(context);
                          });
                          //DDToast().showToast("No meal", "Please add atleast one meal", true);
                        } else {
                          setState(() {
                            sets.add(exercises);
                            exercises = [];
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: DDText(
                          title: "Add Set",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                            margin:
                                EdgeInsets.fromLTRB(margin, 10, margin, margin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sets[index][0].setName,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      sets.removeAt(index);
                                    });
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.trashAlt,
                                    size: MySize.size16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            margin:
                                EdgeInsets.fromLTRB(margin, 0, margin, margin),
                            child: ListView.builder(
                              itemCount: sets[index].length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index2) {
                                if (int.parse(sets[index][index2].day) ==
                                    dayNumber) {
                                  return gridSectionforSet(
                                      sets[index][index2], index, index2);
                                } else
                                  return Container();
                              },
                            ))
                      ],
                    );
                  },
                ),
                if (sets.length > 0)
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
                            _showDialog("No Image", "Please upload an image",
                                () {
                              Navigator.pop(context);
                            });
                            //DDToast().showToast("No Image", "Please upload an image", true);
                          } else if (sets.length == 0) {
                            _showDialog(
                                "No sets", "Please add at least one set", () {
                              Navigator.pop(context);
                            });
                            //DDToast().showToast("No meal", "Please add atleast one meal", true);
                          } else {
                            final ProgressDialog pr = ProgressDialog(context);
                            pr.show();
                            upload(selectedImage).then((value) {
                              pr.hide();
                              print(
                                  "dio response data ${value.data['planId']} code ${value.statusCode} message ${value.statusMessage}");
                              addExerciseToCustomPlan(value.data['planId']);
                            }).onError((error, stackTrace) {
                              pr.hide();
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridSectionforAddFood(ExerciseSetModel model, index) {
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$imageBaseUrl${model.filename}"),
                              fit: BoxFit.cover)),
                    ),
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
                            title: model.exerciseDuration,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    calories == null
                        ? DDText(title: "")
                        : DDText(title: "${model.calories} cal"),
                    InkWell(
                      onTap: () {
                        setState(() {
                          exercises.removeAt(index);
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.trashAlt,
                        size: MySize.size16,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
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

  Widget gridSectionforSet(ExerciseSetModel model, index, index2) {
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$imageBaseUrl${model.filename}"),
                              fit: BoxFit.cover)),
                    ),
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
                            title: model.exerciseDuration,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    calories == null
                        ? DDText(title: "")
                        : DDText(title: "${model.calories} cal"),
                    InkWell(
                      onTap: () {
                        setState(() {
                          sets[index].removeAt(index2);
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.trashAlt,
                        size: MySize.size16,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
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

  Widget leftRightheading({left, right}) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: TextFormField(
              controller: setController,
              style: GoogleFonts.openSans(
                  fontSize: MySize.size15, color: Colors.black),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: left,
                hintStyle: GoogleFonts.openSans(
                    fontSize: MySize.size15, color: Colors.black),
              ),
              onChanged: (value) {
                /*
                if (value.isNotEmpty) {
                  setState(() {
                    if (_stepIndex != 2) _stepIndex += 1;
                  });
                } else
                  setState() {
                    if (_stepIndex != 0) _stepIndex -= 1;
                  }
                  */
              },
            ),
          ),
          Expanded(child: Container()),
          Expanded(
            child: TextFormField(
              controller: repsController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.openSans(
                  fontSize: MySize.size15, color: Colors.black),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: right,
                hintStyle: GoogleFonts.openSans(
                    fontSize: MySize.size15, color: Colors.black),
              ),
              onChanged: (value) {
                /*
                if (value.isNotEmpty) {
                  setState(() {
                    if (_stepIndex != 2) _stepIndex += 1;
                  });
                } else
                  setState() {
                    if (_stepIndex != 0) _stepIndex -= 1;
                  }
                  */
              },
            ),
          ),
        ],
      ),
    );
  }
}
