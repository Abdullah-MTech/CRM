import 'package:crmnir/Services/ApiClient.dart';
import 'package:crmnir/app/Models/calls.dart';
import 'package:crmnir/utilities/Api.dart';
import 'package:get/get.dart';


class CallsController extends GetxController {
  // 0 = All, 1 = Missed
  final selectedTab = 0.obs;

  // data + state
  final calls = <CallModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;

  // inject your dio service here
  final HttpService httpService = HttpService();

  @override
  void onInit() {
    super.onInit();
    fetchCalls();
  }

  Future<void> fetchCalls() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // This should call GET {baseUrl}{getCallsLog}
      final response = await httpService.get(Api.getCallsLog);

      final body = response.data;
      if (body is! Map<String, dynamic>) {
        hasError.value = true;
        return;
      }

      final logResponse = CallLogResponse.fromJson(body);

      if (!logResponse.success) {
        hasError.value = true;
        return;
      }

      final List<CallModel> all = [];

      // incoming
      for (final dto in logResponse.incomingCalls) {
        all.add(dto.toIncomingCallModel());
      }

      // outgoing
      for (final dto in logResponse.outgoingCalls) {
        all.add(dto.toOutgoingCallModel());
      }

      // Sort by time desc (latest first)
      all.sort((a, b) => b.time.compareTo(a.time));

      calls.assignAll(all);
    } catch (e) {
      hasError.value = true;
      // log e somewhere if you want
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshCalls() async {
    await fetchCalls();
  }

  List<CallModel> get filteredCalls {
    if (selectedTab.value == 1) {
      // "Missed" tab -> status == "no answer"
      return calls.where((c) => c.missed).toList();
    }
    return calls;
  }

  void setTab(int idx) => selectedTab.value = idx;

  // placeholder for future actions
  void playRecording(CallModel model) {
    // If there's no recording from API, do nothing
    if (model.recordingId == null || model.recordingId!.isEmpty) return;

    // TODO: integrate your audio player / API using model.recordingId
    // Example: _recordingService.playRecording(model.recordingId!)
  }

  void callNumber(String number) {
    // TODO: integrate url_launcher or native dialer
  }
}
