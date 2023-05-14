import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/mind_screens/models/added_mind_model.dart';
import 'package:weight_loser/screens/mind_screens/models/custom_mind_model.dart';

class addedmindlistprovider extends ChangeNotifier {
  AddedMindPlanItem _data = new AddedMindPlanItem();

  setListItem(VideosData burner) {
    _data.mindList.add(burner);
    notifyListeners();
  }

  setAddedItemId(int id) {
    _data.mindListId.add(id);
    notifyListeners();
  }

  deleteAll() {
    _data.mindList.clear();
    notifyListeners();
  }

  deleteAllItemId() {
    _data.mindListId.clear();
    notifyListeners();
  }

  List<VideosData> getMindList() {
    return this._data.mindList;
  }

  List<int> getMindListId() {
    return this._data.mindListId;
  }

  deleteAddedMind(int id) {
    //_data.foodList
    this
        ._data
        .mindList
        .removeWhere((element) => int.parse(element.id.toString()) == id);
    print("Length after removal:" + _data.mindList.length.toString());
    notifyListeners();
  }

  deleteAddedMindId(int id) {
    //_data.foodList
    this._data.mindListId.removeWhere((element) => element == id);
    print("Length after removal:" + _data.mindList.length.toString());
    notifyListeners();
  }
}
