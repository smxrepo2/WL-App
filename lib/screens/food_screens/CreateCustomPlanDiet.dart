import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timelines/timelines.dart';
import 'package:weight_loser/screens/navigation_tabs/homepage/middle.dart';
import 'package:weight_loser/widget/FoodDialog.dart';

import '../../../Component/DDText.dart';
import '../../../CustomWidgets/SizeConfig.dart';
import '../../../constants/constant.dart';
import '../../../theme/TextStyles.dart';

class CreateCustomPlanDiet extends StatefulWidget {
  const CreateCustomPlanDiet({Key key}) : super(key: key);

  @override
  State<CreateCustomPlanDiet> createState() => _CreateCustomPlanDietState();
}

class _CreateCustomPlanDietState extends State<CreateCustomPlanDiet> {
  TextEditingController _searchController = TextEditingController();

  int day = 1;

  List<String> types = [
    'All Cuisines',
    'Indians',
    'Thai',
    'Italian',
    'Mexican',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Custom Plan',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        day--;
                        if (day < 1) {
                          day = 1;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 12.5),
                  ),
                  Text(
                    'Day $day',
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 12,
                      color: Color(0xcc1e1e1e),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        day++;
                        if (day > 100) {
                          day = 100;
                          print(day);
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_forward_ios, size: 12.5),
                  )
                ],
              ),
              SizedBox(height: 10),
              const Center(
                child: Text(
                  'Select Custom Meal',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 10,
                    color: const Color(0x991e1e1e),
                  ),
                  softWrap: false,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: lightText12Px,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black45,
                            ),
                            hintText: "Search for food"),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(-10, 0),
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelStyle:
                      const TextStyle(fontSize: 12, fontFamily: 'Open Sans'),
                  labelStyle: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                  ),
                  unselectedLabelColor: const Color(0xff363738),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  labelColor: Colors.blueAccent,
                  tabs: [
                    for (int i = 0; i < types.length; i++)
                      Tab(
                        text: types[i],
                      )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    CuisinePage(),
                    CuisinePage(),
                    CuisinePage(),
                    CuisinePage(),
                    CuisinePage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          extendedPadding:
              const EdgeInsets.symmetric(horizontal: 22.5, vertical: 0),
          label: const Text('Save Diet'),
          extendedTextStyle: const TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 15,
            color: Color(0xffffffff),
            height: 0.9333333333333333,
          ),
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            setState(() {
              day++;
            });
          },
        ),
      ),
    );
  }
}

class CuisinePage extends StatefulWidget {
  CuisinePage({
    Key key,
  }) : super(key: key);

  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  int selectedViewAll = 0;
  bool viewAll = false;
  int size = 2;

  int selectedIndex = 0;
  List<String> timeFilter = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  List<String> time = ['Morning', 'Lunch', 'Dinner', 'Snacks'];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        viewAll
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < timeFilter.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = i;
                            selectedViewAll = i - 1;
                          });
                        },
                        child: Text(
                          timeFilter[i],
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: selectedIndex == i
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12,
                              color: selectedIndex == i
                                  ? Colors.blueAccent
                                  : const Color(0xff363738)),
                        ),
                      ),
                    ),
                ],
              )
            : const SizedBox(height: 10),
        const Divider(indent: 50, endIndent: 50, thickness: 2, height: 0),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: viewAll ? 1 : time.length + 1,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              return index == time.length
                  ? const SizedBox(height: 50)
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            viewAll
                                ? selectedViewAll == -1
                                    ? 'All'
                                    : time[selectedViewAll]
                                : time[index],
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 15,
                              color: const Color(0xff23233c),
                            ),
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(height: 20),
                        for (int i = 0; i < size; i++) FoodTile(),
                        viewAll
                            ? Container()
                            : Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      viewAll = !viewAll;

                                      if (viewAll) {
                                        selectedViewAll = index;
                                        selectedIndex = selectedViewAll + 1;
                                        size = 10;
                                      } else {
                                        size = 2;
                                      }
                                    });
                                  },
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                        color:
                                            Colors.blueAccent.withOpacity(0.75),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10),
                      ],
                    );
            },
          ),
        ),
      ],
    );
  }
}

class FoodTile extends StatefulWidget {
  FoodTile({
    Key key,
  }) : super(key: key);

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  bool isSelected = false;

  int selectedEatingTime = 0;
  int ingredientOrProcedure = 0;

  List<bool> repeatDays = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: Image.network(
                                'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                            .image,
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Text(
                    'Palak Paneer',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                      color: const Color(0xff2b2b2b),
                      fontWeight: FontWeight.w300,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.002,
                  ),
                  const Text(
                    '250 garams',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 11,
                      color: const Color(0xffafafaf),
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      showFoodDialog(context);
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 10,
                        color: const Color(0xff4885ed),
                        fontWeight: FontWeight.w300,
                      ),
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                child: Column(
                  children: [
                    const Text(
                      '320 kcal',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: const Color(0xff2b2b2b),
                      ),
                      softWrap: false,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      icon: isSelected
                          ? const Icon(Icons.check, color: Colors.blueAccent)
                          : const Icon(Icons.add, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
              height: 20,
              color: Colors.grey.shade200),
        ],
      ),
    );
  }

  showFoodDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width * 0.05),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: Image.network(
                                              'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Palak Paneer',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                Text(
                                  '1 Serving, 250 grams',
                                  style: GoogleFonts.openSans(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          types[selectedIndex],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 10),
                                        child: Text(
                                          'Keton: Avoid',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.red),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.grey, width: .5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cals',
                                    style: GoogleFonts.openSans(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                  Text(
                                    '320',
                                    style: GoogleFonts.openSans(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Carb',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Fat',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Protein',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Other',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              ingredientOrProcedure = 0;
                            });
                          },
                          child: Text(
                            'Recipe',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: ingredientOrProcedure == 0
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '1 cup fat free milk',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '1 cup oats',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '1 tbsp chopped walnuts',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Serving Size',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '250',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Grams',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 0
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: Text(
                                    'Morning',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 1
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: Text(
                                    'Lunch',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 2;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 2
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: Text(
                                    'Dinner',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 3;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 3
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: Text(
                                    'Snack',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Repeat on these days',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    repeatDays[index] = !repeatDays[index];
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 30,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: repeatDays[index]
                                        ? Colors.blueAccent
                                        : Colors.white,
                                    border: Border.all(
                                      color: repeatDays[index]
                                          ? Colors.blueAccent
                                          : Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: repeatDays[index]
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add to custom',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
