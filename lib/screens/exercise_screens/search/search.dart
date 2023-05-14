import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/exercise_screens/CreateExerciseCustomPlan.dart';
import 'package:weight_loser/screens/exercise_screens/methods/methods.dart';
import 'package:weight_loser/screens/exercise_screens/models/custom_exercise_model.dart';
import 'package:weight_loser/screens/exercise_screens/providers/add_exercise_provider.dart';
import 'package:weight_loser/screens/exercise_screens/providers/customexerciseProvider.dart';

class SearchExercises extends StatefulWidget {
  SearchExercises({Key key, this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  State<SearchExercises> createState() => _SearchExercisesState();
}

class _SearchExercisesState extends State<SearchExercises> {
  TextEditingController searchTextController = TextEditingController();

  var _customexerciseProvider = getit<customexerciseprovider>();
  var _exerciseProvider = getit<addedexerciselistprovider>();
  List<Burners> exerciseItems;

  bool searchable = false;
  List<Burners> resultExercises = [];
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
              hintText: 'Search for Exercises',
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
                  SearchCustomExerciseData(
                          searchTextController.text.trim().toString())
                      .then((value) {
                    if (value.length == 0) {
                      setState(() {
                        isLoading = false;
                      });

                      resultExercises.clear();
                      searchTextController.text = '';
                    } else {
                      setState(() {
                        resultExercises = value;

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
          : resultExercises.length == 0
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
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
                              return ExerciseTile(
                                listItem: resultExercises[index],
                                //notifyParent: () => widget.notifyParent(),
                              );
                            },
                            itemCount: resultExercises.length,
                            //resultExercises.length < 5 ? resultExercises.length : 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics()),
                      ],
                    ),
                  ),
                ),
    );
  }
}
