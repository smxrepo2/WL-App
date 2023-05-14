import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/subscriptionDetails.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({Key key}) : super(key: key);

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  List<Map<String, dynamic>> cards = [
    {
      'name': 'Credit Card',
      'image': 'assets/icons/mastercard.png',
    },
    {
      'name': 'Paypal',
      'image': 'assets/icons/pp258.png',
    },
  ];
  int selectedCard = 0;
  bool agreed = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment',
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                ...cards.map((e) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 7.5),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffF9F9F9),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: RadioListTile(
                      value: cards.indexOf(e),
                      groupValue: selectedCard,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        setState(() {
                          selectedCard = value;
                        });
                      },
                      title: Text(e['name'],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      secondary: Image.asset(
                        e['image'],
                        height: 30,
                        width: 50,
                      ),
                      activeColor: Color(0xff3E5492),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                Text(
                  'Payment Information',
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Card Number',
                            hintText: '1234 5678 9012 3456',
                            labelStyle: GoogleFonts.openSans(
                              color: Colors.black.withOpacity(0.58),
                              fontSize: 16.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter card number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name on card',
                            hintText: 'John Doe',
                            labelStyle: GoogleFonts.openSans(
                              color: Colors.black.withOpacity(0.58),
                              fontSize: 16.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter card holder name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Exp. Date',
                                  hintText: 'MM/YY',
                                  labelStyle: GoogleFonts.openSans(
                                    color: Colors.black.withOpacity(0.58),
                                    fontSize: 16.8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter expiry date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Security Code',
                                  hintText: '123',
                                  labelStyle: GoogleFonts.openSans(
                                    color: Colors.black.withOpacity(0.58),
                                    fontSize: 16.8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter CVV';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Billing Address',
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Address 1',
                          style: GoogleFonts.openSans(
                            color: Colors.black.withOpacity(0.58),
                            fontSize: 16.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Street Address',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Address 2 (Optional)',
                          style: GoogleFonts.openSans(
                            color: Colors.black.withOpacity(0.58),
                            fontSize: 16.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Street Address',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SelectState(
                          style: GoogleFonts.openSans(
                            color: Colors.black.withOpacity(0.58),
                            fontSize: 16.8,
                            fontWeight: FontWeight.w500,
                          ),
                          onCountryChanged: (value) {
                            setState(() {});
                          },
                          onStateChanged: (value) {
                            setState(() {});
                          },
                          onCityChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Zip Code',
                          style: GoogleFonts.openSans(
                            color: Colors.black.withOpacity(0.58),
                            fontSize: 16.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Zip Code',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter zip code';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                          color: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('7 day free trial, cancel anytime',
                                style: GoogleFonts.openSans(fontSize: 10)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                              activeColor: const Color(0xffFF573D),
                              value: agreed,
                              onChanged: (value) {
                                setState(() {
                                  agreed = value;
                                });
                              }),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              'I agree to the terms and conditions of 7- day trial and autorenewing subscription',
                              style: GoogleFonts.openSans(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SubscriptionDetails()),
                              );
                            }
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF573D),
                            fixedSize: const Size(145, 47),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
