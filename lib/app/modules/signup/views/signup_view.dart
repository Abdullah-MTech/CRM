import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crmnir/utilities/Colors.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

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
              children: [
                // Top row: logo left, "Have an account? Sign in" right
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,

                      alignment: Alignment.center,
                      child: Image.asset('assets/logo.png', color: AppColors.primary, width: 66, height: 66,),
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        text: 'Have an account? ',
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = c.goToLogin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Title + subtitle
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'to access CRM Mail',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 22),

                _label('User Name*'),
                TextFormField(
                  controller: c.usernameCtrl,
                  textInputAction: TextInputAction.next,
                  validator: c.validateRequired,
                  decoration: _boxDecoration(hint: '@crmgmail.com'),
                ),
                const SizedBox(height: 14),

                _label('Email*'),
                TextFormField(
                  controller: c.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: c.validateEmail,
                  decoration: _boxDecoration(),
                ),
                const SizedBox(height: 14),

                _label('Password*'),
                Obx(
                  () => TextFormField(
                    controller: c.passwordCtrl,
                    obscureText: c.obscure.value,
                    textInputAction: TextInputAction.next,
                    validator: c.validatePassword,
                    decoration: _boxDecoration(
                      suffix: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          c.obscure.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: Colors.black38,
                        ),
                        onPressed: c.toggleObscure,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                _label('First Name*'),
                TextFormField(
                  controller: c.firstNameCtrl,
                  textInputAction: TextInputAction.next,
                  validator: c.validateRequired,
                  decoration: _boxDecoration(),
                ),
                const SizedBox(height: 14),

                _label('Last Name*'),
                TextFormField(
                  controller: c.lastNameCtrl,
                  textInputAction: TextInputAction.done,
                  validator: c.validateRequired,
                  decoration: _boxDecoration(),
                ),

                const SizedBox(height: 18),

                // Primary button (label kept as per mock)
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
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Terms checkbox
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: c.agree.value,
                        onChanged: (_) => c.toggleAgree(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(color: Color(0xFFBDBDC2)),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = c.openTos,
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = c.openPrivacy,
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }

  static InputDecoration _boxDecoration({String? hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.black38),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primary, width: 1.4),
      ),
    );
  }
}
