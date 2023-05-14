import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';

class DieShimmertWidget extends StatefulWidget {

   const DieShimmertWidget({Key key}) : super(key: key);

  @override
  _DieShimmertWidgetState createState() => _DieShimmertWidgetState();
}

class _DieShimmertWidgetState extends State<DieShimmertWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Shimmer.fromColors( baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, childAspectRatio: 280 / 350, crossAxisSpacing: 20, mainAxisSpacing: 20),
              itemCount: 5,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Vegetarian',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black)),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "7 weeks",
                                    style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w300),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
