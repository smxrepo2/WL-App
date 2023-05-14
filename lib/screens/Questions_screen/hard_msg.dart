// import 'package:flutter/material.dart';
// import 'package:weight_loser/Model/SignupBody.dart';
// import 'package:weight_loser/Service/Responsive.dart';
// import 'package:weight_loser/constants/constant.dart';
// import 'package:weight_loser/widget/question_Header.dart';
//
// class HardMsg extends StatefulWidget {
//   SignUpBody signUpBody;
//   HardMsg({this.signUpBody});
//
//   @override
//   State<HardMsg> createState() => _HardMsgState();
// }
//
// class _HardMsgState extends State<HardMsg> {
//   @override
//   Widget build(BuildContext context) {
//     var mobile=Responsive1.isMobile(context);
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 10,
//                   ),
//                   questionHeaderSimple(percent: .99,color: mindBorder,),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Losing weight is hard.\nMaintaining weight is hard.\nStaying overweight is hard.\nChoose your hard',
//                         textAlign: TextAlign.center,
//                         style: questionText30Px,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                       height: mobile?300:250,
//                       //width: Get.width * .5,
//                       child: Image.asset(
//                         ImagePath.mentalStrength,
//                         fit: BoxFit.contain,
//                       )),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Tell us what throws you off or may weaken your determination\nto lose weight. So, we may bring some hope to you!',
//                         textAlign: TextAlign.center,
//                         style: darkText12Px,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               InkWell(
//                 onTap: () {
//                   mobile?
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => ICantControlMySelf(
//                         signUpBody: widget.signUpBody,
//                       ))):
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Padding(
//                         padding: const EdgeInsets.only(left: 430,right: 430,top: 30,bottom: 30),
//                         child: Card(
//                             elevation:5,shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius. circular(10)),
//                             child:ICantControlMySelf(
//                               signUpBody: widget.signUpBody,
//                             )),
//                       )));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(30.0),
//                   child: Container(
//                       width: Get.width * .6,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.all(Radius.circular(40.0))),
//                       child: Center(
//                         child: Text(
//                           "Next",
//                           style: buttonStyle,
//                         ),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
