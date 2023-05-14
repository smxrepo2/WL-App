import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weight_loser/screens/recipie/methods/methods.dart';
import 'package:weight_loser/screens/recipie/model/recipe_model.dart';
import 'package:weight_loser/screens/recipie/provider/recipe_provider.dart';
import 'package:weight_loser/screens/recipie/views/FoodTimeList.dart';
import 'package:weight_loser/screens/recipie/views/SearchRecipe.dart';
import 'package:weight_loser/screens/recipie/views/details.dart';
import 'package:weight_loser/screens/recipie/views/filter.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../../../notifications/getit.dart';
import 'SearchRecipe.dart';

class RecipieScreen extends StatefulWidget {
  const RecipieScreen({Key key}) : super(key: key);

  @override
  State<RecipieScreen> createState() => _RecipieScreenState();
}

class _RecipieScreenState extends State<RecipieScreen> {
  List<String> time = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  int _selectedTime = 0;
  Future<RecipeModel> _recipeFuture;
  var _recipeProvider = getit<recipeprovider>();
  List<Cuisines> _cuisines = [];

  List<String> types = ['All', 'Chinese', 'Pakistani', 'Indian', 'Cusine'];
  void updateRecipe() {
    if (mounted) setState(() {});
  }

  int _selectedType = 0;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recipeFuture = GetRecipeData("no", time[_selectedTime]);
    _recipeProvider?.addListener(updateRecipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //appBar: PreferredSize(
      //preferredSize: Size.fromHeight(0),
      //child: AppBar(
      //elevation: 0,
      //backgroundColor: Colors.transparent,
      //title: null,
      //),
      //),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken),
                // food image network link
                image: NetworkImage(
                    'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI='),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                /*
                Transform.translate(
                  offset: Offset(-145, 5),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                */
                SizedBox(height: 20),
                Text(
                  'WEIGHT LOSER',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchRecipe()));
                            },
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabled: false,
                                contentPadding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xff747171),
                                  size: 17.45,
                                ),
                                hintText: 'Find Recipes',
                                hintStyle: TextStyle(
                                    fontSize: 11, color: Color(0xff747171)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      /*
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.filter_list,
                              color: Color(0xff747171), size: 17.45),
                          onPressed: () {
                            //Navigator.push(
                            //  context,
                            //MaterialPageRoute(
                            //  builder: (context) => FilterScreen()));
                          },
                        ),
                      ),
                      */
                    ],
                  ),
                ),
                SizedBox(width: 30),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, -12),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: ListView.builder(
                  itemCount: time.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = index;
                          _scrollController.animateTo(
                            200.0 * (index - 1),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        decoration: BoxDecoration(
                          // underline
                          border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: _selectedTime == index
                                    ? Colors.blueAccent
                                    : Colors.transparent),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.5),
                          child: Text(
                            time[index],
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff929292),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          FutureBuilder<RecipeModel>(
            future: _recipeFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                  break;
                case ConnectionState.done:
                default:
                  if (snapshot.hasError)
                    return Text("No Internet Connectivity");
                  else if (snapshot.hasData) {
                    if (_cuisines.length == 0)
                      _cuisines = _recipeProvider.getAllCuisines();

                    if (_cuisines.first.id != 0) {
                      var firstElemet = {
                        "Id": 0,
                        "CuisineName": snapshot.data.foodList[0].cuisine,
                        "Country": "",
                        "Type": "diet",
                        "CreatedAt": "2022-06-25T07:38:04.07",
                        "ModifiedAt": null
                      };
                      _cuisines.insert(0, Cuisines.fromJson(firstElemet));
                      print("id:" + _cuisines.first.id.toString());
                    }

                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: _cuisines.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedType = index;

                                          _recipeFuture = GetRecipeData(
                                              _selectedType != 0
                                                  ? _cuisines[_selectedType]
                                                      .cuisineName
                                                  : "no",
                                              "all");
                                        });
                                      },
                                      child: Card(
                                        color: _selectedType == index
                                            ? Color(0xff4B86ED)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          child: Text(
                                            _cuisines[index].cuisineName,
                                            style: TextStyle(
                                              fontSize: _selectedType == index
                                                  ? 12
                                                  : 10,
                                              color: _selectedType == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: _selectedType == index
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          RecipeBoxList(
                              scrollController: _scrollController, time: time)
                        ],
                      ),
                    );
                  } else
                    return Text("No Data");
              }
            },
          )
        ],
      ),
    );
  }
}

