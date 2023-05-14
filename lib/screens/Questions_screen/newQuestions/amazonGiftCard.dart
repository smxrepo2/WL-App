import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/work.dart';

class AmazonGiftCard extends StatefulWidget {
  const AmazonGiftCard({Key key}) : super(key: key);

  @override
  State<AmazonGiftCard> createState() => _AmazonGiftCardState();
}

class _AmazonGiftCardState extends State<AmazonGiftCard> {
  String _selected = '';
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
              'Amazon Gift Card',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              '"Would you like to gift 3 free weeks of WeightLoser to a friend or family member?\n\nBe a part of the 20% who can benefit from faster weight loss, and you\'ll get a \$30 Amazon gift card when they sign up!',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ['Yes!', 'No!']
                  .map((e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected = e;
                          });
                        },
                        child: Container(
                          width: 115,
                          height: 115,
                          decoration: BoxDecoration(
                            color: _selected == e
                                ? const Color(0xffFF573D)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: _selected == e
                                  ? const Color(0xffFF573D)
                                  : Colors.grey[400],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              e,
                              style: GoogleFonts.openSans(
                                color: _selected == e
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Work(),
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
