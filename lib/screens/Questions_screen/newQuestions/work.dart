import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/healthBenefits.dart';

class Work extends StatefulWidget {
  const Work({Key key}) : super(key: key);

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Zeek, some employers offer WeightLoser as a part of employee benefit, and your organization may be eligible.\n\nThe following question will help us identify if your employer already covers WeightLoser?',
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 40),
                Text('Where do you work?',
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 20),
                TextField(
                  maxLines: 4,
                  cursorColor: Color(0xffFF573D),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Please specify..',
                    hintStyle: GoogleFonts.openSans(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 2,
                  indent: 75,
                  endIndent: 75,
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HealthBenefits(),
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
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Skip to the new question >>',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
