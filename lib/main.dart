import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:quiz_app/utils/quiz_screen_binding.dart';
import 'package:quiz_app/utils/score_screen_binding.dart';
import 'package:quiz_app/view/quiz_screens/quiz_screen.dart';
import 'package:quiz_app/view/score_screen/score_screen.dart';
import 'package:quiz_app/view/username/username_page.dart';

import 'utils/usrname_screen_binding.dart';
import 'view/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(color: whiteColor, fontSize: 20),
          headline2: TextStyle(color: whiteColor, fontSize: 20),
          bodyText2: TextStyle(color: whiteColor, fontSize: 20),
          subtitle1: TextStyle(color: whiteColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            counterStyle: TextStyle(color: whiteColor),
            focusColor: whiteColor,
            fillColor: whiteColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightPurpleColor, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: whiteColor, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            hintStyle: TextStyle(color: whiteColor)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/UserNamePage",
      getPages: [
        GetPage(name: "/", page: () => UserNamePage()),
        GetPage(
            name: "/UserNamePage",
            page: () => UserNamePage(),
            binding: UsernameBinding()),
        GetPage(
            name: "/QuizScreen",
            page: () => QuizScreen(),
            binding: QuizScreenBinding()),
        GetPage(
            name: "/ScoreScreen",
            page: () => ScoreScreen(),
            binding: ScoreScreenBinding()),
      ],
    );
  }
}
