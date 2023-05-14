import 'package:flutter/material.dart';

NoInternetDialogue() {
  return Container(
    color: Colors.red.shade200,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded),
          Text("No Internet Connection"),
        ],
      ),
    ),
  );
}
