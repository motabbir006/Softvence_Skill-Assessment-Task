import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'features/onboarding_screens/onboarding_page.dart';

import 'dart:async';
import 'dart:ui';

void main() {
  // Global Error Handling
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    // You can also log error to a service like Sentry or Firebase Crashlytics here
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint("Global Async Error: $error");
    // Prevent app from crashing
    return true; 
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:Size (360, 800),
      builder: (context, child)=> GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: OnboardingPage(),
      ),
    );
  }
}

