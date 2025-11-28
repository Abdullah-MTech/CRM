import 'package:get/get.dart';

import '../controllers/callinterface_controller.dart';

class CallinterfaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallinterfaceController>(
      () => CallinterfaceController(),
    );
  }
}
