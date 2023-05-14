import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';

class WorkOutShimmer extends StatelessWidget {
  const WorkOutShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 200,
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 200,
              height: MediaQuery.of(context).size.height * 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Running 8 min mile',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      "10 values",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width: MySize.size4,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: const Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    const Text(
                                      "5 sets",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: Container()),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, right: MySize.size10),
                                child: Row(
                                  children: const [
                                    Text(
                                      '0.0',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "cal",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
