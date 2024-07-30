import 'package:sahashop_customer/app_customer/model/history_submit.dart';

import 'question.dart';

class Quiz {
  Quiz({
    this.id,
    this.storeId,
    this.trainCourseId,
    this.title,
    this.shortDescription,
    this.minute,
    this.show,
    this.autoChangeOrderQuestions,
    this.autoChangeOrderAnswer,
    this.defineSortAnswers,
    this.createdAt,
    this.updatedAt,
    this.questions,
    this.lastSubmitQuiz,
  });

  int? id;
  int? storeId;
  int? trainCourseId;
  String? title;
  String? shortDescription;
  int? minute;
  bool? show;
  bool? autoChangeOrderQuestions;
  bool? autoChangeOrderAnswer;
  String? defineSortAnswers;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Question>? questions;
  HistorySubmit? lastSubmitQuiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        trainCourseId:
            json["train_course_id"] == null ? null : json["train_course_id"],
        title: json["title"] == null ? null : json["title"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        defineSortAnswers: json["define_sort_answers"] == null
            ? null
            : json["define_sort_answers"],
        minute: json["minute"] == null ? null : json["minute"],
        show: json["show"] == null ? null : json["show"],
        autoChangeOrderQuestions: json["auto_change_order_questions"] == null
            ? null
            : json["auto_change_order_questions"],
        autoChangeOrderAnswer: json["auto_change_order_answer"] == null
            ? null
            : json["auto_change_order_answer"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
        lastSubmitQuiz: json["last_submit_quiz"] == null
            ? null
            : HistorySubmit.fromJson(json["last_submit_quiz"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "train_course_id": trainCourseId == null ? null : trainCourseId,
        "title": title == null ? null : title,
        "short_description": shortDescription == null ? null : shortDescription,
        "minute": minute == null ? null : minute,
        "show": show == null ? null : show,
        "auto_change_order_questions":
            autoChangeOrderQuestions == null ? null : autoChangeOrderQuestions,
        "auto_change_order_answer":
            autoChangeOrderAnswer == null ? null : autoChangeOrderAnswer,
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Answers {
  Answers({
    this.a,
    this.b,
    this.c,
    this.d,
  });

  String? a;
  String? b;
  String? c;
  String? d;

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        a: json["A"] == null ? null : json["A"],
        b: json["B"] == null ? null : json["B"],
        c: json["C"] == null ? null : json["C"],
        d: json["D"] == null ? null : json["D"],
      );

  Map<String, dynamic> toJson() => {
        "A": a == null ? null : a,
        "B": b == null ? null : b,
        "C": c == null ? null : c,
        "D": d == null ? null : d,
      };
}
