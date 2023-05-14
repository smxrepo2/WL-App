import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/food_screens/models/custom_diet_model.dart';
import 'package:weight_loser/screens/food_screens/models/search_food_model.dart';
import 'package:weight_loser/screens/food_screens/providers/add_food_provider.dart';
import 'package:weight_loser/screens/food_screens/providers/customdietProvider.dart';

import 'package:weight_loser/utils/AppConfig.dart';

import '../CreateCustomPlan.dart';
import '../methods/methods.dart';

class SearchCustomFood extends StatefulWidget {
  const SearchCustomFood({Key key}) : super(key: key);

  @override
  State<SearchCustomFood> createState() => _SearchCustomFoodState();
}

class _SearchCustomFoodState extends State<SearchCustomFood> {
  TextEditingController searchTextController = TextEditingController();

  var _customdietProvider = getit<customdietprovider>();
  var _foodProvider = getit<addedfoodlistprovider>();
  List<FoodList> foodItems;

  bool searchable = false;
  List<FoodList> resultFood = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: TextField(
            controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Find Food',
              hintStyle: TextStyle(color: Colors.grey[600].withOpacity(0.5)),
              border: InputBorder.none,
              prefixIcon: Transform.translate(
                offset: Offset(-20, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: searchable ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  SearchCustomDietData(
                          searchTextController.text.trim().toString())
                      .then((value) {
                    if (value.length == 0) {
                      setState(() {
                        isLoading = false;
                      });

                      resultFood.clear();
                      searchTextController.text = '';
                    } else {
                      setState(() {
                        resultFood = value;

                        isLoading = false;
                      });
                    }
                  });
                },
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  searchable = false;
                });
              } else {
                setState(() {
                  searchable = true;
                });
              }
            },
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : resultFood.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("No Search Results")),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            itemBuilder: (context, index) {
                              return FoodTile(
                                listItem: resultFood[index],

                                //notifyParent: () => widget.notifyParent(),
                              );
                            },
                            itemCount: resultFood.length,
                            //resultFood.length < 5 ? resultFood.length : 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics()),
                      ],
                    ),
                  ),
                ),
    );
  }
}
