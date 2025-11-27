import 'package:crmnir/app/Models/calls.dart';
import 'package:get/get.dart';

class LeaddetailsController extends GetxController {
  final leadName = 'Ronald Richards'.obs;
  final leadAvatar = 'assets/profile.png'.obs;
  final leadSource = 'Google Ads'.obs;
  final leadAddress = 'Washington Ave'.obs;
  final leadPhone = '+44 161 464 0360'.obs;
  final leadLine = 'US Sales'.obs;
  final leadLineNumber = '+1 415 555 0139'.obs;
  final timeRange = 'Between 2:00 - 4:00 PM'.obs;
  final status = 'Done'.obs;

  final total = 250.0.obs;
  final parts = 100.0.obs;
  final profit = 150.0.obs;

  final notes = ''.obs;

  final communications = <CallModel>[
    CallModel(
      nameOrNumber: '+44 161 464 0360',
      line: 'US Sales',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 23, 33),
      duration: const Duration(seconds: 30),
      direction: CallDirection.incoming,
    ),
    CallModel(
      nameOrNumber: 'Ronald Richards',
      line: 'US Sales',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 23, 33),
      duration: const Duration(seconds: 30),
      direction: CallDirection.outgoing,
    ),
    CallModel(
      nameOrNumber: 'Floyd Miles',
      line: 'UK Support',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 23, 33),
      duration: const Duration(minutes: 3),
      direction: CallDirection.incoming,
    ),
  ].obs;

  void updateNotes(String value) {
    notes.value = value;
  }

  void onTapStatus() {}

  void onTapBack() {
    Get.back();
  }

  void onTapFilter() {}

  void onTapCall(String number) {}

  void onTapPlay(CallModel model) {}
}
