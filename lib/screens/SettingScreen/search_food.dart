// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class SearchFood extends StatefulWidget {
//   const SearchFood({Key key}) : super(key: key);
//
//   @override
//   _SearchFoodState createState() => _SearchFoodState();
// }
//
// class _SearchFoodState extends State<SearchFood> {
//   String dropDownValue = 'Recently Eaten';
//   int dropDownIndex = 0;
//   var items =  ['Recently Eaten','Frequently Eaten','Recently Viewed','Favourites'];
//
//   List<String> eatingTime = [
//     'Morning',
//     'Lunch',
//     'Dinner',
//     'Snacks'
//   ];
//   List<String> types = [
//     'All Cuisines',
//     'Indians',
//     'Thai',
//     'Italian',
//     'Mexican',
//   ];
//   List<String> foods = [
//     'Alo Gobi',
//     'Crisp Papadum',
//     'Falak Punner',
//     'Fish Curry',
//     'Dal makahni',
//     'Kofta',
//   ];
//   List<String> effect = [
//     'keto Grade: Avoid',
//     'Vegan: Friendly',
//     'Ketan: Friendly',
//     'Vegan: Friendly',
//     'Kernal: Friendly',
//     'Ketan: Friendly',
//   ];
//   int selectedIndex = 0;
//   int selectedEatingTime = 0;
//   int ingredientOrProcedure = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20,right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Icon(Icons.menu,size: 30,color: Color(0xFF797A7A),),
//                   Icon(Icons.notifications,size: 30,color: Color(0xFF797A7A),)
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   'Today',
//                   style: GoogleFonts.openSans(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12
//                   ),
//                 ),Text(
//                   'Diet',
//                   style: GoogleFonts.openSans(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12
//                   ),
//                 ),Text(
//                   'Exercise',
//                   style: GoogleFonts.openSans(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12
//                   ),
//                 ),Text(
//                   'Mind',
//                   style: GoogleFonts.openSans(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 20,right: 20),
//               child: Divider(
//                 thickness: 1,
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20,right: 20),
//               child: Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey,width: .2)
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20,right: 10),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.05,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(color: Colors.grey,width: .5)
//                           ),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.03,
//                               ),
//                               const Icon(
//                                 Icons.search,
//                                 color: Colors.grey,
//                                 size: 20,
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 10),
//                                   child: TextFormField(
//                                     maxLines: 1,
//                                     decoration: InputDecoration(
//                                       isDense: true,
//                                       hintText: 'Search From the list',
//                                       hintStyle: GoogleFonts.openSans(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w500
//                                       ),
//                                       border: InputBorder.none
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Image.asset('assets/icons/camera_icon.png'),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width*0.02,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Image.asset('assets/icons/barScan_icon.png'),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.03,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             SizedBox(
//               width: double.infinity,
//               height: 60,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: types.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: GestureDetector(
//                       onTap: (){
//                         setState(() {
//                           selectedIndex = index;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 13),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: selectedIndex == index ? Color(0xff4885ED) : Colors.white,
//                             border: Border.all(color: Colors.grey,width: .3)
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03,
//                                   vertical: MediaQuery.of(context).size.width * 0.02),                              child: Text(
//                                 types[index],
//                                 style: GoogleFonts.montserrat(
//                                   fontSize: 13,
//                                   color: selectedIndex == index ? Colors.white : Colors.black,
//                                   fontWeight: FontWeight.w500
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: PopupMenuButton(
//                     initialValue: dropDownIndex,
//                     onSelected: (int index){
//                       dropDownIndex = index;
//                       dropDownValue = items[dropDownIndex];
//                       setState(() {});
//                     },
//                     child: Center(
//                         child: Image.asset('assets/icons/sort_icon.png')),
//                     itemBuilder: (context) {
//                       return List.generate(items.length, (index) {
//                         return PopupMenuItem(
//                           value: index,
//                           child: Text(items[index]),
//                         );
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.02,
//                 ),
//                 Text(
//                   dropDownValue,
//                 )
//               ],
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: foods.length,
//                 shrinkWrap: true,
//                 physics: const ClampingScrollPhysics(),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: GestureDetector(
//                       onTap: (){
//                         showFoodDialog(context);
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         height: MediaQuery.of(context).size.height * 0.13,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey,width: .2)
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         foods[index],
//                                         style: GoogleFonts.openSans(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 15
//                                         ),
//                                       ),
//                                       Text(
//                                         '1 Serving, 250 grams',
//                                         style: GoogleFonts.openSans(
//                                             fontSize: 11,
//                                           color: Colors.grey
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Cals',
//                                         style: GoogleFonts.openSans(
//                                             color: Colors.grey,
//                                             fontSize: 11
//                                         ),
//                                       ),
//                                       Text(
//                                         '320',
//                                         style: GoogleFonts.openSans(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 15
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height * 0.01,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                     borderRadius: BorderRadius.circular(100)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Text(
//                                         types[selectedIndex],
//                                         style: GoogleFonts.montserrat(
//                                             fontSize: 11, color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.02,
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: effect[index].contains('Avoid') ? Colors.red[100] : Colors.green[100],
//                                     borderRadius: BorderRadius.circular(100)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
//                                       child: Text(
//                                         effect[index],
//                                         style: GoogleFonts.montserrat(
//                                             fontSize: 11, color: effect[index].contains('Avoid') ? Colors.red : Colors.green),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   showFoodDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context,setState) {
//           return Dialog(
//               backgroundColor: Colors.transparent,
//               insetPadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,
//                   right: MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05,
//                   bottom: MediaQuery.of(context).size.width * 0.05),
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.15,
//                               height: MediaQuery.of(context).size.width * 0.2,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   image: DecorationImage(
//                                       image: Image.network('https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=').image,
//                                       fit: BoxFit.cover
//                                   )
//                               ),
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.03,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.01,
//                                 ),
//                                 Text(
//                                   'Palak Paneer',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 15,
//                                       color: Colors.black
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.002,
//                                 ),
//                                 Text(
//                                   '1 Serving, 250 grams',
//                                   style: GoogleFonts.openSans(
//                                       fontSize: 11,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.01,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           border: Border.all(color: Colors.grey),
//                                           borderRadius: BorderRadius.circular(100)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(4.0),
//                                         child: Text(
//                                           types[selectedIndex],
//                                           style: GoogleFonts.montserrat(
//                                               fontSize: 9, color: Colors.grey),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width * 0.02,
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius: BorderRadius.circular(100)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
//                                         child: Text(
//                                           'Keton: Avoid',
//                                           style: GoogleFonts.montserrat(
//                                               fontSize: 9, color: Colors.red),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                             Expanded(child: SizedBox()),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.2,
//                               height: MediaQuery.of(context).size.width * 0.2,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                   border: Border.all(color: Colors.grey,width: .5)
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Cals',
//                                     style: GoogleFonts.openSans(
//                                         color: Colors.grey,
//                                         fontSize: 18
//                                     ),
//                                   ),
//                                   Text(
//                                     '320',
//                                     style: GoogleFonts.openSans(
//                                         color: Colors.black,
//                                         fontSize: 24
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.03,
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.01,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20,right: 20),
//                         child: Divider(
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Carb',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w300
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.height * 0.002,
//                                     ),
//                                     Text(
//                                       '250g',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   '17g left',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Fat',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w300
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.height * 0.002,
//                                     ),
//                                     Text(
//                                       '250g',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   '17g left',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Protein',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w300
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.height * 0.002,
//                                     ),
//                                     Text(
//                                       '250g',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   '17g left',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Other',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w300
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.height * 0.002,
//                                     ),
//                                     Text(
//                                       '250g',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   '17g left',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20,right: 20),
//                         child: Divider(
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedEatingTime = 0;
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       color: selectedEatingTime == 0
//                                           ? Color(0xff4885ED)
//                                           : Colors.white,
//                                       border: Border.all(
//                                           color: Colors.grey, width: .5)),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03,
//                                     vertical: MediaQuery.of(context).size.width * 0.02),
//                                     child: Text(
//                                       'Morning',
//                                       style: GoogleFonts.montserrat(
//                                         fontSize: 13,
//                                         color: selectedEatingTime == 0
//                                             ? Colors.white
//                                             : Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedEatingTime = 1;
//                                   });
//                                 },
//                                 child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                   color: selectedEatingTime == 1? Color(0xff4885ED) : Colors.white,
//                                   border: Border.all(color: Colors.grey,width: .5)
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03,
//                                       vertical: MediaQuery.of(context).size.width * 0.02),                              child: Text(
//                                     'Lunch',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 13,
//                                       color: selectedEatingTime == 1 ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                             ),
//                               ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedEatingTime = 2;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                     color: selectedEatingTime == 2? Color(0xff4885ED) : Colors.white,
//                                     border: Border.all(color: Colors.grey,width: .5)
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03,
//                                       vertical: MediaQuery.of(context).size.width * 0.02),                              child: Text(
//                                     'Dinner',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 13,
//                                       color: selectedEatingTime == 2 ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedEatingTime = 3;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                     color: selectedEatingTime == 3? Color(0xff4885ED) : Colors.white,
//                                     border: Border.all(color: Colors.grey,width: .5)
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03,
//                                       vertical: MediaQuery.of(context).size.width * 0.02),                              child: Text(
//                                     'Snack',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 13,
//                                       color: selectedEatingTime == 3 ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20,right: 20),
//                         child: Divider(
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
//                         child: Text(
//                           'Serving Size',
//                           style: GoogleFonts.montserrat(
//                               fontSize: 13,
//                             color: Colors.black
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05,
//                         right: MediaQuery.of(context).size.width * 0.05),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               '250',
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400
//                               ),
//                             ),
//                             Text(
//                               'Grams',
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20,right: 20),
//                         child: Divider(
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.width * 0.02,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05,
//                             right: MediaQuery.of(context).size.width * 0.05),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               children: [
//                                 GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         ingredientOrProcedure = 0;
//                                       });
//                                     },
//                                     child: Text(
//                                       'Ingredients',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w400,
//                                           color: ingredientOrProcedure == 0
//                                               ? Colors.black
//                                               : Colors.grey),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.001,
//                                 ),
//                                 ingredientOrProcedure == 0 ? Container(
//                                   width: MediaQuery.of(context).size.width * 0.15,
//                                   height: MediaQuery.of(context).size.height * 0.002,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0xff4885ED)
//                                   ),
//                                 ) : Container()
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: (){
//                                     setState(() {
//                                       ingredientOrProcedure = 1;
//                                     });
//                                   },
//                                   child: Text(
//                                     'Procedure',
//                                     style: GoogleFonts.montserrat(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w400,
//                                         color: ingredientOrProcedure == 1 ? Colors.black : Colors.grey
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.001,
//                                 ),
//                                 ingredientOrProcedure == 1 ? Container(
//                                   width: MediaQuery.of(context).size.width * 0.15,
//                                   height: MediaQuery.of(context).size.height * 0.002,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Color(0xff4885ED)
//                                   ),
//                                 ) : Container()
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05,
//                             right: MediaQuery.of(context).size.width * 0.05),
//                         child: Container(
//                           width: double.infinity,
//                           height: MediaQuery.of(context).size.height * 0.25,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey,width: .5)
//                           ),
//                           child: ingredientOrProcedure == 0 ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Text(
//                                   '1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ),Padding(
//                                 padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Text(
//                                   '1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ),Padding(
//                                 padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Text(
//                                   '1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ),Padding(
//                                 padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Text(
//                                   '1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               ),Padding(
//                                 padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Text(
//                                   '1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       color: Colors.grey
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ) : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                   padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: 5,
//                                       height: 5,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(100),
//                                         color: Colors.grey
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       '1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ),
//                               Padding(
//                                   padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: 5,
//                                       height: 5,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(100),
//                                         color: Colors.grey
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       '1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ),
//                               Padding(
//                                   padding: const EdgeInsets.only(left: 10,top: 10),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 5,
//                                       height: 5,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(100),
//                                         color: Colors.grey
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Flexible(
//                                       child: Text(
//                                         '1 bone-in, skin-on chicken thighs (2 oz. each)1  bone-in, skin-on chicken thighs (2 oz. each)1ne-in, skin-on chicken thighs (2 oz. each)1  bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)',
//                                         maxLines: 5,
//                                         style: GoogleFonts.montserrat(
//                                             fontSize: 12,
//                                             color: Colors.grey
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height:  MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.25,
//                             height: MediaQuery.of(context).size.height * 0.05,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: Color(0xff4885ED)
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'Log Food',
//                                 style: GoogleFonts.openSans(
//                                   fontSize: 15,
//                                   color: Colors.white
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )
//           );
//         },);
//       },
//     );
//   }
// }
