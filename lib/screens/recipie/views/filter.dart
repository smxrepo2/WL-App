import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> categories = ['Breakfast', 'Lunch', 'Snacks', 'Dinner', 'All'];
  int _selectedCategory = 4;

  List<String> cusines = ['Pakistani', 'Indian', 'Italian', 'Chinese', 'All'];
  int _selectedCusine = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Filters',
          style: TextStyle(
              fontSize: 22, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 12, bottom: 12),
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'Clear All',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                side: BorderSide(
                  color: Colors.grey[500],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Text('Category',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ),
          SizedBox(height: 10),
          SelectTabs(list: categories, selectedIndex: 4),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Text('Cusine',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ),
          SizedBox(height: 10),
          SelectTabs(list: cusines, selectedIndex: 0),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Text('Food Contents',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ),
          SizedBox(height: 10),
          FoodContent(
            title: 'Carbs',
            content: 30,
          ),
          FoodContent(
            title: 'Fat',
            content: 45,
          ),
          FoodContent(
            title: 'Protein',
            content: 47,
          ),
          FoodContent(
            title: 'Calorie',
            content: 10,
          ),
          FoodContent(
            title: 'Sodium',
            content: 20,
          )
        ],
      ),
    );
  }
}

class FoodContent extends StatefulWidget {
  FoodContent({Key key, this.title, this.content}) : super(key: key);

  String title;
  int content;

  @override
  State<FoodContent> createState() => _FoodContentState();
}

class _FoodContentState extends State<FoodContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${widget.content}/100',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
            child: SliderTheme(
              data: SliderThemeData(
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                trackHeight: 0.5,
              ),
              child: Slider(
                value: widget.content.toDouble(),
                min: 0,
                max: 100,
                thumbColor: Colors.grey[500],
                activeColor: Colors.grey[500],
                inactiveColor: Colors.grey[400],
                onChanged: (value) {
                  setState(() {
                    widget.content = value.toInt();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectTabs extends StatefulWidget {
  SelectTabs({Key key, this.list, this.selectedIndex}) : super(key: key);

  List<String> list;
  int selectedIndex;

  @override
  State<SelectTabs> createState() => _SelectTabsState();
}

class _SelectTabsState extends State<SelectTabs> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int index = 0; index < widget.list.length; index++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
              child: Text(
                widget.list[index],
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: widget.selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: widget.selectedIndex == index
                        ? Colors.white
                        : Colors.grey),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: widget.selectedIndex == index
                    ? Colors.blueAccent
                    : Colors.white,
                fixedSize: Size(100, 27.5),
                minimumSize: Size.zero,
                side: BorderSide(
                  color: widget.selectedIndex == index
                      ? Colors.blueAccent
                      : Colors.grey[500],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
