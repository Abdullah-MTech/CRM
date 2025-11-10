import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:crmnir/app/routes/app_pages.dart';

class OnboardingController extends GetxController {

 final List<Map<String, String>> steps = const [
    {'title': 'Generate', 'subtitle': 'your quest in seconds.'},
    {'title': 'Complete', 'subtitle': 'fun, meaningful activities'},
    {'title': 'Earn', 'subtitle': 'points and track progress.'},
  ];

  // Second onboarding: Points system content
  final List<String> pointsTitle = const ['Earn Points,', 'Stay Engaged.'];

  final String pointsSubtitleParen = '(Points System)';

  final List<String> pointsItems = const [
    'Unlock rewards as you level \nup',
    'Keep track of your streaks and\nmilestones',
    'Compete with friends or climb\nthe leaderboard',
    'Stay motivated with\nachievements and badges',
  ];

  // PageView state for the two onboarding pages
  final pageController = PageController();
  final RxInt pageIndex = 0.obs; // 0: steps, 1: points 2: logo

  void onPageChanged(int index) {
    pageIndex.value = index;
  }

  void next() {
    if (pageIndex.value < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void completeOnboarding() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isFirstTime', false);
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
