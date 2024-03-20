import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

/* void main() {
  runApp(MyApp());
} */

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'questionText' : 'What\'s your favorite color?',
      'answers': [
        {'text' : 'Black', 'score' : 10},
        {'text' : 'Red', 'score' : 5},
        {'text' : 'Green', 'score' : 3},
        {'text' : 'White', 'score' : 1},
      ]
    },
    {
      'questionText' : 'What\'s your favorite animal?',
      'answers': [
        {'text' : 'Rabbit', 'score' : 10},
        {'text' : 'Snake', 'score' : 5},
        {'text' : 'Elephant', 'score' : 3},
        {'text' : 'Lion', 'score' : 1},
      ]
    },
    {
      'questionText' : 'Who\'s your favorite instructor?',
      'answers': [
        {'text' : 'Max', 'score' : 10},
        {'text' : 'John', 'score' : 5},
        {'text' : 'Tom', 'score' : 3},
        {'text' : 'Jenny', 'score' : 1},
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int answerScore) {
    print(questions.length);
    print(_questionIndex);
    print(answerScore);
    
    setState((){
      _questionIndex++;
    });
    _totalScore += answerScore;

    if(_questionIndex < questions.length) {
      print('We have more questions!');
    } else {
      print('We don\'t have more questions!');
    }

  
  }

  @override
  Widget build(BuildContext ctx) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
          ),
        body: _questionIndex < questions.length 
          ? Quiz(_answerQuestion, questions, _questionIndex)
          : Result(_resetQuiz, _totalScore),
      ),
    );
  }
}