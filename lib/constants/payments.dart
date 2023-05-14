class StripePaymentConfigurations {
  // static const _publishableKey =
  //     "pk_test_51LBcCuHHHtu1VEhSRmHtY2Pj4IofwmJGKnmStq2SaXRgGH4WY5iQV56vJ5ogT4kYhU9QNxsQYWY9BVihIWYhZ68e00AivGV9LD";
  // static const _merchantId = "acct_1LBcCuHHHtu1VEhS";
  // static const _secretKey =
  //     "sk_test_51LBcCuHHHtu1VEhSwLnlDPyPcs7Fn5fmfu5ydHTnYqa7ZgaUwyeQFrPC0ZNHE20zOaWq9l6B2hkBSoSmoZvhLEBP00jXNKeD52";

  static const _publishableKey =
      "pk_test_51MOI8pHGTtpwUKnmmxGpTASRmkzZUEgesPzn2l16ArieafnDmibH50bUPuwH7MJDcLnRCZUqvaUTnmqNPWAosnlF00s5qZ6onS";
  static const _merchantId = "acct_1LBcCuHHHtu1VEhS";
  static const _secretKey =
      "sk_test_51MOI8pHGTtpwUKnmU7nSwEc02FawAvuEeqYBuF8XCibjXiEtzw2ftbEZByyfZhGs9vNvINuEtydB3RQ8OOKvLAmc00Ff3Xsp77";
  static const _paymentMode = "test";
//Make some getter functions
  String get publishKey => _publishableKey;
  String get merchantId => _merchantId;
  String get secretKey => _secretKey;
  String get paymentMode => _paymentMode;
}
