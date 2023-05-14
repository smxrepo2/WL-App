import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:flutter_svg/svg.dart';


Widget listTileComponent(
    {@required String image,
    @required String title,
    @required String subtitle,
    @required Function() oNTap,
    @required BuildContext context}) {
  return GestureDetector(
    onTap: oNTap,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SvgPicture.asset(image,color: primaryColor,
              height: 30,
              width: 35,),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF797A7A)),
                      ),
                      Container(
                        height: 20,
                        child: Text(
                          title == "Password"
                              ? '${subtitle.replaceAll(RegExp(r"."), "\u2022")}'
                              : subtitle,
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset('assets/svg_icons/pencil_svg.svg',
              color: primaryColor,
              height: 20,
              width: 25,),
          )
        ],
      ),
    ),
  );
}

Widget listTileComponentInt(
    {@required String image,
    @required String title,
    @required int subtitle,
    @required Function() oNTap,
    @required BuildContext context}) {
  return GestureDetector(
    onTap: oNTap,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SvgPicture.asset(image,color: primaryColor,
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
                        title,
                        style: GoogleFonts.openSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF797A7A)),
                      ),
                      Text(
                        subtitle.toString(),
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset('assets/svg_icons/pencil_svg.svg',
              color: primaryColor,
              height: 20,
              width: 25,),
          )
        ],
      ),
    ),
  );
}

Widget listTileComponentDouble(
    {@required String image,
    @required String title,
    @required num subtitle,
    @required Function() oNTap,
    @required BuildContext context}) {
  return GestureDetector(
    onTap: oNTap,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset(image),
          ),
          GestureDetector(
            onTap: oNTap,
            child: Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.openSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF797A7A)),
                        ),
                        Text(
                          subtitle.toString(),
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Icon(
              Icons.edit_outlined,
              color: Colors.grey,
            ),
          )
        ],
      ),
    ),
  );
}

Widget rowWithForwardIcon({
  @required String image,
  @required String option,
  @required BuildContext context,
  @required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SvgPicture.asset(image,
            color: primaryColor,
            height: 30,
            width: 35,),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              option,
              style: GoogleFonts.openSans(fontSize: 15, fontWeight: regular),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Image.asset('assets/icons/forwardarrow_icon.png'),
          )
        ],
      ),
    ),
  );
}

Widget reminderTileComponent(
    {@required String image,
    @required String title,
    @required String subtitle,
    @required Function() oNTap,
    @required BuildContext context}) {
  return GestureDetector(
    onTap: oNTap,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SvgPicture.asset(image,color: primaryColor,
            height: 30,
            width: 35,),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF23233C)),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.openSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset('assets/svg_icons/pencil_svg.svg',
              color: primaryColor,
              height: 20,
              width: 25,),
          )
        ],
      ),
    ),
  );
}

Widget rowWithEditIcon({
  @required String image,
  @required String option,
  @required BuildContext context,
  @required Function() onTap,
}) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.09,
    color: Color(0xFFFFFFFF),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SvgPicture.asset(image,color: primaryColor,height: 30,
            width: 35,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            option,
            style: GoogleFonts.openSans(
              fontSize: 15,
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: GestureDetector(
              onTap: onTap, child: SvgPicture.asset('assets/svg_icons/pencil_svg.svg',
            color: primaryColor,
            height: 20,
            width: 25,),),
        )
      ],
    ),
  );
}

Widget questionAnswer(
    {@required String question,
    @required String answer,
    @required Function() onTap,
    @required BuildContext context}) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.09,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question,
                style: GoogleFonts.openSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF797A7A)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.grey,
                    )),
              )
            ],
          ),
          Text(
            answer,
            style: GoogleFonts.openSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget selectWatches({
  @required String name,
  @required String icon,
  @required BuildContext context,
  @required Function() onTap,
  @required String text,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Image.asset(icon),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                name,
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
            Text(
              text,
              style: GoogleFonts.openSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF797A7A)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Image.asset('assets/icons/watch_icon.png'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget switchTileComponent(
    {@required String image,
    @required String title,
    @required bool value,
    @required Function() oNTap,
    @required BuildContext context}) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.09,
    color: Colors.white,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Image.asset(image),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF797A7A)),
                    ),
                  ],
                ))),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 10,
              height: 10,
              child: Switch(
                activeColor: Colors.blue,
                value: value,
                //onChanged: oNTap,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
