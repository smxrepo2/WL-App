import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../main.dart';
import '../screens/Questions_screen/models/all_questions_model.dart';
import '../utils/AppConfig.dart';
import 'api_provider.dart';

class LaravelApiClient extends GetxService with ApiClient {
  dio.Dio _httpClient;
  // dio.Options _optionsNetwork;
  // dio.Options _optionsCache;

  LaravelApiClient() {
    baseUrl = globalService.global.value.laravelBaseUrl;
    _httpClient = dio.Dio();
  }

  Future<LaravelApiClient> init() async {
/*    if (foundation.kIsWeb || foundation.kDebugMode) {
      _optionsNetwork = dio.Options();
      _optionsCache = dio.Options();
    } else {
      _optionsNetwork =
          buildCacheOptions(Duration(days: 3), forceRefresh: true);
      _optionsCache =
          buildCacheOptions(Duration(minutes: 10), forceRefresh: false);
      _httpClient!.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: getApiBaseUrl(""))).interceptor);
    }*/
    return this;
  }

/*  void forceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      _optionsCache = dio.Options();
    }
  }

  void unForceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      _optionsCache = buildCacheOptions(duration, forceRefresh: false);
    }
  }*/

  // Future<User> login(User user) async {
  //   Uri _uri = getApiBaseUri("login");
  //   Get.log(_uri.toString());
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: json.encode(user.toJson()),
  //   );
  //   if (response.data['success'] == true) {
  //     response.data['data']['auth'] = true;
  //     return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }

  Future<GetAllQuestionsModel> getAllQuestions() async {
    // final response = await get(Uri.parse('$apiUrl/api/Questionair'));

    Uri _uri = getApiBaseUri(getQuestionUrl);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri);

    if (response.statusCode == 200) {
      logger.e("Questions response:" + response.statusCode.toString());
      GetAllQuestionsModel _data =
          GetAllQuestionsModel.fromJson(jsonDecode(response.data));

      //print("Length of foodItems:" + _data.foodList.length.toString());
      return _data;
    } else {
      logger.e("Failed...");
      throw Exception('Failed to load dairy');
    }
  }

