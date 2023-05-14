import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';

class DietWidget extends StatefulWidget {
  DietWidget();

  @override
  _DietWidgetState createState() => _DietWidgetState();
}

class _DietWidgetState extends State<DietWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            //contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              height: Get.height * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32.0),
                        topLeft: Radius.circular(32.0)),
                    child: Image.asset(
                      'assets/images/appleee.png',
                      fit: BoxFit.fitWidth,
                      height: Get.height * .17,
                      width: Get.width * .5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: Get.height * .2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'Oats',
                                      style: darkText14Px,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '250 gram',
                                      style: lightText12Px,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '200 kcal',
                                      style: darkText14Px,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'Oats',
                                      style: darkText14Px,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    child: Text(
                                      '1 cup fat free milk',
                                      style: lightText12Px,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    child: Text(
                                      '1 cup fat free milk',
                                      style: lightText12Px,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    child: Text(
                                      '1 cup fat free milk',
                                      style: lightText12Px,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '',
                                      style: darkText14Px,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            )),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(17.0),
                child: Image.asset(
                  'assets/images/appleee.png',
                  width: 80.0,
                  height: 110.0,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Oats',
                            style: darkText14Px,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '250 gram',
                            style: lightText12Px,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '200 kcal',
                            style: darkText14Px,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: Icon(
                                    Icons.add,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
