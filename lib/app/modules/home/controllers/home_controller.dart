import 'package:crmnir/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedActivityTab = 0.obs;
  final callerId = '+44 161 464 0360'.obs;
  final searchQuery = ''.obs;
  final dialedNumber = ''.obs;

  void selectActivityTab(int index) {
    selectedActivityTab.value = index;
    if(selectedActivityTab.value == 1){
      Get.toNamed(Routes.LEAD_S);
    }
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void addDigit(String digit) {
    dialedNumber.value = dialedNumber.value + digit;
  }

  void removeLastDigit() {
    if (dialedNumber.value.isEmpty) {
      return;
    }
    dialedNumber.value =
        dialedNumber.value.substring(0, dialedNumber.value.length - 1);
  }

  void clearDialer() {
    dialedNumber.value = '';
  }

  void callCurrentNumber() {
    final numberToCall = dialedNumber.value.isNotEmpty
        ? dialedNumber.value
        : callerId.value;
    // Get.log('Calling $numberToCall');
    Get.toNamed('/calls');
  }
}
