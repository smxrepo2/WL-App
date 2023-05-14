import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/Service/other_api.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/dialog.dart';

class UnitSetting extends StatefulWidget {
  const UnitSetting({Key key}) : super(key: key);

  @override
  State<UnitSetting> createState() => _UnitSettingState();
}

class _UnitSettingState extends State<UnitSetting> {
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController distance = TextEditingController();
  TextEditingController liquid = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      'Unit & Measures',
                      style: GoogleFonts.montserrat(
                          fontWeight: regular,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: Color(0xFFF8F8FA),
              thickness: 4.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: SvgPicture.asset(
                      'assets/svg_icons/weight_svg.svg',
                      color: primaryColor,
                      height: 30,
                      width: 35,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weight",
                                style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF23233C)),
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AnimatedToggle(
                      values: ['Kg', 'Lb'],
                      onToggleCallback: (value) {
                        setState(() {
                          if (value == 0) {
                            updateWeightUnit("Kg");
                          } else {
                            updateWeightUnit("Lb");
                          }
                          // _toggleValue = value;
                        });
                      },
                      buttonColor: primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      textColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: Color(0xFFF8F8FA),
              thickness: 4.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: SvgPicture.asset(
                      'assets/svg_icons/height_svg.svg',
                      color: primaryColor,
                      height: 30,
                      width: 35,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Height",
                                style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF23233C)),
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AnimatedToggle(
                      values: ['Ft/In', 'cm'],
                      onToggleCallback: (value) {
                        setState(() {
                          if (value == 0) {
                            print("Ft/In");
                            updateHeightUnit("Ft/InKg");
                          } else {
                            updateHeightUnit("cm");
                          }

                          // _toggleValue = value;
                        });
                      },
                      buttonColor: primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      textColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: Color(0xFFF8F8FA),
              thickness: 4.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: SvgPicture.asset(
                      'assets/svg_icons/distance_svg.svg',
                      color: primaryColor,
                      height: 30,
                      width: 35,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Distance",
                                style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF23233C)),
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AnimatedToggle(
                      values: ['Km', 'milles'],
                      onToggleCallback: (value) {
                        setState(() {
                          if (value == 0) {
                            print("Kg");
                            updateDistanceUnit("Km");
                          } else {
                            updateDistanceUnit("milles");
                          }

                          // _toggleValue = value;
                        });
                      },
                      buttonColor: primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      textColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: Color(0xFFF8F8FA),
              thickness: 4.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: SvgPicture.asset(
                      'assets/svg_icons/liquidvolume_svg.svg',
                      color: primaryColor,
                      height: 30,
                      width: 35,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Liquid Volume",
                                style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF23233C)),
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AnimatedToggle(
                      values: ['ml', 'fl oz'],
                      onToggleCallback: (value) {
                        setState(() {
                          if (value == 0) {
                            print("ml");
                            updateLiquidUnit("ml");
                          } else {
                            updateLiquidUnit("fl oz");
                          }

                          // _toggleValue = value;
                        });
                      },
                      buttonColor: primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      textColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: Color(0xFFF8F8FA),
              thickness: 4.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    @required this.values,
    @required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.landscape ? 230 : 135,
      height: Get.width * 0.10,
      //margin: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              var index = 0;
              if (!initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
              print(index);
            },
            child: Container(
              width: Get.width * 0.5,
              height: Get.width * 0.15,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: orientation == Orientation.landscape
                            ? 14
                            : Get.width * 0.040,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
                initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: Get.width * 0.17,
              height: Get.width * 0.15,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.1),
                ),
              ),
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: Get.width * 0.040,
                  color: widget.textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
