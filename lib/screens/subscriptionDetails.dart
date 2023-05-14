import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/subscriptionCancelled.dart';

class SubscriptionDetails extends StatefulWidget {
  const SubscriptionDetails({Key key}) : super(key: key);

  @override
  State<SubscriptionDetails> createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription Details',
                style: GoogleFonts.openSans(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Plan',
                          style: GoogleFonts.openSans(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '\$ 190.00',
                          style: GoogleFonts.openSans(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Want to change?',
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff940000))),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                      color: Colors.grey.withOpacity(
                    0.5,
                  )),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Plan',
                      style: GoogleFonts.openSans(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Plan Duration',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('1 year',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Amount',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('\$ 190.00',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Charge Date',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('Mar 20, 2023',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Your Payment Method',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: GoogleFonts.openSans(
                                fontSize: 13, color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: const Size(50, 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text('Card Number',
                        style: GoogleFonts.openSans(fontSize: 16.8)),
                    Text('**** **** **** 1234',
                        style: GoogleFonts.openSans(fontSize: 17)),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Change my plan',
                          style: GoogleFonts.openSans(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF573D),
                          fixedSize: const Size(160, 42.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                        child: Text(
                      'Cancel?',
                      style: GoogleFonts.openSans(
                        fontSize: 16.8,
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                      color: Colors.grey.withOpacity(
                    0.5,
                  )),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Status',
                      style: GoogleFonts.openSans(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Plan',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('Free trial',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Start Date',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('March 2, 2023',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Charge Date',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('Mar 20, 2023',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Delete my account?',
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'If you want to delete your account, you have to first cancel your subscription',
                  style: GoogleFonts.openSans(
                      fontSize: 16, color: Colors.black.withOpacity(0.66)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    deleteAccountDialog(context);
                  },
                  child: Text(
                    'Delete my account',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: const Color(0xffFF573D),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(175, 42.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    completionDialog(context);
                  },
                  child: Text(
                    'Export my data',
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF573D),
                    fixedSize: const Size(160, 42.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Premium Bundle',
                style: GoogleFonts.openSans(
                    fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                      color: Colors.grey.withOpacity(
                    0.5,
                  )),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'It gives you access to custom meals and workout guides.',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Plan Duration',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('1 year',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Amount',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('\$ 190.00',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Charge Date',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('Mar 20, 2023',
                            style: GoogleFonts.openSans(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      endIndent: 50,
                      indent: 50,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Text(
                                      'We\'re are cancelling your subscription.\nPlease do not click on anything or close the app.',
                                      style: GoogleFonts.openSans(fontSize: 26),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )),
                    );
                    // wait for 3 seconds
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionCancelled(),
                        ),
                      );
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Cancel Premium Bundle',
                      style: GoogleFonts.openSans(
                          fontSize: 17, color: Colors.black),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                      color: Colors.grey.withOpacity(
                    0.5,
                  )),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help',
                      style: GoogleFonts.openSans(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.close, color: Colors.red, size: 17.5),
                        ),
                        const SizedBox(width: 10),
                        Text('How do I request a refund?',
                            style: GoogleFonts.openSans(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.close, color: Colors.red, size: 17.5),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('I have other questions about my account',
                              style: GoogleFonts.openSans(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.close, color: Colors.red, size: 17.5),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('I have other questions about my account',
                              style: GoogleFonts.openSans(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> completionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/chat_ic.png',
                  height: 100,
                ),
                const SizedBox(height: 40),
                Text(
                  'John, your program is ready!',
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Your goad for today - ',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Run 5km',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ])),
                const SizedBox(height: 20),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Tomorrow - ',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Run 5km',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ])),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    feedbackDialog(context);
                  },
                  child: Text(
                    'Start',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF573D),
                    fixedSize: const Size(160, 42.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> feedbackDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'Got a sec to help us improve?',
              style: GoogleFonts.openSans(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'We\'d love to hear your feedback on your experience with us.',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 4,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 7.5,
                    ),
                  ),
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 10,
                    divisions: 5,
                    thumbColor: Colors.blueAccent,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text('Not at all',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      const Spacer(),
                      Text('Very',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Skip',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  Future<dynamic> deleteAccountDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Account Deletion',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please confirm that you want to delete your account',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'If you delete your account, you will lose all your data',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.openSans(
                          fontSize: 16, color: const Color(0xffFF573D)),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      accountDeletedDialog(context);
                    },
                    child: Text(
                      'Delete',
                      style: GoogleFonts.openSans(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF573D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> accountDeletedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Account Deleted!',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your account has been deleted',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'We are sorry to see you go',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.openSans(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF573D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
