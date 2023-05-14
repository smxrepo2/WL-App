import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Service/Mind%20_service.dart';

import 'package:weight_loser/screens/recipie/methods/methods.dart';
import 'package:weight_loser/screens/recipie/model/food_item_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../../../notifications/getit.dart';
import '../model/favorite_food_model.dart';
import '../provider/favorite_food_provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  RecipeDetailsScreen({Key key, @required this.foodId, @required this.mealType})
      : super(key: key);
  final String foodId;
  final String mealType;
  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  List<String> types = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  int _foodid;
  int _selectedType = 0;
  Future<FoodItemModel> _foodItemFuture;
  Future<FavouriteFoodModel> _favouriteFoodFuture;
  var favoriteProvider = getit<favoritefoodprovider>();

  bool isFavorite;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodid = int.parse(widget.foodId);
    _foodItemFuture = GetFoodDetail(_foodid);
    _favouriteFoodFuture = fetchFoodFavourites();
    isFavorite = false;
    //favoriteProvider?.addListener(() {
    //if (mounted) setState(() {});
    //});
  }

  addFoodItem(int typeId, foodId, cal, carb, fat, protein, serv,
      BuildContext context) async {
    UIBlock.block(context);
    int userid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    double servingDouble = double.parse(serv.toString());
    int serving = servingDouble.toInt();
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "FoodId": foodId,
        "Cons_Cal": cal,
        "ServingSize": serving,
        "fat": fat,
        "Protein": protein,
        "Carbs": carb
      }),
    ).then((value) {
      UIBlock.unblock(context);
      print("add meal plan item response ${value.statusCode} ${value.body}");
      final snackBar = SnackBar(
        content: Text(
          'Meal Added',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightGreen,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).onError((error, stackTrace) {
      UIBlock.unblock(context);
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: null,
        ),
      ),
      body: FutureBuilder<FoodItemModel>(
          future: _foodItemFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              FoodItemModel _foodItems = snapshot.data;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // background image
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),

                          // food image network link
                          image: NetworkImage(
                              '$imageBaseUrl${_foodItems.foodDetails.fileName}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: Offset(-10, -25),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            Text(
                              'Fresh',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              '${_foodItems.foodDetails.name}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            /*
                            Text(
                              '${_foodItems.foodDetails.servingSize}g',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            */
                            SizedBox(height: 5),
                            Row(
                              children: [
                                FutureBuilder<FavouriteFoodModel>(
                                  future: _favouriteFoodFuture,
                                  builder: (context, snapshot) {
                                    isFavorite = false;
                                    if (snapshot.hasData) {
                                      print("Favourite Data:" +
                                          snapshot.data.toString());
                                      if (snapshot.data.favoriteFoodVMs !=
                                          null) {
                                        FavouriteFoodModel _ffm = snapshot.data;
                                        _ffm.favoriteFoodVMs.forEach((element) {
                                          if (element.foodId ==
                                              _foodItems.foodDetails.foodId) {
                                            isFavorite = true;
                                            print(isFavorite);
                                          }
                                        });
                                      }

                                      return IconButton(
                                        onPressed: () {
                                          UIBlock.block(context);

                                          setFoodFavourite(
                                                  _foodItems.foodDetails.foodId)
                                              .then((value) {
                                            _favouriteFoodFuture;
                                            UIBlock.unblock(context);
                                            setState(() {
                                              //isFavorite = !isFavorite;

                                              _favouriteFoodFuture =
                                                  fetchFoodFavourites();
                                            });
                                          });
                                        },
                                        icon: Icon(Icons.favorite,
                                            color: !isFavorite
                                                ? Colors.white
                                                : Colors.red,
                                            size: 30),
                                      );
                                    }
                                    return IconButton(
                                      icon: Icon(Icons.favorite,
                                          color: Colors.white, size: 30),
                                    );
                                  },
                                ),
                                SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {
                                    int typeId;
                                    if (widget.mealType == "Breakfast")
                                      typeId = 1;
                                    else if (widget.mealType == "Lunch")
                                      typeId = 2;
                                    else if (widget.mealType == "Dinner")
                                      typeId = 3;
                                    else
                                      typeId = 4;

                                    addFoodItem(
                                        typeId,
                                        widget.foodId,
                                        _foodItems.foodDetails.calories,
                                        _foodItems.foodDetails.carbs,
                                        _foodItems.foodDetails.fat,
                                        _foodItems.foodDetails.protein,
                                        _foodItems.foodDetails.servingSize,
                                        context);
                                  },
                                  icon: Icon(Icons.add_circle,
                                      color: Colors.white, size: 30),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -30),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              children: [
                                InfoBar(
                                    title: 'Carbs',
                                    total: 40,
                                    used: _foodItems.foodDetails.carbs,
                                    color: const Color(0xffe09a9a)),
                                InfoBar(
                                  title: 'Protein',
                                  total: 40,
                                  used: _foodItems.foodDetails.protein,
                                  color: const Color(0xff13be24),
                                ),
                                InfoBar(
                                  title: 'Fat',
                                  total: 40,
                                  used: _foodItems.foodDetails.fat,
                                  color: const Color(0xffffb711),
                                ),
                                InfoBar(
                                    title: 'Calories',
                                    total: 40,
                                    used: _foodItems.foodDetails.calories,
                                    color: Color(0xff4885ed)),
                                InfoBar(
                                  title: 'Sodium',
                                  total: 40,
                                  used: _foodItems.foodDetails.sodium,
                                  color: Color.fromARGB(255, 3, 116, 26),
                                ),
                                InfoBar(
                                  title: 'Others',
                                  total: 40,
                                  used: 22,
                                  color: Color.fromARGB(255, 174, 167, 249),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      /*
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Switch to Keyboard',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ), */
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(),
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: types.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: InkWell(
                                            child: Card(
                                              elevation: 2,
                                              color: types[index] ==
                                                      widget.mealType
                                                  ? Colors.blueAccent
                                                  : Colors.grey[100],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Container(
                                                width: 65,
                                                height: 30,
                                                child: Center(
                                                  child: Text(types[index],
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: types[index] ==
                                                                  widget
                                                                      .mealType
                                                              ? Colors.white
                                                              : Colors.black)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                /*
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Show More',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                                */
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '$imageBaseUrl${_foodItems.foodDetails.fileName}',
                            height: 175,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Ingredients",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                    ),
                    IngredientsList(_foodItems.foodRecipie.ingredients),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Recipe",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                    ),
                    RecipeDetails(_foodItems.foodRecipie.procedure,
                        _foodItems.foodDetails.calories),
                    SizedBox(height: 50),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Widget RecipeDetails(String recipe, var calories) {
  recipe = recipe
      .replaceAll("<ul><li>", "")
      .replaceAll("</li><li>", "")
      .replaceAll("<li><ul>", "")
      .replaceAll("<p>", "")
      .replaceAll("</p><p>", "")
      .replaceAll("</p>", "")
      .replaceAll("<p></p>", "")
      .replaceAll("<strong></strong>", "")
      .replaceAll("<li>", "")
      .replaceAll("<ul>", "");
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          '$recipe',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
      /*
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.grey[600],
                  size: 20,
                ),
                Text(
                  '  10 mins prep',
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                )
              ],
            ),
            SizedBox(width: 40),
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.grey[600],
                  size: 20,
                ),
                Text(
                  '  10 mins prep',
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
      */
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.water_drop_outlined,
                  color: Colors.grey[600],
                  size: 20,
                ),
                Text(
                  '  $calories',
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                )
              ],
            ),
            /*
            SizedBox(width: 45),
            Row(
              children: [
                Icon(
                  Icons.pie_chart_outline,
                  color: Colors.grey[600],
                  size: 20,
                ),
                Text(
                  '  6 slices',
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                )
              ],
            ),
            */
          ],
        ),
      ),
    ],
  );
}

Widget IngredientsList(String ingredients) {
  ingredients = ingredients
      .replaceAll("\"", "")
      .replaceAll("[", "")
      .replaceAll('"', "")
      .replaceAll("]", "");
  List _ingredients = ingredients.split(',');
  if (_ingredients.length > 0)
    return Column(
      children: [
        SizedBox(height: 5),
        for (int i = 0; i < _ingredients.length; i++)
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text('\u2022  ${_ingredients[i]}',
                style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          ),
      ],
    );
  else
    return Text("No Ingredients Found");
}

class InfoBar extends StatelessWidget {
  InfoBar({Key key, this.title, this.total, this.used, this.color})
      : super(key: key);

  String title;
  var used;
  int total;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: '\u2022 ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  children: [
                    TextSpan(
                      text: '${title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(width: 30),
              Text(
                '${used}g',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 1),
          LinearProgressIndicator(
            minHeight: 2.5,
            value: 0.5,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }
}
