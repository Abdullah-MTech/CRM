import 'package:crmnir/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:crmnir/utilities/Colors.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    // 4 identical pages: same title & image as the first screen in your design
    const pages = [
      _IntroPage(title: 'More than just \nan Inbox', imageAsset: 'assets/1.png'),
      _IntroPage(title: 'More than just \nan Inbox', imageAsset: 'assets/1.png'),
      _IntroPage(title: 'More than just \nan Inbox', imageAsset: 'assets/1.png'),
      _IntroPage(title: 'More than just \nan Inbox', imageAsset: 'assets/1.png'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Slides
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: pages,
              ),
            ),

            const SizedBox(height: 6),

            // Dot indicators (4 small circles)
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final active = controller.pageIndex.value == i;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active ? Colors.black87 : Colors.black26,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 28),

            // Primary "Sign in"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  }, // hook up later
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Apple sign in (outlined)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E5EA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  }, // hook up later
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.apple, size: 20, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Sign in with Apple',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Footer link
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(Routes.SIGNUP);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  final String title;
  final String imageAsset;

  const _IntroPage({
    required this.title,
    required this.imageAsset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          // Image dead-center in the PageView viewport
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
              height: 260, // tweak if needed
            ),
          ),

          // Help icon in the top-right
          Positioned(
            right: 0,
            top: 0,
            child: SafeArea(
              bottom: false,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline_rounded, color: Colors.black87),
                tooltip: 'Help',
              ),
            ),
          ),

          // Title near the top (doesn't affect image centering)
          Positioned(
            left: 0,
            right: 0,
            top: 64, // adjust to match your mock
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                height: 1.25,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
