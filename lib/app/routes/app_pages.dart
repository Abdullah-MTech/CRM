import 'package:get/get.dart';

import '../modules/bottomnav/bindings/bottomnav_binding.dart';
import '../modules/bottomnav/views/bottomnav_view.dart';
import '../modules/calls/bindings/calls_binding.dart';
import '../modules/calls/views/calls_view.dart';
import '../modules/forget/bindings/forget_binding.dart';
import '../modules/forget/views/forget_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lead/bindings/lead_binding.dart';
import '../modules/lead/views/lead_view.dart';
import '../modules/leadS/bindings/lead_s_binding.dart';
import '../modules/leadS/views/lead_s_view.dart';
import '../modules/leaddetails/bindings/leaddetails_binding.dart';
import '../modules/leaddetails/views/leaddetails_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/recent/bindings/recent_binding.dart';
import '../modules/recent/views/recent_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/success_view.dart';
import '../modules/verify/views/verify_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGET,
      page: () => const ForgetView(),
      binding: ForgetBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => const VerifyView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS,
      page: () => const SuccessView(),
    ),
    GetPage(
      name: _Paths.CALLS,
      page: () => const CallsView(),
      binding: CallsBinding(),
    ),
    GetPage(
      name: _Paths.LEAD,
      page: () => const LeadView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: _Paths.LEAD_S,
      page: () => const LeadSView(),
      binding: LeadSBinding(),
    ),
    GetPage(
      name: _Paths.LEADDETAILS,
      page: () => const LeaddetailsView(),
      binding: LeaddetailsBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMNAV,
      page: () => BottomnavView(),
      binding: BottomnavBinding(),
    ),
    GetPage(
      name: _Paths.RECENT,
      page: () => const RecentView(),
      binding: RecentBinding(),
    ),
  ];
}
