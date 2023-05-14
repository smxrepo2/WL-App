import 'package:flutter/material.dart';
import 'package:weight_loser/models/ChatModel.dart';

class ChatProvider extends ChangeNotifier {
  int chatIndex = 1;

  List<ChatModel> nextChatsList = [
    ChatModel(message: "Hi", isMe: false),
    ChatModel(message: "My name is Kate, whats your name ?", isMe: false),
  ];

  List<ChatModel> chatsList = [
    ChatModel(message: "Hi", isMe: false),
    ChatModel(message: "Thanks for Showing interest in Weight Loser..My name is Kate, whats your name ?", isMe: false),
  ];

  void addChatMessage(ChatModel chatModel) {
    chatsList.add(chatModel);
    notifyListeners();
  }

  void incrementIndex() {
    chatIndex++;
    notifyListeners();
  }

  void decrementIndex() {
    chatIndex--;
    notifyListeners();
  }

  List<ChatModel> suggestionList = [];

  void setSuggestionList(List<ChatModel> list) {
    suggestionList = list;
    notifyListeners();
  }

  List<ChatModel> genderList = [
    ChatModel(message: "♂ MALE", isMe: true),
    ChatModel(message: "♀ FEMALE", isMe: true),
    ChatModel(message: " ⚧ NON BINARY", isMe: true),
  ];

  List<ChatModel> loseWeightList = [
    ChatModel(message: "0.5 libs per week", isMe: true),
    ChatModel(message: "1 libs per week", isMe: true),
    ChatModel(message: "2 libs per week", isMe: true),
  ];

  List<ChatModel> areaSupportList = [
    ChatModel(message: "Late meal snack", isMe: true),
    ChatModel(message: "Boredom eating", isMe: true),
    ChatModel(message: "Stress eating", isMe: true),
    ChatModel(message: "None", isMe: true),
  ];

  List<ChatModel> sittingList = [
    ChatModel(message: "None", isMe: true),
    ChatModel(message: "Some", isMe: true),
    ChatModel(message: "Most of the time", isMe: true),
    ChatModel(message: "I sit all the day", isMe: true),
  ];

  List<ChatModel> giveUpList = [
    ChatModel(message: "When tired", isMe: true),
    ChatModel(message: "Stressed", isMe: true),
    ChatModel(message: "Celebrating", isMe: true),
    ChatModel(message: "Weekends", isMe: true),
    ChatModel(message: "None", isMe: true),
  ];

  List<ChatModel> activityLikeList = [
    ChatModel(message: "Cardio", isMe: true),
    ChatModel(message: "Strength", isMe: true),
    ChatModel(message: "Yoga", isMe: true),
    ChatModel(message: "Running", isMe: true),
    ChatModel(message: "Walking", isMe: true),
  ];

  List<ChatModel> daysWeekWorkoutList = [
    ChatModel(message: "0 to 1", isMe: true),
    ChatModel(message: "2 to 4", isMe: true),
    ChatModel(message: "5 to 6", isMe: true),
    ChatModel(message: "7", isMe: true),
  ];

  List<ChatModel> sependMovingList = [
    ChatModel(message: "Less than 15 minutes", isMe: true),
    ChatModel(message: "15 to 30 minutes", isMe: true),
    ChatModel(message: "Upto 60 minutes", isMe: true),
    ChatModel(message: "More than 60 minutes", isMe: true),
  ];

  List<ChatModel> averageSleepList = [
    ChatModel(message: "Less than 5", isMe: true),
    ChatModel(message: "5 to 6", isMe: true),
    ChatModel(message: "7 to 9", isMe: true),
    ChatModel(message: "More than 9", isMe: true),
  ];

  List<ChatModel> issuesSleepList = [
    ChatModel(message: "I wake up a lot", isMe: true),
    ChatModel(message: "I have trouble falling asleep", isMe: true),
    ChatModel(message: "Can't rest my mind", isMe: true),
    ChatModel(message: "None", isMe: true),
  ];

  void clearSuggestionList() {
    suggestionList.clear();
    notifyListeners();
  }
}
