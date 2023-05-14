import 'package:flutter/material.dart';
import 'package:weight_loser/Component/DDText.dart';

import 'package:weight_loser/CustomWidgets/SizeConfig.dart';

class EditProfile extends StatefulWidget {
  final String name,email;
  const EditProfile({this.email,this.name});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  bool valuefirst = false;

  bool valuesecond = false;
  // ignore: unused_field
  bool _value = false;
  int val = -1;
  String dropvalue = "Pakistan";
  @override
  void initState() {
    // TODO: implement initState
    _controllerEmail.text=widget.email;
    _controllerName.text=widget.name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: DDText(
            title: "Edit Profile",
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(children: [
            SizedBox(
              height: MySize.size30,
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MySize.size100)),
              child: Container(
                child: SizedBox(
                  height: MySize.size100,
                  width: MySize.size100,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      Container(
                        padding: EdgeInsets.all(MySize.size14),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile3.jpg"),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Color(0xFF3BA377),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(MySize.size5),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            // Consumer<UserDataProvider>(builder: (context, login_model, child) {
            //   _controllerName.text = login_model.userData.name;
            myTextField("Name", _controllerName.text, controller: _controllerName),
            // }),
            SizedBox(
              height: MySize.size26,
            ),
            myTextField("Date of Birth", "mm/dd/yyyy"),
            SizedBox(
              height: MySize.size26,
            ),
            // Consumer<UserDataProvider>(builder: (context, login_model, child) {
            //   _controllerEmail.text = login_model.userData.user.email;
            myTextField("Email", _controllerEmail.text,
                controller: _controllerEmail),
            // }),
            SizedBox(
              height: MySize.size26,
            ),
            phoneNumberTextField("Phone Number", "+92", "123 456 789"),
            SizedBox(
              height: MySize.size26,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MySize.size20, bottom: MySize.size10),
                  child: DDText(
                    title: "Gender",
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // Consumer<UserDataProvider>(builder: (context, login_model, child) {
            //   _controllerName.text = login_model.userData.name;
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: MySize.size44,
                    // padding: EdgeInsets.all(2),
                    margin: EdgeInsets.only(
                        left: MySize.size20, right: MySize.size10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: val,
                          onChanged: (int value) {
                            setState(() {
                              val = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        DDText(title: "Male")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MySize.size44,
                    // padding: EdgeInsets.all(2),
                    margin: EdgeInsets.only(
                        left: MySize.size10, right: MySize.size20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])),
                    child: Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: val,
                          onChanged: (int value) {
                            setState(() {
                              val = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        DDText(title: "Female")
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // }),
            SizedBox(
              height: MySize.size26,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MySize.size20,
                    right: MySize.size20,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: MySize.size8),
                        child: DDText(title: "Country"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MySize.size36,
                  margin: EdgeInsets.only(
                      left: MySize.size20, right: MySize.size20),
                  padding:
                      EdgeInsets.only(left: MySize.size3, right: MySize.size3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300])),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    isExpanded: true,
                    value: dropvalue,
                    items: <String>[
                      'Pakistan',
                      'Australia',
                      'Brazil',
                      'Canada',
                      'Denmark'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: DDText(title: value),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      dropvalue = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MySize.size20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff4885ED),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size30))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size10),
                child: DDText(
                  title: "Update",
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget myTextField(title, placeholder, {readonly = false, controller}) {
    return Container(
      margin: EdgeInsets.only(
        left: MySize.size20,
        right: MySize.size20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: MySize.size8),
                child: DDText(
                  title: title,
                  weight: FontWeight.w400,
                ),
              ),
            ],
          ),
          TextField(
            readOnly: readonly,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),

              hintText: placeholder,
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(MySize.size8),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])),
            ),
          )
        ],
      ),
    );
  }
}

Widget phoneNumberTextField(
    title, countryCodePlaceholder, phoneNumberplaceholder) {
  return Container(
    margin: EdgeInsets.only(
      left: MySize.size20,
      right: MySize.size20,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: MySize.size8),
              child: DDText(
                title: title,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(right: MySize.size4),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: countryCodePlaceholder,
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(MySize.size8),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300])),
                    ),
                  )),
            ),
            Expanded(
                flex: 4,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: phoneNumberplaceholder,
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(MySize.size8),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                  ),
                )),
          ],
        )
      ],
    ),
  );
}
