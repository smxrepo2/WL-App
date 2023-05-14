import 'package:flutter/material.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';

import '../../utils/sizeconfig.dart';

class Profileshimmer extends StatelessWidget {
  const Profileshimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
          left: MySize.size16, top: MySize.size20, right: MySize.size20),
      child: Row(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(''),
              ),
              Padding(
                padding: EdgeInsets.only(left: MySize.size6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DDText(
                      title: "",
                      size: MySize.size13,
                    ),
                    DDText(
                      title: "",
                      size: MySize.size11,
                      color: Colors.grey,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(""),
              Padding(
                padding: EdgeInsets.only(bottom: MySize.size14),
                child: Row(
                  children: [
                    DDText(
                      title: "",
                      size: MySize.size13,
                    ),
                    SizedBox(
                      width: MySize.size4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
