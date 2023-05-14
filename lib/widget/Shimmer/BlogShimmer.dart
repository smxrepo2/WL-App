import 'package:flutter/material.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
class BlogShimmer extends StatelessWidget {
  const BlogShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MySize.size6,
          bottom: MySize.size30,
          right: MySize.size14),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, i) {
              return Card(
                margin: EdgeInsets.only(
                  left: MySize.size10,
                  top: MySize.size5,
                  bottom: MySize.size5,
                ),
                elevation: 0,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[100],
                                spreadRadius: 1,
                                blurRadius: 0.2)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MySize.size8,
                                      // bottom: MySize.size8,
                                      left: MySize.size8,
                                      right: MySize.size28),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MySize.size8),
                                        child: DDText(
                                          line: 3,
                                          title: 'How to cook brown rice',
                                          weight: FontWeight.w500,
                                          center: null,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                              height: MySize.size100,
                              width:
                              MediaQuery.of(context).size.width / 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}