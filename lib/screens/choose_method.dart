import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/payments.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/auth/authenticate/provider/authprovider.dart';

import 'PaymentScreen/payment_controller.dart';

class ChooseMethod extends StatefulWidget {
  ChooseMethod({Key key, this.signUpBody}) : super(key: key);
  SignUpBody signUpBody;

  @override
  _ChooseMethodState createState() => _ChooseMethodState();
}

class _ChooseMethodState extends State<ChooseMethod> {
  SharedPreferences prefs;
  final stripeConfiguration = StripePaymentConfigurations();
  final PaymentController controller = Get.put(PaymentController());
  bool googleFBsignup;
  @override
  void initState() {
    super.initState();
    var provider = getit<AuthModeprovider>();
    setState(() {
      googleFBsignup = provider.getData();
    }); /*
    StripePayment.setOptions(StripeOptions(
        publishableKey: stripeConfiguration.publishKey,
        merchantId: stripeConfiguration.merchantId,
        androidPayMode: stripeConfiguration.paymentMode));*/
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
  }

  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  void showNonce(var nonce) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            const SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            const SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            /*
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child: GestureDetector(
                onTap: () {
                  /*
                  var user = FirebaseAuth.instance;
                  if (user.currentUser != null) {
                    widget.signUpBody.customerPackages.status = 'paid';
                    mobile
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarNew(0)),
                            (route) => false)
                        : Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SideMenu()),
                            (route) => false);
                  } else {
                    */
                  googleFBsignup
                      ? signUpOtherUser(widget.signUpBody, context)
                      : mobile
                          ? Get.to(
                              () => SignUpScreen(signUpBody: widget.signUpBody))
                          : Get.to(() => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SignUpScreen(
                                        signUpBody: widget.signUpBody)),
                              ));
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(signUpBody: widget.signUpBody,)));
                  //}
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Center(
                    child: Image.asset(
                      'assets/images/gPay.png',
                      width: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                ),
              ),
            ),
            */
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child: GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                width: MediaQuery.of(context).size.width,
                height: 50,
                paymentItems: _paymentItems,
                // style: GooglePayButtonStyle.black,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (data) {
                  print(data);
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            /*
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child: GestureDetector(
                onTap: () async {
                  var request = BraintreeDropInRequest(
                    tokenizationKey: 'sandbox_4x5c5xm8_v4z25vjf64w44yft',
                    collectDeviceData: true,
                    googlePaymentRequest: BraintreeGooglePaymentRequest(
                      totalPrice: '4.20',
                      currencyCode: 'USD',
                      billingAddressRequired: false,
                    ),
                    paypalRequest: BraintreePayPalRequest(
                      amount: '4.20',
                      displayName: 'Example company',
                    ),
                    cardEnabled: true,
                  );
                  final result = await BraintreeDropIn.start(request);
                  if (result != null) {
                    showNonce(result.paymentMethodNonce);
                  }
                  /*
                  var user = FirebaseAuth.instance;
                  if (user.currentUser != null) {
                    widget.signUpBody.customerPackages.status = 'paid';
                    mobile
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarNew(0)),
                            (route) => false)
                        : Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SideMenu()),
                            (route) => false);
                  } else {
                    */
                  googleFBsignup
                      ? signUpOtherUser(widget.signUpBody, context)
                      : mobile
                          ? Get.to(
                              () => SignUpScreen(signUpBody: widget.signUpBody))
                          : Get.to(() => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SignUpScreen(
                                        signUpBody: widget.signUpBody)),
                              ));
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(signUpBody: widget.signUpBody,)));
                  //}
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Center(
                    child: Image.asset(
                      'assets/images/paypal.jpeg',
                      width: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            */
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child: GestureDetector(
                onTap: () {
                  // this is comment by mudasar 
                  // controller.makePayment(
                  //     amount: "10",
                  //     currency: "USD",
                  //     signUpBody: widget.signUpBody,
                  //     context: context);
                  //PaymentService.startPayment(context, "10", widget.signUpBody);
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>CardInformation(signUpBody: widget.signUpBody,)));
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/cards.png',
                        width: MediaQuery.of(context).size.height * 0.25,
                      ),
                      const Text(
                        'Add Card',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*
            InkWell(
              onTap: () {
                googleFBsignup
                    ? signUpOtherUser(widget.signUpBody, context)
                    : Responsive1.isMobile(context)
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                                  signUpBody: widget.signUpBody,
                                )))
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 430,
                                      right: 430,
                                      top: 30,
                                      bottom: 30),
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SignUpScreen(
                                          signUpBody: widget.signUpBody)),
                                )));
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
            */
            const Expanded(child: SizedBox()),
            const Text(
              'Terms and Conditions',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.002,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
                Text(
                  'elit.Aenean commodoligula eget dolor. Aenean massa.',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
                Text(
                  'elit.Aenean commodoligula eget dolor. ',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ],
        ),
      ),
    );
  }
}
