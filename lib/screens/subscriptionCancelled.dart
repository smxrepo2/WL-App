import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionCancelled extends StatefulWidget {
  const SubscriptionCancelled({Key key}) : super(key: key);

  @override
  State<SubscriptionCancelled> createState() => _SubscriptionCancelledState();
}

class _SubscriptionCancelledState extends State<SubscriptionCancelled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Text(
              'We\'re sorry to see you go!',
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your subscription has been cancelled. You can always come back and subscribe again.',
              style: GoogleFonts.openSans(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'You will still be able to access the app until your current subscription expires.',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Got it'.toUpperCase(),
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF573D),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('If you have any questions, please contact us at'),
            Text(
              'weightloser@contact.com',
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xffFF573D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
