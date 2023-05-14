import 'package:flutter/material.dart';

class NoNetwork extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No internet Connection"),
          SizedBox(height: 10,),
          InkWell(

            child: Container(
              height: 40,
              alignment: Alignment.center,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text("RETRY",style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