/*  Future<AddGenderQuestionResponseModel> addGenderQuestion(AddGenderQuestionRequestModel requestModel) async {
    Uri _uri = getApiBaseUri(addGenderQuestionUrl);
    Get.log("URI :"+_uri.toString());
    var response = await _httpClient.postUri(_uri,data: requestModel.toJson());
    Get.log("Response :"+response.toString());
    if (response.statusCode == 200) {
      logger.e("Questions response:" + response.statusCode.toString());
      AddGenderQuestionResponseModel _data = AddGenderQuestionResponseModel.fromJson(jsonDecode(response.data));
      return _data;
    } else {
      logger.e("Failed...");
      throw Exception('Failed to load dairy');
    }
  }*/

  Future<AddGenderQuestionResponseModel> addGenderQuestion(
      AddGenderQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addGenderQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddGenderQuestionResponseModel _data =
            AddGenderQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddHeightQuestionResponseModel> addHeightQuestion(
      AddHeightQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addHeightQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddHeightQuestionResponseModel _data =
            AddHeightQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddWeightQuestionResponseModel> addWeightQuestion(
      AddWeightQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addWeightQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddWeightQuestionResponseModel _data =
            AddWeightQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddGoalWeightQuestionResponseModel> addGoalWeightQuestion(
      AddGoalWeightQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addGoalWeightQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddGoalWeightQuestionResponseModel _data =
            AddGoalWeightQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddDOBQuestionResponseModel> addDOBQuestion(
      AddDOBQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addDOBQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddDOBQuestionResponseModel _data =
            AddDOBQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddAgeQuestionResponseModel> addAgeQuestion(
      AddAgeQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addAgeQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddAgeQuestionResponseModel _data =
            AddAgeQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddSleepHourQuestionResponseModel> addSleepHourQuestion(
      AddSleepHourQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addSleepHourQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddSleepHourQuestionResponseModel _data =
            AddSleepHourQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddEatTypeQuestionResponseModel> addEatTypeQuestion(
      AddEatTypeQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addFoodTypeQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddEatTypeQuestionResponseModel _data =
            AddEatTypeQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddCousinQuestionResponseModel> addFavouriteCousinQuestion(
      AddCousinQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addCousinQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddCousinQuestionResponseModel _data =
            AddCousinQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddFavouriteRestaurantQuestionResponseModel>
      addFavouriteRestaurantQuestion(
          AddFavouriteRestaurantQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient.post(
          apiBaseUrl + addFavouriteRestaurantQuestionUrl,
          data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddFavouriteRestaurantQuestionResponseModel _data =
            AddFavouriteRestaurantQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddMedicalConditionQuestionResponseModel> addMedicalConditionQuestion(
      AddMedicalConditionQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient.post(
          apiBaseUrl + addMedicalConditionQuestionUrl,
          data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddMedicalConditionQuestionResponseModel _data =
            AddMedicalConditionQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddRestrictedFoodQuestionResponseModel> addRestrictedFoodQuestion(
      AddRestrictedFoodQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addRestrictedFoodQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddRestrictedFoodQuestionResponseModel _data =
            AddRestrictedFoodQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddWaterHabitQuestionResponseModel> addWaterHabitQuestion(
      AddWaterHabitQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addWaterHabitQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddWaterHabitQuestionResponseModel _data =
            AddWaterHabitQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddLessSleepQuestionResponseModel> addLessSleepQuestion(
      AddLessSleepQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addLessSleepQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddLessSleepQuestionResponseModel _data =
            AddLessSleepQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddEnduranceQuestionResponseModel> addEnduranceQuestion(
      AddEnduranceQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addEnduranceQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddEnduranceQuestionResponseModel _data =
            AddEnduranceQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddGymRoutineQuestionResponseModel> addGymRoutine(
      AddGymRoutineQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addGymRoutineQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddGymRoutineQuestionResponseModel _data =
            AddGymRoutineQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddMobilityQuestionResponseModel> addMobility(
      AddMobilityQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addMobilityQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddMobilityQuestionResponseModel _data =
            AddMobilityQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddFoodControlQuestionResponseModel> addFoodControl(
      AddFoodControlQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addFoodControlQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddFoodControlQuestionResponseModel _data =
            AddFoodControlQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddFoodThinkingQuestionResponseModel> addFoodThinking(
      AddFoodThinkingQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addFoodThinkingQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddFoodThinkingQuestionResponseModel _data =
            AddFoodThinkingQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddPastDietsQuestionResponseModel> addPastDiets(
      AddPastDietsQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addPastDietQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddPastDietsQuestionResponseModel _data =
            AddPastDietsQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddEatStressedQuestionResponseModel> addEatStressed(
      AddEatStressedQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addEatStressedQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddEatStressedQuestionResponseModel _data =
            AddEatStressedQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddEatBoredQuestionResponseModel> addEatBored(
      AddEatBoredQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addEatBoardQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddEatBoredQuestionResponseModel _data =
            AddEatBoredQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddEatQuickerQuestionResponseModel> addEatQuicker(
      AddEatQuickerQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addEatQuickerQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddEatQuickerQuestionResponseModel _data =
            AddEatQuickerQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddEatSnacksQuestionResponseModel> addEatSnacks(
      AddEatSnacksQuestionRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addEatSnacksQuestionUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddEatSnacksQuestionResponseModel _data =
            AddEatSnacksQuestionResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddMindCategoryResponseModel> addMindCategory(
      AddMindCategoryRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addMindCategoryUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddMindCategoryResponseModel _data =
            AddMindCategoryResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }

  Future<AddPaymentConfirmationResponseModel> addPaymentConfirmation(
      AddPaymentConfirmationRequestModel requestModel) async {
    try {
      ///Response
      dio.Response response = await _httpClient
          .post(apiBaseUrl + addPaymentConfirmationUrl, data: requestModel);
      logger.i(response.statusCode);

      Get.log("Response :" + response.toString());
      if (response.statusCode == 200) {
        logger.e("Questions response:" + response.statusCode.toString());
        AddPaymentConfirmationResponseModel _data =
            AddPaymentConfirmationResponseModel.fromJson(response.data);
        return _data;
      } else {
        logger.e("Failed...");
        return Future.value(null);
      }
    } on dio.DioError catch (e) {
      logger.e("Exception :" + e.message);
      return Future.value(null);
    }
  }
}
