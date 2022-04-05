import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question.dart';

Future <Question> fetchQuestion() async {
  final response = await http
      .get(Uri.parse('https://opentdb.com/api.php?amount=20&category=9&difficulty=easy&type=boolean'));
    // print(jsonDecode(response.body)[0]);
  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load question');
  }
}


class QuizBrain{
  int _questionNumber=0;

  Future futureQuestion=fetchQuestion();
  final List <Question> _questionBank=[
    Question(questionText: 'SQL stands for Structured Query Language',questionAnswer: true),
    Question(questionText:'Python is an object oriented language.', questionAnswer: true),
    Question(questionText:'Django is based on Java',questionAnswer:false)
  ];
  void nextQuestion()
  {
    if(_questionNumber<_questionBank.length-1) {
       _questionNumber ++;
    }
  }
  String? getQuestionText()
  {
  /*  return FutureBuilder <Question>(
        future: futureQuestion,
        builder: (context, snapshot) {
   if (snapshot.hasData) {
     return Text(snapshot.data!.questionText);
   } else if (snapshot.hasError) {
     return Text('${snapshot.error}');
}
        }
    );*/
    return _questionBank[_questionNumber].questionText;
  }
  bool? getCorrectAnswer()
  {
    return _questionBank[_questionNumber].questionAnswer;
  }
  bool isFinished()
  {
    if(_questionNumber>=_questionBank.length-1)
      {
        return true;
      }
    else
      {
        return false;
      }
  }

  void reset()
  {
    _questionNumber=0;
  }
}