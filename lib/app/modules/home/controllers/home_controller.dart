import 'package:crmnir/Services/TwilioCallService.dart';
import 'package:get/get.dart';
import 'package:crmnir/app/routes/app_pages.dart';

class HomeController extends GetxController {
  HomeController({TwilioCallService? callService})
      : _callService = callService ?? TwilioCallService.instance;

  final TwilioCallService _callService;

  final selectedActivityTab = 0.obs;

  // From-number (Twilio number) selected by the user.
  final callerId = ''.obs;

  // List of Twilio numbers user can call from.
  final availableCallerIds = <String>[].obs;

  final searchQuery = ''.obs;
  final dialedNumber = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // Load Twilio test config from service.
    availableCallerIds.assignAll(_callService.fromNumbers);

    if (availableCallerIds.isNotEmpty) {
      callerId.value = availableCallerIds.first;
    }


  }

  void selectActivityTab(int index) {
    selectedActivityTab.value = index;
    if (selectedActivityTab.value == 1) {
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
    if (dialedNumber.value.isEmpty) return;
    dialedNumber.value =
        dialedNumber.value.substring(0, dialedNumber.value.length - 1);
  }

  void clearDialer() {
    dialedNumber.value = '';
  }

  void selectCallerId(String? value) {
    if (value == null) return;
    callerId.value = value;
  }

  /// Place the call via Twilio and then go to your /calls screen.
  Future<void> callCurrentNumber() async {
    final fromNumber = callerId.value.trim();
    final toNumber = dialedNumber.value.trim();

    if (fromNumber.isEmpty) {
      Get.snackbar('Caller ID missing', 'No Twilio caller ID is selected.');
      return;
    }

    if (toNumber.isEmpty) {
      Get.snackbar('Number required', 'Type a number before calling.');
      return;
    }

    try {
      await _callService.placeCall(
        from: fromNumber,
        to: toNumber,
      );

      // Navigate to your call screen UI.
      Get.toNamed(Routes.CALLS); // or Get.toNamed('/calls');
    } catch (e) {
      Get.snackbar('Call failed', e.toString());
    }
  }
}
