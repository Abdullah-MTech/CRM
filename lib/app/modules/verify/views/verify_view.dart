import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:crmnir/utilities/Colors.dart';

import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              // Logo
              Container(
                width: 56,
                height: 56,
               
                alignment: Alignment.center,
                child: Image.asset('assets/logo.png', color: AppColors.primary, width: 66, height: 66,),
              ),
              const SizedBox(height: 22),

              // Title & subtitle
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'We will send you a code at you mail to set or reset\nyour new password.',
                style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.35),
              ),

              const SizedBox(height: 18),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  c.length,
                  (i) => Padding(
                    padding: EdgeInsets.only(right: i == c.length - 1 ? 0 : 12),
                    child: _OtpBox(index: i),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: c.submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends GetView<VerifyController> {
  final int index;
  const _OtpBox({required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        controller: controller.otpCtrls[index],
        focusNode: controller.otpNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        maxLength: 1,
        inputFormatters:  [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary, width: 1.4),
          ),
        ),
        onChanged: (v) => controller.onChanged(index, v),
        onSubmitted: (_) {
          if (index == controller.length - 1) controller.submit();
        },
      ),
    );
  }
}
