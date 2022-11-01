import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieBackground extends StatelessWidget {
  const LottieBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: ClipRect(
        // to clip it right
        child: Lottie.asset("assets/spacePurple_background.json",
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.function,
  }) : super(key: key);
  final double height;
  final double width;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 64, 25, 157),
              Color.fromARGB(255, 52, 1, 172),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: ElevatedButton(
            onPressed: () {
              function();
            },
            child: Text(title,style: TextStyle(fontSize:width*0.09 ),)));
  }
}
