import 'package:get/get.dart';

import '../controllers/leaddetails_controller.dart';

class LeaddetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaddetailsController>(
      () => LeaddetailsController(),
    );
  }
}
