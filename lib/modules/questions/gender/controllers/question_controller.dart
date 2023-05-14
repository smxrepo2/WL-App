import 'package:get/get.dart';

import '../../../../repository/questions_repository.dart';
import '../../../../screens/Questions_screen/models/all_questions_model.dart';
import '../../../../utils/ui.dart';

class QuestionController extends GetxController {
  final scheduled = false.obs;
  int selectedOption = -1.obs;
  final allQuestions = GetAllQuestionsModel().obs;
  final question = Questoins().obs;
  final options = <String>[].obs;
  QuestionRepository _questionRepository;

  List<Map<String, dynamic>> imageUrl = [
    {
      "gender": "Male",
      "icon":
          'https://cdn-0.emojis.wiki/emoji-pics/microsoft/male-sign-microsoft.png',
    },
    {
      "gender": "Female",
      "icon":
          'https://cdn-0.emojis.wiki/emoji-pics/microsoft/female-sign-microsoft.png',
    },
    {
      "gender": "Non Binary",
      "icon":
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Non-binary_symbol_%28fixed_width%29.svg/1200px-Non-binary_symbol_%28fixed_width%29.svg.png',
    },
  ];

  QuestionController() {
    _questionRepository = QuestionRepository();
  }

  @override
  void onInit() async {
    super.onInit();
    getQuestions();
  }

  void toggleScheduled(value) {
    scheduled.value = value;
  }

  Future getQuestions() async {
    try {
      allQuestions.value = await _questionRepository.getAllQuestions();
      question.value = allQuestions.value.questoins.elementAt(0);

      options.value = question.value.options
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("\"", "")
          .split(",");
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
