import 'dart:convert';

import 'package:crmnir/Services/ApiClient.dart';
import 'package:crmnir/Services/AuthServices.dart';
import 'package:crmnir/app/Models/Login.dart';
import 'package:crmnir/app/routes/app_pages.dart';
import 'package:crmnir/utilities/Api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

    final HttpService httpService = HttpService();
  RxBool loader = false.obs;
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

  Future<void> submit() async {
    try {
      loader.value = true;
      final response = await HttpService().post(
        Api.login,
        {
          "email": emailCtrl.text,
          "password": passwordCtrl.text,
        },
      );
      if (response.statusCode == 200) {
       AuthResponse data = AuthResponse.fromJson(response.data);
        // Handle successful login
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('token', data.token.toString());
        AuthServices.setAuthBearerToken(data.token.toString());
        prefs.setString('userrecord', jsonEncode(data.toJson()));
        // Save the user data to shared preferences
     
        
        Get.offAllNamed(Routes.BOTTOMNAV);
        
        print('Login successful: ${response.data}');
        Get.snackbar("Login successful", "Welcome",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 1));
      } else {
        // Handle login failure
        
          Get.snackbar("Login failed", response.data['message'],
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 3));
        
        print("executing login...");
        print('Login failed: ${response.data}');
        // Get.snackbar("Login failed", data.message, backgroundColor: Colors.red, colorText: Colors.white, duration: const Duration(seconds: 3));
      }
    } catch (error) {
      // Handle error
      print('Login error: $error');
    } finally {
      loader.value = false;
    }
     
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
