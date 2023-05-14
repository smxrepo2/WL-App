/*
* File : Full Image
* Version : 1.0.0
* */

import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class FullImageScreen extends StatefulWidget {
  final String imagePath, imageTag;
  final int backgroundOpacity;

  const FullImageScreen(
      {Key key, this.imagePath, this.imageTag, this.backgroundOpacity})
      : super(key: key);

  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(
          widget.backgroundOpacity == null ? 220 : widget.backgroundOpacity),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.imageTag,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: MySize.size18,
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: MySize.size40,
            left: MySize.size10,
            child: IconButton(
              splashRadius: 1,
              icon: Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
