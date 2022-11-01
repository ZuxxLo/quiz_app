import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/utils/usrname_screen_binding.dart';
import 'package:quiz_app/view/username/username_page.dart';

import '../../controller/quiz_screen_controller.dart';
import '../../controller/username_page_controller.dart';
import '../colors.dart';
import '../my_widgets.dart';

class ScoreScreen extends StatelessWidget {
  ScoreScreen({Key? key}) : super(key: key);
  final QuizScreenController scoreScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.center, children: [
        const LottieBackground(),
        Positioned(
            top: 5,
            child: SizedBox(
                width: screenWidth * 1.1,
                child: Lottie.asset(
                  "assets/fire.json",
                ))),
        Container(
            alignment: Alignment.center,
            height: screenHeight * 0.4,
            width: screenWidth * 0.75,
            decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                    width: screenWidth * 1.1,
                    child: Lottie.asset("assets/fire.json", fit: BoxFit.cover)),
                SizedBox(
                    width: screenWidth * 1.1,
                    child: Lottie.asset("assets/sparklings.json",
                        fit: BoxFit.cover)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 50,
                            child: Image.asset(
                              "assets/1st_place.png",
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                            height: 50,
                            child: Image.asset(
                              "assets/2nd_place.png",
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                            height: 50,
                            child: Image.asset(
                              "assets/3rd_place.png",
                              fit: BoxFit.cover,
                            ))
                      ],
                    ),
                    Text(
                      playerScore > 50
                          ? "Congratulations $userName\n Your Score is\n$playerScore/100"
                          : "-_- , $userName\n Your Score is\n$playerScore/100",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ],
            )),
        Positioned(
            bottom: 0,
            child: SizedBox(
              width: screenWidth * 1.5,
              child: Lottie.asset(
                "assets/fireworks.json",
                fit: BoxFit.cover,
              ),
            )),
        // Positioned(
        //     bottom: 200,
        //     child: SizedBox(
        //       width: screenWidth * 2,
        //       child: Lottie.asset("assets/congratulations.json",
        //           repeat: true, fit: BoxFit.cover),
        //     )),
        Positioned(
          top: 130,
          child: InkWell(
            onTap: () {
              Get.off(() => UserNamePage(), binding: UsernameBinding());
            },
            child: const Text(
              "Play again!",
              style: TextStyle(color: whiteColor, fontSize: 30),
            ),
          ),
        ),
      ]),
    );
  }
}
