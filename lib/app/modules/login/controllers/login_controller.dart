import 'package:crmnir/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final obscure = true.obs;

  void toggleObscure() => obscure.toggle();

  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Email or mobile is required';
    // minimal check; replace with your own
    if (!s.contains('@') && s.length < 8) return 'Enter a valid email/number';
    return null;
    }

  String? validatePassword(String? v) {
    if ((v ?? '').isEmpty) return 'Password is required';
    if ((v ?? '').length < 6) return 'Minimum 6 characters';
    return null;
  }

  void onForgotPassword() {
    // route or dialog
    Get.toNamed(Routes.FORGET);
  }

  void submit() {
    // if (formKey.currentState?.validate() != true) return;
     
  }

  void signInWithGoogle() {
    Get.toNamed(Routes.SIGNUP);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}
