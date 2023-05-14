import 'package:flutter/material.dart';

textContainer({
  String text1,
  String text2,
}) {
  return Card(
    elevation: 0.5,
    // shape: RoundedRectangleBorder(
    //   side: BorderSide(
    //     color: Colors.grey.withOpacity(0.05),
    //     width: 5,
    //   ),
    // ),
    child: Container(
      width: 140,
      height: 120,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            text1,
            style: const TextStyle(
                fontFamily: 'Segoe UI',
                color: Color(0xffF05353),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            text2,
            style: const TextStyle(
                fontFamily: 'Segoe UI',
                color: Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
