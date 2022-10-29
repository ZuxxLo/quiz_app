import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/view/colors.dart';

import '../../controller/quiz_screen_controller.dart';
import '../my_widgets.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);
  final QuizScreenController quizScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: AlignmentDirectional.center, children: [
        const LottieBackground(),
        ////background containers ta7t
        Positioned(
          bottom: 30,
          child: Container(
            height: 100,
            width: screenWidth * 0.85,
            decoration: BoxDecoration(
              color: blueGreyColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        ////background containers ta7t
        Positioned(
          bottom: 20,
          child: Container(
            height: 100,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
              color: blueGreyColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),

        ///// content
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 60, 15, 40),
          child: Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                SizedBox(
                    width: double.maxFinite,
                    child:
                        Lottie.asset("assets/meteor.json", fit: BoxFit.cover)),
                Positioned(
                  top: 160,
                  child: SizedBox(
                    width: screenWidth * 1.3,
                    child: Lottie.asset("assets/shootingStar.json",
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    width: screenWidth * 1.3,
                    child: Lottie.asset("assets/sparklings.json",
                        fit: BoxFit.cover),
                  ),
                ),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  // top padding
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [NumberOfQuestions(), PlayerScore()],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      // GetBuilder<QuizScreenController>(builder: (context) {
                      //   for (var i = 0; i < 10; i++) {
                      //     return TweenAnimationBuilder(
                      //       duration: Duration(
                      //           seconds:
                      //               quizScreenController.getSecondsLeftToAnswer +
                      //                   1),
                      //       tween: quizScreenController.tween,
                      //       builder: (BuildContext context, double value,
                      //           Widget? child) {
                      //         return CircularProgressIndicator(
                      //           value: value,
                      //           strokeWidth: 2,
                      //           color: whiteColor,
                      //         );
                      //       },
                      //     );
                      //   }
                      //   return Text("data");
                      // }),
                      GetBuilder<QuizScreenController>(builder: (context) {
                        return CircularProgressIndicator(
                          value: quizScreenController.getSecondsLeftToAnswer
                                  .toDouble() /
                              10,
                          strokeWidth: 2,
                          color: whiteColor,
                        );
                      }),
                      GetBuilder<QuizScreenController>(builder: (context) {
                        return Text(quizScreenController.getSecondsLeftToAnswer
                            .toString());
                      }),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.035,
                  ),
                  SizedBox(
                    height: screenHeight * 0.55,
                    child: GetBuilder<QuizScreenController>(builder: (context) {
                      return PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: quizScreenController.pageController,
                        itemCount: quizScreenController.getQuestionList.length,
                        itemBuilder: (BuildContext context, int indexx) =>
                            Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                quizScreenController
                                    .getQuestionList[indexx].question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              direction: Axis.vertical,
                              spacing: 20,
                              children: List<Widget>.generate(
                                4,
                                (index) => GetBuilder<QuizScreenController>(
                                    builder: (context) {
                                  return TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: quizScreenController
                                              .getRightColor(index),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                    ),
                                    onPressed: () {
                                      if (quizScreenController.getIsPressed) {
                                      } else {
                                        // so that no one spam
                                        quizScreenController.setIsPressed =
                                            true;
                                        // get user's answer to compare it
                                        quizScreenController.setUserAnswer =
                                            index;

                                        quizScreenController.toNextQuestion();
                                        quizScreenController
                                            .playerScoreIncrement(index);
                                      }
                                    },
                                    //the option from the question model
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: screenWidth * 0.8,
                                      height: screenHeight * 0.05,
                                      child: Text(
                                        quizScreenController
                                            .getQuestionList[indexx]
                                            .options[index],
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  //skip and score button
                  GetBuilder<QuizScreenController>(builder: (context) {
                    return MyButton(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.5,
                        title: quizScreenController.getNumberOfQuestions == 9
                            ? "Score ! "
                            : "Skip",
                        function: () {
                          if (quizScreenController.getSkipIsPressed) {
                          } else {
                            // so that no one spam
                            quizScreenController.setSkipIsPressed = true;

                            quizScreenController.toNextQuestion();
                          }
                        });
                  })
                ]),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class NumberOfQuestions extends StatelessWidget {
  NumberOfQuestions({
    Key? key,
  }) : super(key: key);
  final QuizScreenController quizScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<QuizScreenController>(builder: (context) {
          return Text(
            "${quizScreenController.getNumberOfQuestions + 1}",
          );
        }),
        const Icon(
          Icons.question_mark,
          color: whiteColor,
        ),
      ],
    );
  }
}

class PlayerScore extends StatelessWidget {
  PlayerScore({
    Key? key,
  }) : super(key: key);
  final QuizScreenController quizScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<QuizScreenController>(builder: (context) {
          return Text(
            quizScreenController.getPlayerScore.toString(),
          );
        }),
        const Icon(
          Icons.auto_awesome,
          color: whiteColor,
        ),
      ],
    );
  }
}
