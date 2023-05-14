import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

bool isDevelopmentMode = true;

const apiUrl = "https://weightchoper.somee.com";
const imageBaseUrl = "https://weightchoper.somee.com/staticfiles/images/";
const videosBaseUrl = "https://weightchoper.somee.com/staticfiles/videos/";
const apiHeaders = {
  'Content-Type': 'application/json',
  'Connection': 'keep-alive',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept': '*/*',
  'User-Agent': 'PostmanRuntime/7.28.4',
  'Cookie':
      '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
};
//const videosBaseUrl="https://excercisevideos.s3.amazonaws.com/";

/// API's Url
const String apiBaseUrl = "https://weightchoper.somee.com/api/";

///Question urls
const String getQuestionUrl = "Questionair";

const String addGenderQuestionUrl = "user/gender";
const String addHeightQuestionUrl = "user/Height";
const String addWeightQuestionUrl = "user/Weight";
const String addGoalWeightQuestionUrl = "user/GoalWeight";
const String addDOBQuestionUrl = "user/dob";
const String addAgeQuestionUrl = "user/age";
const String addSleepHourQuestionUrl = "user/Sleep"; //Todo: Not available Done
const String addFoodTypeQuestionUrl =
    "user/FoodType"; //Todo: Not available  Done
const String addCousinQuestionUrl = "user/Cusine";
const String addFavouriteRestaurantQuestionUrl = "user/Restaurant";
const String addMedicalConditionQuestionUrl = "user/medical";
const String addRestrictedFoodQuestionUrl = "user/AllergicFood";
const String addWaterHabitQuestionUrl = "user/WaterHabit/";
const String addLessSleepQuestionUrl =
    "user/SevenSleeping"; //Todo: Not available Done
const String addEnduranceQuestionUrl = "user/MinExercise/"; //Not available
const String addGymRoutineQuestionUrl = "user/Routine/";
const String addMobilityQuestionUrl =
    "user/LifeStyle"; //Todo: Not available Done
const String addFoodControlQuestionUrl =
    "user/Control/"; //Todo: Not available Done
const String addFoodThinkingQuestionUrl =
    "user/Sad/"; //Todo: Not available Done
const String addPastDietQuestionUrl =
    "user/CraveFood/"; //Todo: Not available Done
const String addEatStressedQuestionUrl =
    "user/Stress/"; //Todo: Not available Done

const String addEatBoardQuestionUrl = "user/Bored/"; // Todo: Not available Done
const String addEatQuickerQuestionUrl =
    "user/EatingRound/"; //Todo :Not available Done
const String addEatSnacksQuestionUrl =
    "user/LateNight/"; //Todo: Not available Done

const String addMindCategoryUrl = "user/MindCategory/";

const String addPaymentConfirmationUrl = "user/Payment";

/*[5:32 pm, 20/01/2023] +92 323 8462067: const String addSleepHourQuestionUrl ="user/sleepHour";  = Add sleep Goal
[5:51 pm, 20/01/2023] +92 323 8462067: const String addFoodControlQuestionUrl ="user/FoodControl";  // add control mind
[5:54 pm, 20/01/2023] +92 323 8462067: const String addEatStressedQuestionUrl ="user/EatStressed";  //add stress mind

[6:34 pm, 20/01/2023] +92 323 8462067: const String addLessSleepQuestionUrl ="user/lessSleep";  //add seven sleep
[6:34 pm, 20/01/2023] +92 323 8462067: const String addMobilityQuestionUrl ="user/Mobility";  //add mobility
[6:10 pm, 20/01/2023] +92 323 8462067: const String addFoodThinkingQuestionUrl ="user/FoodThinking";  // add sad mind
[5:58 pm, 20/01/2023] +92 323 8462067: const String addPastDietQuestionUrl ="user/PastDiet";  // add carve mind
[5:55 pm, 20/01/2023] +92 323 8462067: const String addEatBoardQuestionUrl ="user/EatBoard";  //add bored mind
[6:12 pm, 20/01/2023] +92 323 8462067: const String addEatQuickerQuestionUrl ="user/EatQuicker";  //Add EatingRound Mind
[6:06 pm, 20/01/2023] +92 323 8462067: const String addEatSnacksQuestionUrl ="user/EatSnacks";  //add latenigh mind

[6:14 pm, 20/01/2023] +92 323 8462067: const String addEnduranceQuestionUrl ="user/Endurance";  //Not available
[6:14 pm, 20/01/2023] +92 323 8462067: @Mohsin Flutter  yr yeh wala knsa question hy?

*/

Stream<bool> connection() async* {
  bool connectionValue;
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    print(result);
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      connectionValue = true;
    } else
      connectionValue = false;
  });
  yield connectionValue;
}

Future<File> getVideoThumb(String url) async {
  final fileName = await VideoThumbnail.thumbnailFile(
    video: url,
    thumbnailPath: (await getExternalStorageDirectory()).path,
    imageFormat: ImageFormat.JPEG,
    quality: 100,
  );
  return File(fileName);
}
