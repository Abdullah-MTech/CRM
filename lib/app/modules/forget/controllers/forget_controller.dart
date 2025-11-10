import 'package:crmnir/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();

  String? validateEmailOrPhone(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Please enter email or mobile number';
    final isEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
    final isPhone = RegExp(r'^\+?[0-9]{7,15}$').hasMatch(s);
    if (!isEmail && !isPhone) return 'Enter a valid email or phone';
    return null;
  }

  void submit() {
    // if (formKey.currentState?.validate() != true) return;
    Get.toNamed(Routes.VERIFY);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    super.onClose();
  }
}
