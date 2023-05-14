import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';

import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/widget/dialog.dart';

import '../Questions_screen/newQuestions/constant.dart';
import 'components.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key key}) : super(key: key);

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  TextEditingController nameController = TextEditingController();
  final passwordController = TextEditingController();
  Future<DashboardModel> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    print("tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Profile',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            FutureBuilder<DashboardModel>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  var p = Provider.of<UserDataProvider>(context, listen: false);
                  p.updateUserName(snapshot.data.profileVM.name);
                  p.updateUserEmail(snapshot.data.profileVM.email);
                  p.updateUserPassword(snapshot.data.profileVM.userPassword);
                  return Consumer<UserDataProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      return Column(
                        children: [
                          listTileComponent(
                              context: context,
                              title: 'Name',
                              subtitle: value.userName,
                              image: 'assets/svg_icons/name_svg.svg',
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(0),
                                        content: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  controller: nameController,
                                                  minLines: 1,
                                                  maxLines: 1,
                                                  cursorColor: Colors.grey,
                                                  decoration: InputDecoration(
                                                    hintText: snapshot
                                                        .data.profileVM.name,
                                                    isDense: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: .3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: .3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                              if (nameController.text
                                                  .contains(RegExp(r'[0-9]'))) {
                                                showToast(
                                                    text:
                                                        'Name should contain only alphabet',
                                                    context: context);
                                              } else if (nameController
                                                  .text.isEmpty) {
                                                showToast(
                                                    text: 'Name Can\'t empty',
                                                    context: context);
                                              } else {
                                                //print(nameController.text);
                                                value.updateUserName(
                                                    nameController.text);
                                                print(value.userName);
                                                UIBlock.block(context);
                                                updateName(nameController.text)
                                                    .then((value) {
                                                  UIBlock.unblock(context);
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _data =
                                                        fetchDashboardData();
                                                  });
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.09,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: SvgPicture.asset(
                                    'assets/svg_icons/email_svg.svg',
                                    color: primaryColor,
                                    height: 30,
                                    width: 35,
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF797A7A)),
                                            ),
                                            Container(
                                              height: 20,
                                              child: Text(
                                                value.userEmail,
                                                style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.09,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: SvgPicture.asset(
                                    'assets/svg_icons/password_svg.svg',
                                    color: primaryColor,
                                    height: 30,
                                    width: 35,
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Password',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF797A7A)),
                                            ),
                                            Container(
                                              height: 20,
                                              child: Text(
                                                value.userPassword != null
                                                    ? '${value.userPassword.replaceAll(RegExp(r"."), "\u2022")}'
                                                    : 'Not Aplicable',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))),
                                GestureDetector(
                                  onTap: () {
                                    if (value.userPassword != null)
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              insetPadding: EdgeInsets.all(0),
                                              content: Container(
                                                height: 70,
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                        controller:
                                                            passwordController,
                                                        minLines: 1,
                                                        maxLines: 1,
                                                        cursorColor:
                                                            Colors.grey,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: value
                                                                      .userPassword !=
                                                                  null
                                                              ? '${value.userPassword.replaceAll(RegExp(r"."), "\u2022")}'
                                                              : 'No Password',
                                                          isDense: true,
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: .3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: .3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Update"),
                                                  onPressed: () {
                                                    if (passwordController
                                                            .text.isEmpty ||
                                                        passwordController
                                                                .text.length <
                                                            6) {
                                                      showToast(
                                                          text:
                                                              'Password should be greater than 6 digit',
                                                          context: context);
                                                    } else {
                                                      value.updateUserPassword(
                                                          passwordController
                                                              .text);
                                                      UIBlock.block(context);
                                                      updatePassword(
                                                              passwordController
                                                                  .text)
                                                          .then((value) {
                                                        UIBlock.unblock(
                                                            context);
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          _data =
                                                              fetchDashboardData();
                                                        });
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                  },
                                  child: SvgPicture.asset(
                                    'assets/svg_icons/pencil_svg.svg',
                                    color: primaryColor,
                                    height: 20,
                                    width: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('unable to load data'),
                  );
                }

                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
