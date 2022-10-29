import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/quiz_screen_binding.dart';
import '../view/quiz_screens/quiz_screen.dart';

String userName = "";
bool musicOn = true;
  final audioPlayer = AudioPlayer();

class UsernamePageController extends GetxController {
  Future startAudio() async {
    audioPlayer.play(AssetSource('amongUsBackgroundMusic.mp3'));
    audioPlayer.setVolume(1);

    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  TextEditingController? usernameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  get getUsername => usernameController?.text;

  usernameInput(String? value) {
    usernameController?.text = value!;
    userName = value!;
  }

  musicOnOff() {
    musicOn = !musicOn;
    update();
  }

  playQuizValidate() {
    if (formKey.currentState!.validate()) {
       Get.off(() => QuizScreen(), binding: QuizScreenBinding());
    }
  }

  @override
  void onInit() {
    audioPlayer.release();
    startAudio();
    super.onInit();
  }

  @override
  void onClose() {
    usernameController?.dispose();

    super.onClose();
  }
}
