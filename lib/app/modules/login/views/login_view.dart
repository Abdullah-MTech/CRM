import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crmnir/utilities/Colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset('assets/logo.png', color: AppColors.primary, width: 66, height: 66,),
                
                const SizedBox(height: 16),

                // Title + subtitle
                const Text(
                  'Sign in',
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
                const SizedBox(height: 24),

                // Email
                TextFormField(
                  controller: c.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: c.validateEmail,
                  decoration: _underlineDecoration(
                    hint: 'Email address or mobile number',
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                Obx(
                  () => TextFormField(
                    controller: c.passwordCtrl,
                    obscureText: c.obscure.value,
                    textInputAction: TextInputAction.done,
                    validator: c.validatePassword,
                    decoration: _underlineDecoration(
                      hint: 'Enter Password',
                      suffix: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          c.obscure.value ? Icons.visibility_off_outlined
                                           : Icons.visibility_outlined,
                          size: 20,
                          color: Colors.black38,
                        ),
                        onPressed: c.toggleObscure,
                      ),
                    ),
                  ),
                ),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: c.onForgotPassword,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Sign in button
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
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Social login label
                const Text(
                  'Sign in using',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Google tile (simple)
                Row(
                  children: [
                    InkWell(
                      onTap: c.signInWithGoogle,
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6FA),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE5E5EA)),
                        ),
                        child: Center(
                          // Replace with your asset if you have one:
                          child:
                           Image.asset('assets/g.png', width: 20, height: 20)
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                
                // Footer
                Text(
                  '© 2025, CRM Sales App. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 12.5,
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
