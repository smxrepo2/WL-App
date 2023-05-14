/*i
mport 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/auth/authenticate/provider/authprovider.dart';
import 'package:weight_loser/screens/auth/methods.dart';
import 'package:weight_loser/screens/auth/signup.dart';

import '../constants/payments.dart';

final stripeConfiguration = new StripePaymentConfigurations();

class PaymentService {
  static Future<void> startPaymentCharge(PaymentMethod paymentMethod,
      String amount, String currency, context, SignUpBody signUpBody) async {
    var provider = getit<authModeprovider>();
    Map<String, String> headers = {
      'Authorization': 'Bearer ${stripeConfiguration.secretKey}',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    //try {
    Map<String, dynamic> body = {
      'amount': amount + "00",
      'currency': currency,
      'payment_method_types[]': 'card'
    };
    String paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
                child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            )));
    var response =
        await http.post(Uri.parse(paymentApiUrl), body: body, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);
      PaymentIntent paymentIntent = PaymentIntent(
          paymentMethodId: paymentMethod.id,
          clientSecret: data['client_secret']);
      var intentData = await StripePayment.confirmPaymentIntent(paymentIntent);

      print(intentData);
      print(intentData.paymentMethodId);
      print(intentData.paymentIntentId);
      print(intentData.status);
      if (intentData.status == "succeeded") {
        // Payment Completed
        signUpBody.customerPackages.amount = 10;
        signUpBody.customerPackages.status = "paid";
        signUpBody.customerPackages.duration = 1;
        provider.getData()
            ? signUpOtherUser(signUpBody, context)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpScreen(
                          signUpBody: signUpBody,
                        )));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Payment Success"),
          backgroundColor: Colors.green,
        ));
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong")));
      }
    } else {
      final data = jsonDecode(response.body);
      Navigator.pop(context);
      print(data['error'].toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }

    //} catch (err) {
    //print('err charging user: ${err.toString()}');
    //Navigator.pop(context);
    //ScaffoldMessenger.of(context)
    //  .showSnackBar(SnackBar(content: Text("Something went wrong")));
    //}
    //return null;
  }

  static Future<void> startPayment(context, ammount, signUpBody) async {
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod =
        await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
            .catchError((error) {
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    });
    if (paymentMethod != null)
      startPaymentCharge(
          paymentMethod, ammount.toString(), "usd", context, signUpBody);
  }
}
*/