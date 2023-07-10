import 'package:get/get.dart';

import '../initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InitialController());
  }
}
