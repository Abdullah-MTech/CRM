import 'package:crmnir/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  final length = 6;

  late final List<TextEditingController> otpCtrls;
  late final List<FocusNode> otpNodes;

  @override
  void onInit() {
    otpCtrls = List.generate(length, (_) => TextEditingController());
    otpNodes = List.generate(length, (_) => FocusNode());
    super.onInit();
  }

  void onChanged(int i, String v) {
    // Only keep first character (defense in depth)
    if (v.length > 1) {
      otpCtrls[i].text = v.characters.first;
      otpCtrls[i].selection = TextSelection.fromPosition(
        TextPosition(offset: otpCtrls[i].text.length),
      );
    }

    if (v.isNotEmpty) {
      // Move to next
      if (i < length - 1) {
        FocusScope.of(Get.context!).requestFocus(otpNodes[i + 1]);
      } else {
        FocusScope.of(Get.context!).unfocus();
      }
    } else {
      // Backspace to previous when empty
      if (i > 0) {
        FocusScope.of(Get.context!).requestFocus(otpNodes[i - 1]);
      }
    }
  }

  String get code => otpCtrls.map((e) => e.text).join();

  void submit() {
    // final value = code;
    // if (value.length != length) {
    //   Get.snackbar('Error', 'Enter the $length-digit code',
    //       snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }
    Get.toNamed(Routes.SUCCESS);
  
    // Get.snackbar('Code entered', value, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    for (final c in otpCtrls) {
      c.dispose();
    }
    for (final n in otpNodes) {
      n.dispose();
    }
    super.onClose();
  }
}
