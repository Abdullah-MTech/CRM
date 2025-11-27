import 'package:crmnir/app/modules/bottomnav/controllers/bottomnav_controller.dart';
import 'package:crmnir/app/modules/calls/controllers/calls_controller.dart';
import 'package:crmnir/app/modules/calls/views/calls_view.dart';
import 'package:crmnir/app/modules/home/controllers/home_controller.dart';
import 'package:crmnir/app/modules/lead/controllers/lead_controller.dart';
import 'package:crmnir/app/modules/lead/views/lead_view.dart';
import 'package:crmnir/app/modules/leadS/views/lead_s_view.dart';
import 'package:crmnir/app/routes/app_pages.dart';
import 'package:crmnir/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';


class BottomnavView extends GetView<BottomnavController> {
  BottomnavView({super.key});

  final List<Widget> pages = [
    HomeView(),
    LeadSView(),
    CallsView(),
    LeadView(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(LeadSView());
    Get.put(LeadController());
    Get.put(CallsController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      extendBody: true,
      body: Obx(
        () => IndexedStack(index: controller.tabIndex.value, children: pages),
      ),
      // floatingActionButton: FloatingActionButton(
        
      //   backgroundColor: AppColors.primary,
      //   onPressed: () {
      //      Get.toNamed(Routes.NQUEST);
      //   },
      //   child: const Icon(Icons.add, size: 32),
      //   shape: const CircleBorder(),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0, -2), // Shadow position
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          elevation: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navItem(Icons.home, 0),
                navItem(Icons.search, 1),
                // const SizedBox(width: 40, ),
                navItem(Icons.emoji_events, 2),
                navItem(Icons.person, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, int index) {
    return Obx(() {
      final isSelected = controller.tabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTabIndex(index),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey,
          size: 28,
        ),
      );
    });
  }
}
