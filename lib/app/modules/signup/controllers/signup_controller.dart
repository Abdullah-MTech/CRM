import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();

  final obscure = true.obs;
  final agree = false.obs;

  void toggleObscure() => obscure.toggle();
  void toggleAgree() => agree.toggle();

  String? validateRequired(String? v) {
    if ((v ?? '').trim().isEmpty) return 'Required field';
    return null;
  }

  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? v) {
    if ((v ?? '').isEmpty) return 'Password is required';
    if ((v ?? '').length < 6) return 'Minimum 6 characters';
    return null;
  }

  void submit() {
    
    // if (formKey.currentState?.validate() != true) return;

  }

  void openTos() => Get.snackbar('Terms of Service', 'Open ToS page');
  void openPrivacy() => Get.snackbar('Privacy Policy', 'Open Privacy page');
  void goToLogin() => Get.back(); // or Get.toNamed('/login')

  @override
  void onClose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    super.onClose();
  }
}
