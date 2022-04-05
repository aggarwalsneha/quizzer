class Question{
  String? questionText;
  bool? questionAnswer;

  Question({required this.questionText,required this.questionAnswer});



  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['question'],
      questionAnswer: json['correct_answer'],
    );
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['question'],
      questionAnswer: map['correct_answer'],
    );
  }
}

