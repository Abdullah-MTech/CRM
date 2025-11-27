import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';


Future<void> initializeApp() async {
  final HttpClient httpClient = HttpClient();
}


void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('userrecord') ?? '';
    bool isLogin = jsonData.isNotEmpty;
    String initialRoute;
    if (isLogin) {
      initialRoute = Routes.BOTTOMNAV;
    } else {
      initialRoute = Routes.LOGIN;
    }
 
  runApp( MyApp(
    initialRoutes: initialRoute,
  ));
}


class MyApp extends StatelessWidget {
   MyApp({super.key, initialRoute, required this.initialRoutes});
  final String? initialRoutes;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(0.75)),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CRM",
        initialRoute: initialRoutes,
        getPages: AppPages.routes,
      ),
    );
  }
}