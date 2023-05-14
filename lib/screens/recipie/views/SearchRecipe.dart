import 'package:flutter/material.dart';
import 'package:weight_loser/models/search_model.dart';
import 'package:weight_loser/screens/recipie/methods/methods.dart';
import 'package:weight_loser/screens/recipie/views/details.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../model/search_recipe_model.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe({Key key}) : super(key: key);

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  TextEditingController searchTextController = TextEditingController();

  bool searchable = false;
  List<SearchRecipeModel> resultRecipes = [];
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
              hintText: 'Find Recipes',
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
                  SearchRecipeData(searchTextController.text.trim().toString())
                      .then((value) {
                    if (value.length == 0) {
                      setState(() {
                        isLoading = false;
                      });

                      resultRecipes.clear();
                      searchTextController.text = '';
                    } else {
                      setState(() {
                        resultRecipes = value;

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
          : resultRecipes.length == 0
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeDetailsScreen(
                                        foodId: resultRecipes[index].foodId,
                                        mealType: "",
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '$imageBaseUrl${resultRecipes[index].fileName}',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    resultRecipes[index].name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    resultRecipes[index].description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: resultRecipes.length,
                            //resultRecipes.length < 5 ? resultRecipes.length : 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics()),
                      ],
                    ),
                  ),
                ),
    );
  }
}
