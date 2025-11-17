import 'package:crmnir/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crmnir/utilities/Colors.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.85),
              AppColors.primary.withOpacity(0.15),
              Colors.white,
            ],
            stops: const [0.0, 0.55, 0.9],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              // Icon circle
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  // color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/check.png',),
              ),
              const SizedBox(height: 28),
              const Text(
                'Registeration Successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),

              // Get Started
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      
                     Get.offAllNamed(Routes.SPLASH);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
