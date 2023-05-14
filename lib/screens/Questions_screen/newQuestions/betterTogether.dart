import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/amazonGiftCard.dart';

class BetterTogether extends StatefulWidget {
  const BetterTogether({Key key}) : super(key: key);

  @override
  State<BetterTogether> createState() => _BetterTogetherState();
}

class _BetterTogetherState extends State<BetterTogether> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Understanding behavior change',
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'WeightLoser is better together',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              '"People who successfully refer friends and family can lose weight 32% faster during their WeightLoser program"',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD6D6D6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 94,
                      height: 94,
                      child: const CircularProgressIndicator(
                        value: 0.5,
                        strokeWidth: 5,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff8B8282),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Regular users',
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFF573D),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 94,
                      height: 94,
                      child: Stack(
                        children: [
                          const SizedBox(
                            width: 94,
                            height: 94,
                            child: CircularProgressIndicator(
                              value: 0.75,
                              strokeWidth: 5,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff8B8282),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '30%\nfaster\nprogress',
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Users who refer a friend',
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AmazonGiftCard(),
                    ),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.openSans(fontSize: 19),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF573D),
                  fixedSize: const Size(156, 49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
