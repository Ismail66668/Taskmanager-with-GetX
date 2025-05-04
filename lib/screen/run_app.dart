import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytaskmanager/screen/splash_screen.dart';
import 'package:mytaskmanager/controller_binder.dart';

class Taskmanager extends StatefulWidget {
  const Taskmanager({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<Taskmanager> createState() => _TaskmanagerState();
}

class _TaskmanagerState extends State<Taskmanager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      navigatorKey: Taskmanager.navigatorKey,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(12),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  fixedSize: const Size.fromWidth(double.maxFinite))),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              enabledBorder: _zeroborder(),
              errorBorder: _zeroborder(),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              fillColor: Colors.white,
              filled: true)),
      home: const SplashScreen(),
    );
  }

  OutlineInputBorder _zeroborder() {
    return const OutlineInputBorder(borderSide: BorderSide.none);
  }
}
