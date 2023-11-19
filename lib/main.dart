import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey[900],
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Quiz(),
      )),
    ),
  ));
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool selectedAnswer) {
    setState(() {
      if (quizBrain.isFinished() == false) {
        if (selectedAnswer == quizBrain.getQuestionAnswer()) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      } else {
        _onBasicAlertPressed(context);
        quizBrain.reset();
        scoreKeeper.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 5,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                quizBrain.getQuestionText(),
                style: const TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ))),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: TextButton(
            onPressed: () {
              checkAnswer(true);
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
            child: const Text(
              "True",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text(
                "False",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Row(children: scoreKeeper)
      ],
    );
  }
}

_onBasicAlertPressed(context) {
  Alert(
    context: context,
    title: "Finished",
    desc: "You've Reached The End Of The Quiz.",
  ).show();
}
