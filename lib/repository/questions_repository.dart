import 'package:get/get.dart';

import '../Provider/laravel_provider.dart';
import '../screens/Questions_screen/models/all_questions_model.dart';

class QuestionRepository {
  LaravelApiClient _laravelApiClient;

  QuestionRepository() {
    _laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<GetAllQuestionsModel> getAllQuestions() {
    return _laravelApiClient.getAllQuestions();
  }

  Future<AddGenderQuestionResponseModel> addGenderQuestion(
      AddGenderQuestionRequestModel requestModel) {
    return _laravelApiClient.addGenderQuestion(requestModel);
  }

  Future<AddHeightQuestionResponseModel> addHeightQuestion(
      AddHeightQuestionRequestModel requestModel) {
    return _laravelApiClient.addHeightQuestion(requestModel);
  }

  Future<AddWeightQuestionResponseModel> addWeightQuestion(
      AddWeightQuestionRequestModel requestModel) {
    return _laravelApiClient.addWeightQuestion(requestModel);
  }

  Future<AddGoalWeightQuestionResponseModel> addGoalWeightQuestion(
      AddGoalWeightQuestionRequestModel requestModel) {
    return _laravelApiClient.addGoalWeightQuestion(requestModel);
  }

  Future<AddDOBQuestionResponseModel> addDOBQuestion(
      AddDOBQuestionRequestModel requestModel) {
    return _laravelApiClient.addDOBQuestion(requestModel);
  }

  Future<AddAgeQuestionResponseModel> addAgeQuestion(
      AddAgeQuestionRequestModel requestModel) {
    return _laravelApiClient.addAgeQuestion(requestModel);
  }

  Future<AddSleepHourQuestionResponseModel> addSleepHourQuestion(
      AddSleepHourQuestionRequestModel requestModel) {
    return _laravelApiClient.addSleepHourQuestion(requestModel);
  }

  Future<AddEatTypeQuestionResponseModel> addEatTypeQuestion(
      AddEatTypeQuestionRequestModel requestModel) {
    return _laravelApiClient.addEatTypeQuestion(requestModel);
  }

  Future<AddCousinQuestionResponseModel> addCousinQuestion(
      AddCousinQuestionRequestModel requestModel) {
    return _laravelApiClient.addFavouriteCousinQuestion(requestModel);
  }

  Future<AddFavouriteRestaurantQuestionResponseModel> addFavouriteRestaurant(
      AddFavouriteRestaurantQuestionRequestModel requestModel) {
    return _laravelApiClient.addFavouriteRestaurantQuestion(requestModel);
  }

  Future<AddMedicalConditionQuestionResponseModel> addMedicalCondition(
      AddMedicalConditionQuestionRequestModel requestModel) {
    return _laravelApiClient.addMedicalConditionQuestion(requestModel);
  }

  Future<AddRestrictedFoodQuestionResponseModel> addRestrictedFood(
      AddRestrictedFoodQuestionRequestModel requestModel) {
    return _laravelApiClient.addRestrictedFoodQuestion(requestModel);
  }

  Future<AddWaterHabitQuestionResponseModel> addWaterHabit(
      AddWaterHabitQuestionRequestModel requestModel) {
    return _laravelApiClient.addWaterHabitQuestion(requestModel);
  }

  Future<AddLessSleepQuestionResponseModel> addLessSleep(
      AddLessSleepQuestionRequestModel requestModel) {
    return _laravelApiClient.addLessSleepQuestion(requestModel);
  }

  Future<AddEnduranceQuestionResponseModel> addEndurance(
      AddEnduranceQuestionRequestModel requestModel) {
    return _laravelApiClient.addEnduranceQuestion(requestModel);
  }

  Future<AddGymRoutineQuestionResponseModel> addGymRoutine(
      AddGymRoutineQuestionRequestModel requestModel) {
    return _laravelApiClient.addGymRoutine(requestModel);
  }

  Future<AddMobilityQuestionResponseModel> addMobility(
      AddMobilityQuestionRequestModel requestModel) {
    return _laravelApiClient.addMobility(requestModel);
  }

  Future<AddFoodControlQuestionResponseModel> addFoodControl(
      AddFoodControlQuestionRequestModel requestModel) {
    return _laravelApiClient.addFoodControl(requestModel);
  }

  Future<AddFoodThinkingQuestionResponseModel> addFoodThinking(
      AddFoodThinkingQuestionRequestModel requestModel) {
    return _laravelApiClient.addFoodThinking(requestModel);
  }

  Future<AddPastDietsQuestionResponseModel> addPastDiets(
      AddPastDietsQuestionRequestModel requestModel) {
    return _laravelApiClient.addPastDiets(requestModel);
  }

  Future<AddEatStressedQuestionResponseModel> addEatStressed(
      AddEatStressedQuestionRequestModel requestModel) {
    return _laravelApiClient.addEatStressed(requestModel);
  }

  Future<AddEatBoredQuestionResponseModel> addEatBored(
      AddEatBoredQuestionRequestModel requestModel) {
    return _laravelApiClient.addEatBored(requestModel);
  }

  Future<AddEatQuickerQuestionResponseModel> addEatQuicker(
      AddEatQuickerQuestionRequestModel requestModel) {
    return _laravelApiClient.addEatQuicker(requestModel);
  }

  Future<AddEatSnacksQuestionResponseModel> addEatSnacks(
      AddEatSnacksQuestionRequestModel requestModel) {
    return _laravelApiClient.addEatSnacks(requestModel);
  }

  Future<AddMindCategoryResponseModel> addMindCategory(
      AddMindCategoryRequestModel requestModel) {
    return _laravelApiClient.addMindCategory(requestModel);
  }

  Future<AddPaymentConfirmationResponseModel> addPaymentConfirmation(
      AddPaymentConfirmationRequestModel requestModel) {
    return _laravelApiClient.addPaymentConfirmation(requestModel);
  }
}
