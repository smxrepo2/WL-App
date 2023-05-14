import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uiblock/uiblock.dart';

import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/screens/SettingScreen/setting_screen.dart';
import 'package:weight_loser/screens/story/methods.dart';
import 'package:weight_loser/screens/story/userStory.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../../widget/dialog.dart';
import '../profile/SettingsScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileVM _profileVM;
  Future<DashboardModel> _future;
  DateTime selectedDate = DateTime.now();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = fetchDashboardData();
  }

  void Refresh() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      UIBlock.block(context);
      setState(() {
        selectedDate = picked;
        //print(selectedDate);
        updateDob(DateFormat('yyyy-MM-dd').format(selectedDate)).then((value) {
          UIBlock.unblock(context);
          if (value.statusCode == 200) {
            Refresh();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<DashboardModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _profileVM = snapshot.data.profileVM;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Center(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '$imageBaseUrl${_profileVM.fileName}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.elliptical(9999.0, 9999.0)),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff707070)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_profileVM.name}',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 13,
                        color: Color(0xff080808),
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: false,
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.black,
                      indent: 110,
                      endIndent: 110,
                      thickness: 1.25,
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: Color(0xff080808),
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: false,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17.5, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0x54ffffff),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 0.5, color: const Color(0x54b9b6b6)),
                      ),
                      child: Column(
                        children: [
                          ProfileTile(
                              title: '${_profileVM.name}',
                              icon: Icons.person,
                              type: "person"),
                          ProfileTile(
                              title: '${_profileVM.email}',
                              icon: Icons.mail,
                              type: "mail"),
                          ProfileTile(
                              title:
                                  '${_profileVM.userPassword ?? "Not Applicable"}',
                              icon: Icons.lock,
                              type: "password"),
                          ProfileTile(
                              title:
                                  '${_profileVM.dOB.substring(0, 10) ?? "-"}',
                              icon: Icons.calendar_month,
                              type: "dob"),
                          ProfileTile(
                              title: 'Payments',
                              icon: Icons.payment,
                              type: "payment"),
                          ProfileTile(
                              title: 'Settings',
                              icon: Icons.settings,
                              type: "settings"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MyStory(
                                      profileImage: _profileVM.fileName,
                                      username: _profileVM.userName,
                                    )));
                      },
                      child: const Text(
                        'Story',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 20,
                          color: Color(0xff080808),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget ProfileTile({@required title, @required icon, @required type}) {
    return Container(
      padding: const EdgeInsets.all(1),
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0e000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (type == "dob")
            _selectDate(context);
          else if (type == "person") {
            showDialog(
                context: context,
                builder: (_) {
                  return EditText(
                    title: "Name",
                    controller: nameController,
                    onpress: () {
                      UIBlock.block(context);
                      updateName(nameController.text).then((value) {
                        UIBlock.unblock(context);
                        Navigator.pop(context);
                        if (value.statusCode == 200) {
                          Refresh();
                        }
                      });
                    },
                  );
                });
          } else if (type == "password") {
            if (_profileVM.userPassword != null) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return EditText(
                      title: "Password",
                      controller: passwordController,
                      onpress: () {
                        UIBlock.block(context);
                        updatePassword(passwordController.text).then((value) {
                          UIBlock.unblock(context);
                          Navigator.pop(context);
                          if (value.statusCode == 200) {
                            Refresh();
                          }
                        });
                      },
                    );
                  });
            }
          } else if (type == "settings") {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SettingScreen(navigateToStory: true)));
          }
        },
        style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 35),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xff4061E6),
                size: 25,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 13,
                    color: Color(0xff707070),
                  ),
                  //softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
