import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/constants/payments.dart';

import '../../Provider/UserDataProvider.dart';
import '../../notifications/getit.dart';
import '../../repository/questions_repository.dart';
import '../../utils/AppConfig.dart';
import '../../utils/ui.dart';
import '../Questions_screen/models/all_questions_model.dart';
import '../auth/authenticate/provider/authprovider.dart';

SimpleFontelicoProgressDialog _dialog;

class PaymentController extends GetxController {
  final StripePaymentConfigurations _configurations = StripePaymentConfigurations();
  Map<String, dynamic> paymentIntentData;
  SignUpBody _signUpBody;

  var provider = getit<AuthModeprovider>();
  Future<bool> sendOtp(String email, context) async {
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
        message: "Sending Otp to \n ${_signUpBody.email}",
        type: SimpleFontelicoProgressDialogType.normal);
    var requestBody = {'email': email};
    final response = await post(
      Uri.parse('$apiUrl/api/login/EmailVerify'),
      body: requestBody,
    );
    if (response.statusCode == 200) {
      _dialog.hide();
      return true;
      //json.encode(response.body);
    } else {
      _dialog.hide();
      throw Exception('unable to find your email');
    }
  }
// this is comment by muddasr 
  // Future<void> makePayment(
  //     {String amount, String currency, SignUpBody signUpBody, context}) async {
  //   _signUpBody = signUpBody;
  //   try {
  //     UIBlock.block(context);
  //     paymentIntentData = await createPaymentIntent(amount, currency);
  //     if (paymentIntentData != null) {
  //       UIBlock.unblock(context);
  //       //await Stripe.instance.initGooglePay(params)
  //       await Stripe.instance
  //           .initPaymentSheet(
  //           paymentSheetParameters: SetupPaymentSheetParameters(
  //         //googlePay: PaymentSheetGooglePay(testEnv: true),

  //         //testEnv: true,
  //         //merchantCountryCode: 'US',
  //         merchantDisplayName: 'Prospects',
  //         customerId: paymentIntentData['customer'],
  //         paymentIntentClientSecret: paymentIntentData['client_secret'],
  //         customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
  //       ))
  //           .then((value) {
  //         displayPaymentSheet(context, paymentIntentData['client_secret'],amount);
  //       });
  //     }
  //   } catch (e, s) {
  //     print('exception:$e$s');
  //     UIBlock.unblock(context);
  //   }
  // }

  displayPaymentSheet(context, client,String amount) async {
    try {
      // await Stripe.instance.presentPaymentSheet();
      //await Stripe.instance
      //  .presentGooglePay(PresentGooglePayParams(clientSecret: client));
      /*_signUpBody.customerPackages.amount = int.parse(amount);
      _signUpBody.customerPackages.status = "paid";
      _signUpBody.customerPackages.duration = 1;*/



      var user = Provider.of<UserDataProvider>(context, listen: false);
     int userId = user.userData.user.id;

      double Amount=double.parse(amount);
      int Duration=30;
      String Name="Package Name";
      String Status="paid";

      AddPaymentConfirmationRequestModel requestModel=AddPaymentConfirmationRequestModel(Amount:Amount,Duration:Duration,Name:Name,Status:Status,UserId: userId);
      // addPaymentConfirmation(requestModel).then((value) {
      //   if (value != null) {
      //     if (value.response == "Data updated successfully") {
      //       Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(builder: (context) => BottomBarNew(0)),
      //               (route) => false);

      //     }
      //   }
      // });



/*
      double Amount=double.parse(amount);
      int Duration=30;
      String Name="Package Name";
      String Status="paid";

      AddPaymentConfirmationRequestModel requestModel=AddPaymentConfirmationRequestModel(Amount:Amount,Duration:Duration,Name:Name,Status:Status,UserId: userId);
      addPaymentConfirmation(requestModel).then((value) {
        if (value!=null) {
          if (value.response=="Data updated successfully") {
            */
/*      provider.getData()
          ? signUpOtherUser(_signUpBody, context)
          : sendOtp(_signUpBody.email, context).then((value) {
              if (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTPScreen(
                              email: _signUpBody.email,
                              text: 'Signup',
                              signUpBody: _signUpBody,
                            )));
              }
            });*//*



            // Responsive1.isMobile(context)
            //     ? Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => BottomBarNew(0)),
            //         (route) => false)
            //     : Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => SideMenu()),
            //         (route) => false);


            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                    (route) => false);

          }

        }
      });
*/

      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin:  const EdgeInsets.all(10));


      /*
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpScreen(
                        signUpBody: _signUpBody,
                      )));
*/

    } on Exception {
    //   if (e is StripeException) {
    //     print("Error from Stripe: ${e.error.localizedMessage}");
    //   } else {
    //     print("Unforeseen error: ${e}");
    //   }
    // } catch (e) {
    //   print("exception:$e");
    // }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        // 'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${_configurations.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  Future<AddPaymentConfirmationResponseModel> addPaymentConfirmation(AddPaymentConfirmationRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository=QuestionRepository();
      AddPaymentConfirmationResponseModel response=await _questionRepository.addPaymentConfirmation(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
}