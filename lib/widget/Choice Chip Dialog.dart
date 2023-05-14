import 'package:flutter/material.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/models/all_restaurants.dart';
import 'package:weight_loser/screens/SettingScreen/mind_setting.dart';

import '../Model/rest_id.dart';

class MultiSelectChip extends StatefulWidget {
  final List reportList;
  final Function(List<dynamic>) onSelectionChanged;
  final int maxSelection;
  List<RestId> restId;
  AllRestaurant allRestaurant;
  MultiSelectChip(this.reportList,
      {this.onSelectionChanged,
      this.maxSelection,
      this.restId,
      this.allRestaurant});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item ?? '0'),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
              print("Hello Simple:" + selectedChoices.toString());
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class MultiSelectChipRes extends StatefulWidget {
  final List reportList;
  final Function(int) onSelectionChanged;
  final int maxSelection;
  List<RestId> restId;
  AllRestaurant allRestaurant;
  int resid;
  MultiSelectChipRes(this.reportList,
      {this.onSelectionChanged,
      this.maxSelection,
      this.restId,
      this.allRestaurant,
      this.resid});

  @override
  _MultiSelectChipResState createState() => _MultiSelectChipResState();
}

class _MultiSelectChipResState extends State<MultiSelectChipRes> {
  // String selectedChoice = "";
  List selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.allRestaurant.restaurants.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.name ?? '0'),
          selected: selectedChoices.contains(item.name),
          onSelected: (selected) {
            setState(() {
              if (selectedChoices.contains(item.name)) {
                selectedChoices.remove(item.name);

                widget.restId.remove(RestId(RestuarantId: item.id));
                widget.resid = null;
              } else {
                selectedChoices.clear();
                selectedChoices.add(item.name);
                widget.resid = item.id;
                widget.restId.add(RestId(RestuarantId: item.id));
              }
              //widget.onSelectionChanged(widget.restId);
              widget.onSelectionChanged(widget.resid);
              print("Hello:${widget.resid}");
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class ChoiceChipDialog extends StatefulWidget {
  final String title;
  ChoiceChipDialog({this.title});

  @override
  _ChoiceChipDialogState createState() => _ChoiceChipDialogState();
}

class _ChoiceChipDialogState extends State<ChoiceChipDialog> {
  List<String> reportList = [
    "Pizza",
    "Burger",
    "Soda",
    "Coffee",
    "Alcohol",
    "Buttered popcorn",
    "Chocolate",
    "Steak",
    "Sweet candy",
    "Cheese",
    "Franch Fries",
    "Ice Cream"
  ];

  List<String> selectedReportList = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: MultiSelectChip(
        reportList,
        onSelectionChanged: (selectedList) {
          setState(() {
            selectedReportList = selectedList;
          });
        },
        maxSelection: 2,
      ),
      actions: [
        MaterialButton(
            child: new Text('Update'),
            onPressed: () {
              setState(() {
                updateFoodCraving(selectedReportList.toString());
                Navigator.pop(context, true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MindSetting()));
              });
            })
      ],
    );
  }
}

class ChipDialog extends StatefulWidget {
  final String title;
  final List reportList;
  List selectedReportList;
  List<RestId> restId = [];
  AllRestaurant restaurantList;
  int resid;

  final Function() onPress;
  Function(int) onPress1;

  ChipDialog(
      {this.title,
      this.reportList,
      this.restaurantList,
      this.onPress,
      this.restId,
      this.resid,
      this.onPress1,
      this.selectedReportList});

  @override
  _ChipDialogState createState() => _ChipDialogState();
}

class _ChipDialogState extends State<ChipDialog> {
  List selectedReportList = [];
  List<RestId> selectedResList = [];
  int resid;
  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
          width: mobile ? null : 300,
          child: widget.title != "Liked Restaurants"
              ? MultiSelectChip(
                  widget.reportList,
                  onSelectionChanged: (selectedList) {
                    setState(() {
                      selectedReportList = selectedList;
                      //widget.selectedReportList.add(selectedList.toString());
                      widget.selectedReportList
                          .add(selectedReportList.toString());
                    });
                    print(widget.selectedReportList);
                  },
                  maxSelection: 1,
                )
              : MultiSelectChipRes(
                  widget.reportList,
                  restId: widget.restId,
                  resid: widget.resid,
                  allRestaurant: widget.restaurantList,
                  onSelectionChanged: (selectedList) {
                    setState(() {
                      //selectedResList = selectedList;
                      //widget.selectedReportList.add(selectedList.toString());
                      //widget.restId = selectedList;

                      widget.resid = selectedList;
                    });
                    print(selectedList);
                  },
                  maxSelection: 1,
                )),
      actions: [
        MaterialButton(
          child: new Text('Update'),
          onPressed: widget.title == "Liked Restaurants"
              ? widget.onPress1(widget.resid)
              : widget.onPress,
        )
      ],
    );
  }
}

class ChipDialog1 extends StatefulWidget {
  final String title;
  final List<dynamic> reportList;
  List<dynamic> selectedReportList;
  final Function() onPress;
  ChipDialog1(
      {this.title, this.onPress, this.selectedReportList, this.reportList});

  @override
  _ChipDialog1State createState() => _ChipDialog1State();
}

class _ChipDialog1State extends State<ChipDialog1> {
  List<String> selectedReportList = [];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: MultiChip(
        widget.reportList,
        onSelectionChanged: (selectedList) {
          setState(() {
            selectedReportList = selectedList;
            //widget.selectedReportList.add(selectedList.toString());
            widget.selectedReportList.add(selectedReportList.toString());
          });
          print(widget.selectedReportList);
        },
        maxSelection: 2,
      ),
      actions: [
        MaterialButton(
          child: new Text('Update'),
          onPressed: widget.onPress,
        )
      ],
    );
  }
}

class MultiChip extends StatefulWidget {
  final List<dynamic> reportList;
  final Function(List<dynamic>) onSelectionChanged;
  final int maxSelection;
  MultiChip(this.reportList, {this.maxSelection, this.onSelectionChanged});

  @override
  _MultiChipState createState() => _MultiChipState();
}

class _MultiChipState extends State<MultiChip> {
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              // print(selectedChoices);
            });
            widget.onSelectionChanged(selectedChoices);
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
