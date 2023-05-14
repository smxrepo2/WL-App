import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';

import 'components.dart';


class WaterSetting extends StatefulWidget {
  const WaterSetting({Key key}) : super(key: key);

  @override
  _WaterSettingState createState() => _WaterSettingState();
}

class _WaterSettingState extends State<WaterSetting> {
  bool reminderValue = false;
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
                      'Water',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            listTileComponent(
                context: context,
                title: 'No. of glasses drink in a day',
                subtitle: '8+',
                image: 'assets/svg_icons/waterglass_svg.svg'
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                    height: 30,
                    width: 35,),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Reminder',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CupertinoSwitch(
                    activeColor: Colors.blue,
                    value: reminderValue,
                    onChanged: (v) => setState(() => reminderValue = v),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
