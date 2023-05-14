import 'package:get_it/get_it.dart';
import 'package:weight_loser/Provider/grocerylistProvider.dart';
import 'package:weight_loser/notifications/notificationprovider.dart';
import 'package:weight_loser/screens/Daily%20Log/daily_log_noti_provider.dart';
import 'package:weight_loser/screens/Questions_screen/providers/questions_provider.dart';
import 'package:weight_loser/screens/auth/authenticate/provider/authprovider.dart';
import 'package:weight_loser/screens/auth/authenticate/provider/googleProvider.dart';
import 'package:weight_loser/screens/cbt/cbt_noti_provider.dart';
import 'package:weight_loser/screens/exercise_screens/providers/add_exercise_provider.dart';
import 'package:weight_loser/screens/exercise_screens/providers/customexerciseProvider.dart';
import 'package:weight_loser/screens/food_screens/providers/add_food_provider.dart';
import 'package:weight_loser/screens/food_screens/providers/customdietProvider.dart';
import 'package:weight_loser/screens/groupExercise/providers/exercise_group_provider.dart';
import 'package:weight_loser/screens/groupExercise/providers/user_exercise_provider.dart';
import 'package:weight_loser/screens/mind_screens/providers/add_mind_provider.dart';
import 'package:weight_loser/screens/mind_screens/providers/custommindProvider.dart';
import 'package:weight_loser/screens/navigation_tabs/foodreplacementprov.dart';
import 'package:weight_loser/screens/recipie/provider/favorite_food_provider.dart';
import 'package:weight_loser/screens/recipie/provider/recipe_provider.dart';
import 'package:weight_loser/watches/providers/connected_watch_provider.dart';
import 'package:weight_loser/watches/providers/fitbit_provider.dart';

final GetIt getit = GetIt.instance;

void setup() {
  getit.registerSingleton<sleepnotiprovider>(sleepnotiprovider());
  getit.registerSingleton<dailylognotiprovider>(dailylognotiprovider());
  getit.registerSingleton<favoritefoodprovider>(favoritefoodprovider());
  //getit.registerSingleton<allquestionprovider>(allquestionprovider());
  getit.registerSingleton<customdietprovider>(customdietprovider());
  getit.registerSingleton<questionprovider>(questionprovider());
  getit.registerSingleton<exerciseuserprovider>(exerciseuserprovider());
  getit.registerSingleton<exercisegroupprovider>(exercisegroupprovider());
  getit.registerSingleton<customexerciseprovider>(customexerciseprovider());
  getit.registerSingleton<addedfoodlistprovider>(addedfoodlistprovider());
  getit.registerSingleton<custommindprovider>(custommindprovider());
  getit.registerSingleton<addedmindlistprovider>(addedmindlistprovider());
  getit.registerSingleton<addedexerciselistprovider>(
      addedexerciselistprovider());
  getit.registerSingleton<connectedwatchprovider>(connectedwatchprovider());
  getit.registerSingleton<fitbitActivityprovider>(fitbitActivityprovider());
  getit.registerSingleton<recipeprovider>(recipeprovider());
  getit.registerSingleton<cbtprovider>(cbtprovider());
  getit.registerSingleton<todaylognotiprovider>(todaylognotiprovider());
  getit.registerSingleton<AuthModeprovider>(AuthModeprovider());
  getit.registerSingleton<groceryprovider>(groceryprovider());
  getit.registerSingleton<googleprovider>(googleprovider());
  getit.registerSingleton<replacementnotiprovider>(replacementnotiprovider());
  getit.registerSingleton<waternotiprovider>(waternotiprovider());
  getit.registerSingleton<weightnotiprovider>(weightnotiprovider());
  getit.registerSingleton<selfienotiprovider>(selfienotiprovider());
  getit.registerSingleton<restaurantnotiprovider>(restaurantnotiprovider());
  getit.registerSingleton<mindnotiprovider>(mindnotiprovider());
  getit.registerSingleton<exercisenotiprovider>(exercisenotiprovider());
  //getit.registerSingleton<mindnotiprovider>(mindnotiprovider());
  getit.registerSingleton<earlysnacksnotiprovider>(earlysnacksnotiprovider());
  getit.registerSingleton<breakfastnotiprovider>(breakfastnotiprovider());
  getit.registerSingleton<morningsnacksnotiprovider>(
      morningsnacksnotiprovider());
  getit.registerSingleton<lunchnotiprovider>(lunchnotiprovider());
  getit.registerSingleton<afternoonnotiprovider>(afternoonnotiprovider());
  getit.registerSingleton<dinnernotiprovider>(dinnernotiprovider());
  getit.registerSingleton<snacksnotiprovider>(snacksnotiprovider());
}
