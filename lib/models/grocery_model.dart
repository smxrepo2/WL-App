class GroceryListModel {
  List<GroceryList> groceryList;
  String startDate;
  String endDate;
  String week;

  GroceryListModel({this.groceryList, this.startDate, this.endDate, this.week});

  GroceryListModel.fromJson(Map<String, dynamic> json) {
    if (json['groceryList'] != null) {
      groceryList = <GroceryList>[];
      json['groceryList'].forEach((v) {
        groceryList.add(new GroceryList.fromJson(v));
      });
    }
    startDate = json['startDate'];
    endDate = json['endDate'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groceryList != null) {
      data['groceryList'] = this.groceryList.map((v) => v.toJson()).toList();
    }
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['week'] = this.week;
    return data;
  }
}

class GroceryList {
  String category;
  List<Items> items;
  String imagePath;
  String startDate;

  GroceryList({this.category, this.items, this.imagePath, this.startDate});

  GroceryList.fromJson(Map<String, dynamic> json) {
    category = json['Category'];
    if (json['Items'] != null) {
      items = <Items>[];
      json['Items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    imagePath = json['ImagePath'];
    startDate = json['StartDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category'] = this.category;
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['ImagePath'] = this.imagePath;
    data['StartDate'] = this.startDate;
    return data;
  }
}

class Items {
  String category;
  String item;
  int planId;
  int listId;
  bool purchased;

  Items({this.category, this.item, this.planId, this.listId, this.purchased});

  Items.fromJson(Map<String, dynamic> json) {
    category = json['Category'];
    item = json['Item'];
    planId = json['PlanId'];
    listId = json['ListId'];
    purchased = json['Purchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category'] = this.category;
    data['Item'] = this.item;
    data['PlanId'] = this.planId;
    data['ListId'] = this.listId;
    data['Purchased'] = this.purchased;
    return data;
  }
}
