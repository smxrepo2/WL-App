import 'package:flutter/material.dart';

class SleepHours extends StatefulWidget {
  @override
  _SleepHoursState createState() => _SleepHoursState();
}

class _SleepHoursState extends State<SleepHours> {
  String month, day, year;

  List<String> daysList= ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
  List<String> monthsList= ['1','2','3','4','5','6','7','8','9','10','11','12'];
  List<String> yearsList=[];
  List<String> hoursList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<String> minutesList = [];

  @override
  void initState() {
    // TODO: implement initState
    setYearsList();
    super.initState();
  }

  void setYearsList() {
    DateTime date = DateTime.now();

    for (int i = 1; i <= 60; i++) {
      minutesList.add(i.toString());
    }

   // year = yearsList[0];
    month = date.month.toString();
    day = date.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("What are your sleeping hours?"),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      hint: Center(
                          child: Text(
                        "month",
                      )),
                      isExpanded: true,
                      value: month,
                      icon: SizedBox(),
                      onChanged: (val) {
                        setState(() {
                          month = val;
                        });
                      },
                      items: monthsList
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Container(
                                    width: 100,
                                    child: Text(
                                      item,
                                    )),
                              ))
                          .toList(),
                    ),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      hint: Center(
                          child: Text(
                        "day",
                      )),
                      isExpanded: true,
                      value: day,
                      icon: SizedBox(),
                      onChanged: (val) {
                        setState(() {
                          day = val;
                        });
                      },
                      items: daysList
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Container(
                                    width: 50,
                                    child: Text(
                                      item,
                                    )),
                              ))
                          .toList(),
                    ),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      hint: Center(
                          child: Text(
                        "year",
                      )),
                      isExpanded: true,
                      value: year,
                      icon: SizedBox(),
                      onChanged: (val) {
                        setState(() {
                          year = val;
                        });
                      },
                      items: yearsList
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Container(
                                    width: 50,
                                    child: Text(
                                      item,
                                    )),
                              ))
                          .toList(),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'MM',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "\\",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'DD',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "\\",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'YY',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
                ],
              ),
              ElevatedButton(onPressed: () {}, child: Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}
