import 'package:sahashop_customer/app_customer/model/quiz.dart';

class Question {
  Question({
    this.questionId,
    this.question,
    this.questionImage,
    this.answers,
  });

  int? questionId;
  String? question;
  String? questionImage;
  Answers? answers;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"] == null ? null : json["question_id"],
    question: json["question"] == null ? null : json["question"],
    questionImage: json["question_image"] == null ? null : json["question_image"],
    answers: json["answers"] == null ? null : Answers.fromJson(json["answers"]),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId == null ? null : questionId,
    "question": question == null ? null : question,
    "question_image": questionImage == null ? null : questionImage,
    "answers": answers == null ? null : answers!.toJson(),
  };
}