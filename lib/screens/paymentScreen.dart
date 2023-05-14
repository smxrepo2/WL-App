import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cardDetails.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> amounts = [
    '\$0.2',
    '\$2',
    '\$8',
    '\$20',
  ];

  List<String> sliderAmount = [
    '\$24/year',
    '\$48/year',
    '\$5/mo',
    '\$6/mo',
    '\$7/mo',
    '\$8/mo',
    '\$9/mo',
    '\$10/mo',
    '\$11/mo',
    '\$12/mo',
  ];

  String selectedAmount = '\$8/mo';
  String fairAmount = '';

  bool trial = false;

  List<Map<String, dynamic>> slides = [
    {
      'text':
          'Your satisfaction is our first priority let our app take care of you',
      'image': 'assets/images/healthcare.png',
    },
    {
      'text': 'We use psychology to help you lose weight and keep it off.',
      'image': 'assets/images/potato.png',
    }
  ];

  @override
  void initState() {
    // change page every 5 seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_pageController.page == slides.length - 1) {
          _pageController.jumpToPage(0);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 100),
            Container(
              height: MediaQuery.of(context).size.height * 0.42,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.36,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      itemCount: slides.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.asset(
                              slides[index]['image'],
                              height: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Text(
                                slides[index]['text'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 5, top: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade100,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text('Try WeightLoser for a week',
                        style: GoogleFonts.openSans(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Text('Start your 7 days free trial',
                        style: GoogleFonts.openSans(fontSize: 12)),
                    !trial
                        ? Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    trial = true;
                                  });
                                },
                                child: Text(
                                  'Try for 7 days free',
                                  style: GoogleFonts.openSans(fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF573D),
                                  fixedSize: const Size(247, 49),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'It costs us approximately \$15 to offer  a 7 day free trial. Please pick an amount you think is fair for 7 day trial',
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Choose a fair amount',
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: amounts
                                            .map((e) => InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      fairAmount = e;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: fairAmount == e
                                                          ? const Color(
                                                              0xffFF573D)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: fairAmount == e
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 20),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text: 'Most people pick ',
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\$8',
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ])),
                                      const SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            // dialog with set state
                                            builder: (context) =>
                                                StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  title: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Text(
                                                        'Pay what you think is fair',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  content: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'It help us support those who need to select the lowest trial prices',
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 10),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Text(
                                                          selectedAmount,
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        SliderTheme(
                                                          data:
                                                              const SliderThemeData(
                                                            thumbShape:
                                                                RoundSliderThumbShape(
                                                              enabledThumbRadius:
                                                                  7.5,
                                                            ),
                                                            trackHeight: 1,
                                                          ),
                                                          child: Slider(
                                                            value: sliderAmount
                                                                .indexOf(
                                                                    selectedAmount)
                                                                .toDouble(),
                                                            min: 0,
                                                            max: sliderAmount
                                                                .length
                                                                .toDouble(),
                                                            divisions:
                                                                sliderAmount
                                                                    .length,
                                                            onChanged: (value) {
                                                              setState(
                                                                () {
                                                                  selectedAmount =
                                                                      sliderAmount[
                                                                          value
                                                                              .toInt()];
                                                                },
                                                              );
                                                            },
                                                            thumbColor:
                                                                const Color(
                                                                    0xffFF573D),
                                                            activeColor:
                                                                const Color(
                                                                    0xffFF573D),
                                                            inactiveColor:
                                                                Colors.grey
                                                                    .shade300,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Annualy',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                              Text(
                                                                'Monthly',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 30),
                                                        Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          elevation: 0,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                '7 day free trial, cancel anytime',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                        fontSize:
                                                                            10)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 30),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CardDetailsScreen()));
                                                          },
                                                          child: Text(
                                                            'Continue',
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xffFF573D),
                                                            fixedSize:
                                                                const Size(
                                                                    123, 36),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Choose a custom amount',
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
