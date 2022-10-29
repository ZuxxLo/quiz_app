class QuestionModel {
  int id, answer;
  String question;
  List<String> options;
  QuestionModel(
      {required this.id,
      required this.answer,
      required this.question,
      required this.options});
  QuestionModel.copy(this.id, this.answer, this.question, this.options);

 }
