import 'package:get/get.dart';

import '../controllers/lead_s_controller.dart';

class LeadSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadSController>(
      () => LeadSController(),
    );
  }
}
