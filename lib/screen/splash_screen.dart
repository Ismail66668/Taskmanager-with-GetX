import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytaskmanager/screen/loging_screen.dart';
import 'package:mytaskmanager/screen/main_bottom_nav_screen.dart';
import 'package:mytaskmanager/ui/auth_controller/auth_controller.dart';
import 'package:mytaskmanager/utils/assets_path.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool loggin = await AuthController.cheackUserLoggding();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              loggin ? const MainBottomNavScreen() : const LogingScreen(),
        ),
        (pat) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: Center(
        child: SvgPicture.asset(AssetsPath.logoSvg),
      ),
    ));
  }
}
