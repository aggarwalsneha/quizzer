import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'quiz_brain.dart';
import 'question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

QuizBrain quizBrain=QuizBrain();

void main() {
  runApp(const Quizzer());
}

class Quizzer extends StatelessWidget {
/*  getApiData ()async
  {
    int index=0;
    var url=Uri.parse('https://opentdb.com/api.php?amount=20&category=9&difficulty=easy&type=boolean');
    Response response=await get(url);
    //print(response.statusCode);
    final data=jsonDecode(response.body);
   // print(data['results'][index]['question']);
  }*/
  const Quizzer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   /* getApiData();*/
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black38,
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
            )
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  late Future<Question> futureQuestion;

  @override
  void initState() {
    super.initState();
    futureQuestion = fetchQuestion();
  }

  List <Widget> scoreKeeper=[];
  void checkAnswer (bool userPickedAnswer)
  {
    bool? correctAnswer=quizBrain.getCorrectAnswer();
   setState(() {
      if(quizBrain.isFinished()==true){
        Alert(context: context,title: 'Finished',desc: 'You\'ve reached the end of the quiz').show();
        quizBrain.reset();
        scoreKeeper=[];
      }
      else {
        if (correctAnswer == userPickedAnswer) {
       scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        }

        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
     crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
          padding: const EdgeInsets.all(10.0),
              child:Center(

                child: Text(quizBrain.getQuestionText()!,
                    textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 27.0,
                  color: Colors.white,
                ),),

              )
        )
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
             checkAnswer(true);
              },
              child: const Text('True',
              style:TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ))),
        )),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text('False',
                  style:TextStyle(
                   color: Colors.white,
                    fontSize: 22.0,
                  ))),
        )),
        Row(
          children: scoreKeeper,
        )
      ],
       );
  }
}
