import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/view/score_screen/score_screen.dart';

import '../view/colors.dart';

// globale var cuz we need it
int playerScore = 0;

class QuizScreenController extends GetxController {
  int _numberOfQuestions = 0;
  int _secondsLeftToAnswer = 10;
  Tween<double> tween = Tween(begin: 1.0, end: 0.0);

  bool _isPressed = false;
  bool _skipIsPressed = false;

  int _userAnswer = 5;

  List<QuestionModel> _finalQuestionList = [];
  final List<QuestionModel> _questionList = [
    QuestionModel(
        id: 1,
        answer: 1,
        question: "Algeria is a ___ society",
        options: ["great", "failed", "good", "siuuuuu"]),
    QuestionModel(
        id: 2,
        answer: 0,
        question:
            "Which language has the more native speakers: English or Spanish?",
        options: ["Spanish", "English", "Chinese", "Arabic"]),
    QuestionModel(
        id: 3,
        answer: 0,
        question:
            "What was the name of the crime boss who was head of the feared Chicago Outfit?",
        options: ["Al Capone", "Diego", "Didin clash", "El chapo"]),
    QuestionModel(
        id: 4,
        answer: 3,
        question: "Which planet has the most moons?",
        options: ["Mars", "Zomoroda", "Earth", "Saturn"]),
    QuestionModel(
        id: 5,
        answer: 2,
        question: "do you believe in zodiac signs",
        options: ["Yes", "Yes", "Ofc No", "Yes,im dumb"]),
    QuestionModel(
        id: 6,
        answer: 2,
        question: "How to say 'yes' in french",
        options: ["Yes", "Si", "Oui", "Da"]),
    QuestionModel(
        id: 7,
        answer: 3,
        question: "In what country is the Chernobyl nuclear plant located?",
        options: ["Algeria", "Romania", "Russia", "Ukraine"]),
    QuestionModel(
        id: 8,
        answer: 1,
        question: "How many elements are in the periodic table? ",
        options: ["117", "118", "119", "177"]),
    QuestionModel(
        id: 9,
        answer: 1,
        question: "How many languages are written from right to left?",
        options: ["7", "12", "77", "2"]),
    QuestionModel(
        id: 10,
        answer: 0,
        question: "How long is an Olympic swimming pool (in meters)?",
        options: ["50 ", "60", "100", "120"]),
    QuestionModel(
        id: 11,
        answer: 3,
        question:
            "What is the name of the biggest technology company in South Korea?",
        options: ["Xiaomi", "Apple", "Condor", "Samsung"]),
    QuestionModel(
        id: 12,
        answer: 0,
        question: "Which animal can be seen on the Porsche logo?",
        options: ["Horse", "Cat", "Lion", "Dog"]),
    QuestionModel(
        id: 13,
        answer: 0,
        question: "Whats Cristiano Ronaldo celebration?",
        options: ["Siuuuu", "nonono", "Rock a baby!", "dance"]),
  ];

  late PageController pageController;

  get getPlayerScore => playerScore;
  set setPlayerScore(int value) => playerScore = value;

  get getSecondsLeftToAnswer => _secondsLeftToAnswer;
  set setSecondsLeftToAnswer(secondsLeftToAnswer) =>
      _secondsLeftToAnswer = secondsLeftToAnswer;

  get getNumberOfQuestions => _numberOfQuestions;
  set setNumberOfQuestions(value) => _numberOfQuestions = value;

  get getQuestionList => _finalQuestionList;
  set setQuestionList(questionList) => _finalQuestionList = questionList;

  get getIsPressed => _isPressed;
  set setIsPressed(value) => _isPressed = value;

  get getUserAnswer => _userAnswer;
  set setUserAnswer(int value) => _userAnswer = value;

  get getSkipIsPressed => _skipIsPressed;
  set setSkipIsPressed(value) => _skipIsPressed = value;

  initFinalList() {
    Set<int> setOfInts = {};
    int random;
    while (setOfInts.length < 10) {
      random = Random().nextInt(13);
      if (setOfInts.contains(random)) {
      } else {
        setOfInts.add(random);
      }
    }
    for (int i = 0; i < 10; i++) {
      _finalQuestionList.add(_questionList[setOfInts.last]);
      setOfInts.remove(setOfInts.last);
    }
  }

  playerScoreIncrement(index) {
    if (_isPressed) {
      if (index == _finalQuestionList[_numberOfQuestions].answer) {
        playerScore += 10;
        update();
      }
    }
  }

  numberOfQuestionsIncrement() {
    _numberOfQuestions++;
    update();
  }

  toNextQuestion() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_numberOfQuestions < 9) {
          _numberOfQuestions++;
          _secondsLeftToAnswer = 10;
          pageController.animateToPage(_numberOfQuestions,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
          _skipIsPressed = false;
          _isPressed = false;
          _userAnswer = 5;
        } else if (_numberOfQuestions == 9 && _skipIsPressed) {
          Get.off(
            () => ScoreScreen(),
          );
          update();
        }

        update();
      },
    );
  }

  buttonPressed() {
    _isPressed = true;
    update();
  }

  skipPressed() {
    _skipIsPressed = true;
    update();
  }

  timer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // last question to stop the timer
        if (_numberOfQuestions == 9 && _secondsLeftToAnswer == 0) {
          timer.cancel();
          _isPressed = true;
        }
        // reset seconds and move to next quesiton
        else if (_secondsLeftToAnswer == 0 && _numberOfQuestions < 9) {
          toNextQuestion();
          _secondsLeftToAnswer = 10;
          update();
        }
        // decrement seconds displayed

        else if (_secondsLeftToAnswer != 0) {
          _secondsLeftToAnswer--;
          update();
        }
      },
    );
  }

  Color getRightColor(index) {
    if (_isPressed || _skipIsPressed || _secondsLeftToAnswer == 0) {
      if (index == _finalQuestionList[_numberOfQuestions].answer) {
        return greenColor;
      } else if (index == _userAnswer &&
          _userAnswer != _finalQuestionList[_numberOfQuestions].answer) {
        return redColor;
      }
    }

    return blueGreyColor;
  }

  @override
  void onInit() {
    // init playerscore for new round
    playerScore = 0;
    initFinalList();
    pageController = PageController(initialPage: 0);
    timer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
