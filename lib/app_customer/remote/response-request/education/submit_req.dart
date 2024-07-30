import 'dart:convert';

SubmitReq submitReqFromJson(String str) => SubmitReq.fromJson(json.decode(str));

String submitReqToJson(SubmitReq data) => json.encode(data.toJson());

class SubmitReq {
  SubmitReq({
    this.workTime,
    this.defineSortAnswers,
    this.answers ,
  });

  int? workTime;
  String? defineSortAnswers;
  List<AnswerReq>? answers = [];

  factory SubmitReq.fromJson(Map<String, dynamic> json) => SubmitReq(
    workTime: json["work_time"] == null ? null : json["work_time"],
    defineSortAnswers: json["define_sort_answers"] == null ? null : json["define_sort_answers"],
    answers: json["answers"] == null ? null : List<AnswerReq>.from(json["answers"].map((x) => AnswerReq.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "work_time": workTime == null ? null : workTime,
    "define_sort_answers": defineSortAnswers == null ? null : defineSortAnswers,
    "answers": answers == null ? null : List<dynamic>.from(answers!.map((x) => x.toJson())),
  };
}

class AnswerReq {
  AnswerReq({
    this.questionId,
    this.answer,
  });

  int? questionId;
  String? answer;

  factory AnswerReq.fromJson(Map<String, dynamic> json) => AnswerReq(
    questionId: json["question_id"] == null ? null : json["question_id"],
    answer: json["answer"] == null ? null : json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId == null ? null : questionId,
    "answer": answer == null ? null : answer,
  };
}
