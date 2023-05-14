import 'package:flutter/cupertino.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/models/to_do_task_model.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataModel userData;
  UserTodoTaskModel userTodoTaskModel;
  String userName;
  String userEmail;
  String userPassword;
  int foodTypeId;
  int customPlanStatusCode;
  bool networkConnection;
  int itemCount;
  double height;
  String gender;
  String everydayMobility;
  String gymMember;
  String exerciseType;
  String bodyType;
  String sevenMinuteExercise;
  String dietType;
  String canControlWhenFood;
  String preoccupied;
  String canControlWhenFreeFood;
  String canControlWhenEatingAroundMe;
  String failedDueToCraving;
  String stressedEating;
  String eatWhenSad;
  String eatWhenLonely;
  String eatWhenBored;
  String eatInLargePortion;
  String eatWhileWatchingTv;
  String eatWhenNothingToDo;
  String drinkLessWater;
  String freeNightMunching;
  String likedRes;
  int weightGoal;
  int sleepingHours;
  int currentWeight;
  int howOfterYouGoToGym;
  List<String> favCuisines = [];
  List<String> dislikedCuisines = [];
  List<String> dislikedFood = [];
  List<String> foodCraving = [];
  List<String> medicalCondition = [];
  updateSleepingHours(int value) {
    sleepingHours = value;
    notifyListeners();
  }

  updateLikedRes(String value) {
    likedRes = value;
    notifyListeners();
  }

  updateCanControlWhenFood(String value) {
    canControlWhenFood = value;
    notifyListeners();
  }

  updateHowOfterYouGoToGym(int value) {
    howOfterYouGoToGym = value;
    notifyListeners();
  }

  updatePreoccupied(String value) {
    preoccupied = value;
    notifyListeners();
  }

  updateCanControlWhenFoodFree(String value) {
    canControlWhenFreeFood = value;
    notifyListeners();
  }

  updateCanControlWhenFoodAround(String value) {
    canControlWhenEatingAroundMe = value;
    notifyListeners();
  }

  updateFailedDueToCraving(String value) {
    failedDueToCraving = value;
    notifyListeners();
  }

  updateEatWhenSad(String value) {
    eatWhenSad = value;
    notifyListeners();
  }

  updateEatWhenLonely(String value) {
    eatWhenLonely = value;
    notifyListeners();
  }

  updateEatWhenBored(String value) {
    eatWhenBored = value;
    notifyListeners();
  }

  updateEatInLargePortion(String value) {
    eatInLargePortion = value;
    notifyListeners();
  }

  updateStressedEating(String value) {
    stressedEating = value;
    notifyListeners();
  }

  updateEatWhileWatchingTv(String value) {
    eatWhileWatchingTv = value;
    notifyListeners();
  }

  updateEatWhenNothingToDo(String value) {
    eatWhenNothingToDo = value;
    notifyListeners();
  }

  updateDrinkLessWater(String value) {
    drinkLessWater = value;
    notifyListeners();
  }

  updateFreeNightMunching(String value) {
    freeNightMunching = value;
    notifyListeners();
  }

  updateHeight(double value) {
    height = value;
    notifyListeners();
  }

  updateEverydayMobility(String value) {
    everydayMobility = value;
    notifyListeners();
  }

  updateGymMember(String value) {
    gymMember = value;
    notifyListeners();
  }

  updateExerciseType(String value) {
    exerciseType = value;
    notifyListeners();
  }

  updateBodyType(String value) {
    bodyType = value;
    notifyListeners();
  }

  updatesevenMinuteExercise(String value) {
    sevenMinuteExercise = value;
    notifyListeners();
  }

  updateDietType(String value) {
    dietType = value;
    notifyListeners();
  }

  updateGender(String value) {
    gender = value;
    notifyListeners();
  }

  updateUserName(String name) {
    userName = name;
    notifyListeners();
  }

  updateUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  updateUserPassword(String pss) {
    userPassword = pss;
    notifyListeners();
  }

  updateWeightGoal(int value) {
    weightGoal = value;
    notifyListeners();
  }

  updateCurrentWeight(int value) {
    currentWeight = value;
    notifyListeners();
  }

  updateFavCuisines(List<String> value) {
    favCuisines = value;
    notifyListeners();
  }

  updateDislikedFood(List<String> value) {
    dislikedFood = value;
    notifyListeners();
  }

  updateDislikedCuisines(List<String> value) {
    dislikedCuisines = value;
    notifyListeners();
  }

  updateFoodCravingList(List<String> value) {
    foodCraving = value;
    notifyListeners();
  }

  updateMedicalCondition(List<String> value) {
    medicalCondition = value;
    notifyListeners();
  }

  setAllTasks(UserTodoTaskModel data) {
    userTodoTaskModel = data;
  }

  setTodoTask(int index) {
    userTodoTaskModel.tasks[index].completed =
        !userTodoTaskModel.tasks[index].completed;
    notifyListeners();
  }

  void setUserData(UserDataModel user) {
    userData = user;
    print('setUserData method ${user.user.id}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    notifyListeners();
  }

  void setTypeId(int id) {
   
    foodTypeId = id;
    notifyListeners();
   
  }

  void setCustomPlanStatusCode(int code) {
    customPlanStatusCode = code;
    notifyListeners();
  }

  setnetworkConnection(bool con) {
    networkConnection = con;
    notifyListeners();
  }
}
