import 'package:get/get.dart';
import 'package:quiz_app/controller/username_page_controller.dart';

class UsernameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UsernamePageController());
  }
}
