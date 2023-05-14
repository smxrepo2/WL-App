import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_loser/screens/recipie/methods/methods.dart';
import 'package:weight_loser/screens/recipie/model/recipe_model.dart';
import 'package:weight_loser/screens/recipie/views/body.dart';
import 'package:weight_loser/screens/recipie/views/details.dart';
import 'package:weight_loser/widget/test.dart';

class FoodTimeList extends StatefulWidget {
  FoodTimeList(
      {Key key,
      this.title,
      @required this.cuisine,
      @required this.foodList,
      @required this.noofdoc})
      : super(key: key);

  final String title;
  final List<FoodList> foodList;
  final int noofdoc;
  final String cuisine;

  @override
  State<FoodTimeList> createState() => _FoodTimeListState();
}

class _FoodTimeListState extends State<FoodTimeList> {
  int _currMax;
  List<FoodList> _foodList = [];
  List myList = [];
  ScrollController _scrollController = ScrollController();
  int _noofdoc;
  int listgen;

  @override
  void initState() {
    super.initState();
    _foodList = widget.foodList;

    _noofdoc = widget.noofdoc;
    _noofdoc <= 2
        ? () {
            _currMax = 2;
            listgen = 2;
          }()
        : _noofdoc <= 4
            ? () {
                _currMax = 2;
                listgen = 2;
              }()
            : _noofdoc <= 6
                ? () {
                    _currMax = 4;
                    listgen = 4;
                  }()
                : _noofdoc <= 8
                    ? () {
                        _currMax = 6;
                        listgen = 6;
                      }()
                    : () {
                        _currMax = 6;
                        listgen = 6;
                      }();
    print("No of docs:" + _noofdoc.toString());
    print("No of items:" + _foodList.length.toString());
    myList = List.generate(listgen, (index) => index);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (myList.length + 2 < _noofdoc) {
          loadmoreitems();
        }

        //print(listitems);
      }
    });
  }

  loadmoreitems() async {
    await GetRecipeInnerData(
            _foodList[0].cuisine, "title".toLowerCase().toString())
        .then((List<FoodList> foodList) {
      foodList.forEach((element) {
        _foodList.add(element);
      });
      for (int i = _currMax; i < _currMax + 6; i++) {
        myList.add(i);
      }
      //if (myList.length < _totalDocs)
      _currMax = _currMax + 6;
      if (_currMax >= _noofdoc) {
        int length = _currMax - _noofdoc;
        _currMax = _currMax - length;
        myList.length = _currMax - 2;
        print("List Length:" + myList.length.toString());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: GridView.builder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: myList.length + 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            if (index == myList.length + 1 && myList.length + 2 != _noofdoc) {
              //CupertinoColors.activeOrange;
              print("load cupertino:" + index.toString());
              return CupertinoTheme(
                data: CupertinoTheme.of(context)
                    .copyWith(brightness: Brightness.dark),
                child: CupertinoActivityIndicator(),
              );
              //return CupertinoActivityIndicator();
            }
            if (index == myList.length && myList.length + 2 != _noofdoc) {
              return CupertinoTheme(
                data: CupertinoTheme.of(context)
                    .copyWith(brightness: Brightness.dark),
                child: CupertinoActivityIndicator(),
              );
            }
            return RecipeBox(context, _foodList[index]);
          },
        ),
      ),
    );
  }
}
