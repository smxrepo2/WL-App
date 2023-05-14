

import 'package:flutter/material.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/screens/SettingScreen/exercise_setting.dart';

class RadioList extends StatefulWidget {
  final List<FruitsList> listname;
  final Function() onPress;
  String radioItem;
  RadioList({this.listname, this.onPress, this.radioItem});

  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  String radioItem = '';

  // Group Value for Radio Button.
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hello"),
      content: Container(
        height: 120.0,
        child: Column(
          children: widget.listname
              .map((data) => RadioListTile(
                    title: Text("${data.name}"),
                    groupValue: id,
                    value: data.index,
                    onChanged: (val) {
                      setState(() {
                        widget.radioItem = data.name;
                        id = data.index;
                        // widget.radioItem=radioItem;
                      });
                    },
                  ))
              .toList(),
        ),
      ),
      actions: [
        MaterialButton(
          child: new Text('Update'),
          onPressed: widget.onPress,
          // onPressed: () {
          //   setState(() {
          //     updateMinExercise(radioItem);
          //     Navigator.pop(context,true);
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => ExerciseSetting()));
          //   });
          // Navigator.pop(context,true);
          //},
        )
      ],
    );
  }
}

class RadioPage extends StatefulWidget {
  final String title;
  final Function() onPress;
RadioPage({this.title,this.onPress});

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Yes",
    ),
    FruitsList(
      index: 2,
      name: "No",
    ),
  ];
  int _selected;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        MaterialButton(
          child: const Text('Update'),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: widget.onPress
            //widget.onOk();

        ),
      ],
      content: SingleChildScrollView(
        child: Container(
          width: 100,
          //width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: fList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                          title: Text(fList[index].name),
                          value: index,
                          groupValue: _selected,
                          onChanged: (value) {
                            setState(() {
                              _selected = index;
                            });
                          });
                    }),
            ],
          ),
        ),
      ),
    );
  }
}

class FruitsList {
  String name;
  int index;
  FruitsList({this.name, this.index});
}
