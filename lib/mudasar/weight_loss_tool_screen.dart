import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/transform_your_self_screen.dart';

class WeightLoseToolScreen extends StatefulWidget {
  const WeightLoseToolScreen({Key key}) : super(key: key);

  @override
  State<WeightLoseToolScreen> createState() => _Get_Started_ScreenState();
}

class _Get_Started_ScreenState extends State<WeightLoseToolScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: width,
              padding: EdgeInsets.all(height * .03),
              color: const Color.fromRGBO(227, 194, 247, 1),
              child: Image.asset('assets/images/weight_lose_tools_image.png'),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              children: [
                const FittedBox(
                    child: Text(
                  'Your Mind is Your Most',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black54),
                )),
                SizedBox(
                  height: height * 0.01,
                ),
                const FittedBox(
                    child: Text(
                  'Powerfull Weight Loss Tool',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black54),
                )),
                SizedBox(
                  height: height * 0.04,
                ),
                const FittedBox(
                    child: Text(
                  "Achieving your ideal weight isn't just about",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                )),
                SizedBox(
                  height: height * 0.02,
                ),
                const FittedBox(
                    child: Text(
                  "what you eat - it's also about how you think",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                )),
                SizedBox(
                  height: height * 0.12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TransFormYourSelfScreen(),));
                  
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.6,
                    color: Colors.black,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'Getting Started',
                          style: TextStyle(
                              fontSize: height * 0.024,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.09,
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.02,
            width: width,
            color: const Color.fromRGBO(244, 194, 171, 1),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
  
}
