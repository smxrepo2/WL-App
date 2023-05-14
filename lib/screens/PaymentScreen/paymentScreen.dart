/*
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:weight_loser/Service/paymentService.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HNI8SKlmDWRJQzORsSow0WELYKoD5eaXR1HSNEEXu9YzpBrQcbMJd2FVAmUjenzAMGcmblmmIGBVD8V1SE7bRXr00JdW2vIHf",
        merchantId: "asdjhjk21kjh",
        androidPayMode: 'test'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Container(
        child: Center(
            child: TextButton(
                onPressed: () {
                  //PaymentService.startPayment(context, "10");
                },
                child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.blueGrey,
                    child: Text('Pay')))),
      ),
    );
  }
}
*/