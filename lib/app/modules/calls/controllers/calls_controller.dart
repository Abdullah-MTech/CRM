import 'package:crmnir/app/data/calls.dart';
import 'package:get/get.dart';

class CallsController extends GetxController {
  // 0 = All, 1 = Missed
  final selectedTab = 0.obs;

  // sample list; replace with API-driven RxList when ready
  final calls = <CallModel>[
    CallModel(
      nameOrNumber: '+44 161 464 0360',
      line: 'US Sales',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 33),
      duration: Duration(minutes: 0, seconds: 30),
      direction: CallDirection.incoming,
    ),
    CallModel(
      nameOrNumber: 'Ronald Richards',
      line: 'US Sales',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 33),
      duration: Duration(minutes: 0, seconds: 30),
      direction: CallDirection.outgoing,
    ),
    CallModel(
      nameOrNumber: 'Floyd Miles',
      line: 'UK Support',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 33),
      duration: Duration(minutes: 0, seconds: 30),
      direction: CallDirection.incoming,
    ),
    CallModel(
      nameOrNumber: '+44 120 545 1290',
      line: 'US Sale',
      phone: '+44 161 464 0360',
      time: DateTime(2022, 10, 31, 2, 33),
      duration: Duration(minutes: 0, seconds: 0),
      direction: CallDirection.missed,
      missed: true,
    ),
  ].obs;

  List<CallModel> get filteredCalls {
    if (selectedTab.value == 1) {
      return calls.where((c) => c.missed == true).toList();
    }
    return calls;
  }

  void setTab(int idx) => selectedTab.value = idx;

  // placeholder for future actions
  void playRecording(CallModel model) {
    // integrate audio player or navigation
    // debugPrint('Play recording for ${model.nameOrNumber}');
  }

  void callNumber(String number) {
    // debugPrint('Call $number');
  }
}
