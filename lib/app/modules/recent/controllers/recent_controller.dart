// lib/app/modules/recent/controllers/recent_controller.dart

import 'package:crmnir/Services/ApiClient.dart';
import 'package:crmnir/app/Models/People.dart';
import 'package:crmnir/utilities/Api.dart';
import 'package:get/get.dart';


class RecentController extends GetxController {
  final HttpService httpService = Get.find<HttpService>();

  final isLoading = false.obs;
  final hasError = false.obs;
  final recents = <RecentContact>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecentHistory();
  }

  Future<void> fetchRecentHistory({bool isRefresh = false}) async {
    try {
      if (!isRefresh) {
        isLoading.value = true;
      }
      hasError.value = false;

      // This should call GET {baseUrl}{getRecentHistory}
      final response = await httpService.get(Api.getRecentHistory);
      final body = response.data;

      if (body is! List) {
        hasError.value = true;
        return;
      }

      final List<RecentContact> all = [];
      for (final item in body) {
        if (item is Map<String, dynamic>) {
          all.add(RecentContact.fromJson(item));
        }
      }

      recents.assignAll(all);
    } catch (e) {
      hasError.value = true;
      // TODO: log e if needed
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    // Do not show main loading indicator again on pull-to-refresh
    await fetchRecentHistory(isRefresh: true);
  }
}
