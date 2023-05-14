import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/paymentScreen.dart';

class HealthBenefits extends StatefulWidget {
  const HealthBenefits({Key key}) : super(key: key);

  @override
  State<HealthBenefits> createState() => _HealthBenefitsState();
}

class _HealthBenefitsState extends State<HealthBenefits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(
              'Unlock health benefits with just 5%',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Image.asset('assets/images/security.png'),
            ),
            Text(
              'Here, our mission is to help everyone lead healthier lives.\n\nDid you know? losing just 5% of your body weight can reduce your risk for diabetes, high blood pressure and high cholesterol.',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 50),
            Divider(
              color: Colors.grey.shade300,
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
                      builder: (context) => const PaymentScreen(),
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
            const SizedBox(height: 40),
          ],
        ),
      )),
    );
  }
}
