import 'question.dart';

class HistorySubmit {
  HistorySubmit({
    this.id,
    this.storeId,
    this.quizId,
    this.customerId,
    this.workTime,
    this.totalQuestions,
    this.totalCorrectAnswer,
    this.totalWrongAnswer,
    this.createdAt,
    this.updatedAt,
    this.historySubmitQuizzes,
  });

  int? id;
  int? storeId;
  int? quizId;
  int? customerId;
  int? workTime;
  int? totalQuestions;
  int? totalCorrectAnswer;
  int? totalWrongAnswer;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<HistorySubmitQuizz>? historySubmitQuizzes;

  factory HistorySubmit.fromJson(Map<String, dynamic> json) => HistorySubmit(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    quizId: json["quiz_id"] == null ? null : json["quiz_id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    workTime: json["work_time"] == null ? null : json["work_time"],
    totalQuestions: json["total_questions"] == null ? null : json["total_questions"],
    totalCorrectAnswer: json["total_correct_answer"] == null ? null : json["total_correct_answer"],
    totalWrongAnswer: json["total_wrong_answer"] == null ? null : json["total_wrong_answer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    historySubmitQuizzes: json["history_submit_quizzes"] == null ? null : List<HistorySubmitQuizz>.from(json["history_submit_quizzes"].map((x) => HistorySubmitQuizz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "store_id": storeId == null ? null : storeId,
    "quiz_id": quizId == null ? null : quizId,
    "customer_id": customerId == null ? null : customerId,
    "work_time": workTime == null ? null : workTime,
    "total_questions": totalQuestions == null ? null : totalQuestions,
    "total_correct_answer": totalCorrectAnswer == null ? null : totalCorrectAnswer,
    "total_wrong_answer": totalWrongAnswer == null ? null : totalWrongAnswer,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "history_submit_quizzes": historySubmitQuizzes == null ? null : List<dynamic>.from(historySubmitQuizzes!.map((x) => x.toJson())),
  };
}

class HistorySubmitQuizz {
  HistorySubmitQuizz({
    this.rightAnswer,
    this.answerRequest,
    this.isValid,
    this.answerA,
    this.answerB,
    this.answerC,
    this.answerD,
    this.question,
  });

  String? rightAnswer;
  String? answerRequest;
  bool? isValid;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  Question? question;

  factory HistorySubmitQuizz.fromJson(Map<String, dynamic> json) => HistorySubmitQuizz(
    rightAnswer: json["right_answer"] == null ? null : json["right_answer"],
    answerRequest: json["answer_request"] == null ? null : json["answer_request"],
    isValid: json["is_valid"] == null ? null : json["is_valid"],
    answerA: json["answer_a"] == null ? null : json["answer_a"],
    answerB: json["answer_b"] == null ? null : json["answer_b"],
    answerC: json["answer_c"] == null ? null : json["answer_c"],
    answerD: json["answer_d"] == null ? null : json["answer_d"],
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
  );

  Map<String, dynamic> toJson() => {
    "right_answer": rightAnswer == null ? null : rightAnswer,
    "answer_request": answerRequest == null ? null : answerRequest,
    "is_valid": isValid == null ? null : isValid,
    "answer_a": answerA == null ? null : answerA,
    "answer_b": answerB == null ? null : answerB,
    "answer_c": answerC == null ? null : answerC,
    "answer_d": answerD == null ? null : answerD,
    "question": question == null ? null : question!.toJson(),
  };
}

