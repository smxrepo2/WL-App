import 'package:flutter/material.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';

List<String> option = ['Yes', 'No'];
int _currentIndex;
Future<String> selectMembership(BuildContext context, String text) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return AlertDialog(
              title: Text(text),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    if (text == "Gym Membership") {
                      updateMembership(option[_currentIndex]).then((value) {
                        Navigator.pop(context, option[_currentIndex]);
                      });
                    } else {
                      updateMinExercise(option[_currentIndex]).then((value) {
                        Navigator.pop(context, option[_currentIndex]);
                      });
                    }
                  },
                  child: Text('OK'),
                ),
              ],
              content: Container(
                width: 130,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: option.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      value: index,
                      groupValue: _currentIndex,
                      title: Text(option[index]),
                      onChanged: (val) {
                        setState2(() {
                          _currentIndex = val;
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      });
}

List<String> bodyType = ['Pear-shaped', 'Apple-shaped', 'Pot Belly'];
Future<String> selectBodyType(BuildContext context, String text) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return AlertDialog(
              title: Text(text),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    updateBodyType(bodyType[_currentIndex]);
                    Navigator.pop(context, bodyType[_currentIndex]);
                  },
                  child: Text('OK'),
                ),
              ],
              content: Container(
                width: 130,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bodyType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      value: index,
                      groupValue: _currentIndex,
                      title: Text(bodyType[index]),
                      onChanged: (val) {
                        setState2(() {
                          _currentIndex = val;
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      });
}

List<String> currentLife = [
  'I am on my feet all day.',
  'I focus on diet and exercise.',
  'I watch my diet, but I am not active.',
  'I am active and do daily exercise,but I cannot control my eating.'
];
Future<String> selectCurrentLife(BuildContext context, String text) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return AlertDialog(
              title: Text(text),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    updateLifeStyle(currentLife[_currentIndex]).then((value) {
                      Navigator.pop(context, currentLife[_currentIndex]);
                    });
                  },
                  child: Text('OK'),
                ),
              ],
              content: Container(
                width: 130,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentLife.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      value: index,
                      groupValue: _currentIndex,
                      title: Text(currentLife[index]),
                      onChanged: (val) {
                        setState2(() {
                          _currentIndex = val;
                          print("_currentIndex" + _currentIndex.toString());
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      });
}
