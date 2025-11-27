import 'dart:io';

import 'package:crmnir/Services/TwilioCallService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

Future<void> initializeApp() async {
  // If you really need a custom HttpClient, set it up here.
  final HttpClient httpClient = HttpClient();
  // Example if you want to override the global client later:
  // HttpOverrides.global = MyHttpOverrides(httpClient);

  // Initialize Twilio once at startup
  await TwilioCallService.instance.ensureInitialized();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String jsonData = prefs.getString('userrecord') ?? '';
  final bool isLogin = jsonData.isNotEmpty;

  final String initialRoute =
      isLogin ? Routes.BOTTOMNAV : Routes.LOGIN;

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.initialRoute,
  });

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(0.75),
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRM',
        initialRoute: initialRoute,
        getPages: AppPages.routes,
      ),
    );
  }
}
