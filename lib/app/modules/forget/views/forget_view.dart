import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crmnir/utilities/Colors.dart';

import '../controllers/forget_controller.dart';

class ForgetView extends GetView<ForgetController> {
  const ForgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: c.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'We will send you a message to set or reset your new password.',
                  style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.35),
                ),

                const SizedBox(height: 28),

                // Email / phone
                TextFormField(
                  controller: c.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: c.validateEmailOrPhone,
                  decoration: _underlineDecoration(
                    hint: 'Email address or mobile number',
                  ),
                ),

                const SizedBox(height: 22),

                // Submit button
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
                      'Submit Mail',
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
      ),
    );
  }

  InputDecoration _underlineDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      hintStyle: const TextStyle(color: Colors.black38),
      suffixIcon: suffix,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE5E5EA)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.4),
      ),
      contentPadding: const EdgeInsets.only(top: 14, bottom: 8),
    );
  }
}
