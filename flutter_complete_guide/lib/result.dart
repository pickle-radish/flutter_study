import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;

  Result(this.resetQuiz, this.resultScore);

  String get resultPhrase {
    var resultText = 'You did it! $resultScore';
    if(resultScore <= 8) {
      resultText = 'You are awesome and innocent!';
    } else if (resultScore <= 12) {
      resultText = 'Pretty likeable';
    } else if (resultScore <= 16) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad!';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            // resultPhrase,
            resultPhrase,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold
            )
          ),
          TextButton(
            child: Text('Restart Quiz!'),
            onPressed: () => resetQuiz(),
            style: TextButton.styleFrom(primary: Colors.orange)
          ),
          OutlinedButton(
            child: Text('OutlinedButton'),
            onPressed: () => resetQuiz(),
            style: OutlinedButton.styleFrom(primary: Colors.orange, side: BorderSide(color: Colors.blue)),
          )
        ],
      )
    );
  }
}