class RecipeBoxList extends StatefulWidget {
  const RecipeBoxList({
    Key key,
    @required ScrollController scrollController,
    @required this.time,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<String> time;

  @override
  State<RecipeBoxList> createState() => _RecipeBoxListState();
}

class _RecipeBoxListState extends State<RecipeBoxList> {
  bool showAll = false;
  var _recipeProvider = getit<recipeprovider>();
  List<FoodList> _foodList = [];
  List<FoodList> _breakfast = [];
  List<FoodList> _lunch = [];
  List<FoodList> _dinner = [];
  List<FoodList> _snacks = [];
  int count = 0;
  //List<String> matchList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodList = _recipeProvider.getFoodList();
    //print("Food List:" + _foodList.length.toString());
    _foodList.forEach((element) {
      if (element.mealType == "Breakfast")
        _breakfast.add(element);
      else if (element.mealType == "Lunch")
        _lunch.add(element);
      else if (element.mealType == "Snacks")
        _snacks.add(element);
      else
        _dinner.add(element);
    });
    print("Breakfast Length:" + _breakfast.length.toString());
    //matchList.clear();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = widget._scrollController;
    List<String> time = widget.time;
    return _foodList.length == 0
        ? Text("No Data for this Cuisine")
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView.builder(
                controller: _scrollController,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: time.length - 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${time[index + 1]}'.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodTimeList(
                                      title: time[index + 1],
                                      foodList: index == 0
                                          ? _breakfast
                                          : index == 1
                                              ? _lunch
                                              : index == 2
                                                  ? _dinner
                                                  : _snacks,
                                      noofdoc: index == 0
                                          ? _recipeProvider.breakfastCount()
                                          : index == 1
                                              ? _recipeProvider.lunchCount()
                                              : index == 2
                                                  ? _recipeProvider
                                                      .dinnerCount()
                                                  : _recipeProvider
                                                      .snacksCount(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'VIEWALL',
                                style: TextStyle(fontSize: 9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.285,
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, i) {
                              return index == 0
                                  ? i == 0
                                      ? RecipeBox(context, _breakfast[i])
                                      : RecipeBox(context, _breakfast[i])
                                  : index == 1
                                      ? i == 0
                                          ? RecipeBox(context, _lunch[i])
                                          : RecipeBox(context, _lunch[i])
                                      : index == 2
                                          ? i == 0
                                              ? RecipeBox(context, _dinner[i])
                                              : RecipeBox(context, _dinner[i])
                                          : i == 0
                                              ? RecipeBox(context, _snacks[i])
                                              : RecipeBox(context, _snacks[1]);

                              //return _buildRecipeBox(context, time[index + 1]);
                            }),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }

  /*
  _buildRecipeBox(context, String mealType) {
    if (matchList.length < 8) {
      print("FoodList Length:" + _foodList.length.toString());
      for (int i = 0; i < _foodList.length; i++) {
        print("Food Item Name:" + _foodList[i].name);
        if (count == 2) {
          break;
        } else if (mealType.toLowerCase().toString() ==
                _foodList[i].mealType.toLowerCase().toString() &&
            !matchList.contains(_foodList[i].foodId)) {
          matchList.add(_foodList[i].foodId);
          print("Item File Name:" + _foodList[i].fileName);
          count = count + 1;
          return RecipeBox(context, _foodList[i]);
        }
      }
    }
  }
  */
}

Widget RecipeBox(context, FoodList foodItem) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetailsScreen(
            foodId: foodItem.foodId,
            mealType: foodItem.mealType,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.455,
      height: MediaQuery.of(context).size.width * 0.555,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          image: NetworkImage('$imageBaseUrl${foodItem.fileName}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        Transform.translate(
          offset: Offset(47.5, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
            color: Color(0xff568DEE).withOpacity(0.49),
            child: Text('Recipe',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Spacer(),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 5),
          child: Text('${foodItem.name}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 5),
            child: foodItem.description == null ||
                    foodItem.description == "null"
                ? Text('', style: TextStyle(fontSize: 11, color: Colors.white))
                : Text('${foodItem.description}',
                    style: TextStyle(fontSize: 11, color: Colors.white))),
        SizedBox(height: 5),
      ]),
    ),
  );
}
