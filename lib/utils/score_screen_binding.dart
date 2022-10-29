import 'package:get/get.dart';
 

import '../controller/score_screen_controller.dart';

class ScoreScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ScoreScreenController());
   }
}
