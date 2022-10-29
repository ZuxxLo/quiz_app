import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/username_page_controller.dart';
import '../my_widgets.dart';

class UserNamePage extends StatelessWidget {
  UserNamePage({Key? key}) : super(key: key);
  final UsernamePageController usernameController = Get.find();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: AlignmentDirectional.center, children: [
        const LottieBackground(),
        Align(
          alignment: Alignment.topLeft,
          child: GetBuilder<UsernamePageController>(builder: (context) {
            return IconButton(
                onPressed: () {
                  if (musicOn) {
                    audioPlayer.release();
                  } else {
                    usernameController.startAudio();
                  }
                  usernameController.musicOnOff();
                },
                icon: musicOn
                    ? const Icon(
                        Icons.music_note,
                        size: 50,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.music_off,
                        size: 50,
                        color: Colors.white,
                      ));
          }),
        ),
        Align(
          alignment: Alignment.topCenter,
          heightFactor: 3,
          child: SizedBox(
            width: 500,
            child: Lottie.asset(
              "assets/quizlogo.json",
            ),
          ),
        ),
        Center(child: TextFileds()),
        Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 6,
          child: MyButton(
              height: 60,
              width: 130,
              title: "Join Quiz",
              function: () {
                usernameController.playQuizValidate();
              }),
        )
      ]),
    );
  }
}

class TextFileds extends StatelessWidget {
  TextFileds({
    Key? key,
  }) : super(key: key);
  final UsernamePageController usernameController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Form(
        key: usernameController.formKey,
        child: TextFormField(
          maxLength: 10,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter a username";
            } else if (value.length > 20) {
              return "Username can't be larger than 20 letter";
            } else if (value.length < 3) {
              return "Username can't be less than 3 letter";
            }
            return null;
          },
          // onFieldSubmitted: (value) {
          //   if (usernameController.formKey.currentState!.validate()) {}
          // },
          onChanged: (value) {
            usernameController.usernameInput(value);
          },
          decoration: const InputDecoration(
            hintText: 'Username',
          ),
        ),
      ),
    );
  }
}
