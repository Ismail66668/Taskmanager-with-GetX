import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytaskmanager/screen/main_bottom_nav_screen.dart';
import 'package:mytaskmanager/screen/regster_screen.dart';
import 'package:mytaskmanager/ui/login_controller.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';
import 'package:mytaskmanager/widgets/snackbar_massage.dart';

import 'forget_password_email_verifay.dart';

class LogingScreen extends StatefulWidget {
  const LogingScreen({super.key});

  @override
  State<LogingScreen> createState() => _LogingScreenState();
}

class _LogingScreenState extends State<LogingScreen> {
  final GlobalKey<FormState> _logingFromKye = GlobalKey<FormState>();
  final TextEditingController _emailTEControllor = TextEditingController();
  final TextEditingController _passwordlTEControllor = TextEditingController();
  final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Form(
          key: _logingFromKye,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 140,
                ),
                const Text(
                  "Get Started With",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEControllor,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _passwordlTEControllor,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'enter a password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<LoginController>(builder: (controller) {
                  return Visibility(
                    visible: controller.loginProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: _onTapLogin,
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: _onTapPorgetPassword,
                          child: const Text(
                            "Forget Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 14),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have no accaunt ?  ",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          GestureDetector(
                              onTap: _onTapSignInButton,
                              child: const Text(
                                "SingUp",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapLogin() {
    if (_logingFromKye.currentState!.validate()) {
      _loging();
    }
  }

  Future<void> _loging() async {
    final bool isSuccess = await _loginController.loging(
        _emailTEControllor.text.trim(), _passwordlTEControllor.text);

    if (isSuccess) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
          (pat) => false);
    } else {
      snackBarMassage(context, 'Login Faill !', true);
    }
  }

  // Future<void> _loging() async {
  //   _loginInProgress == true;
  //   setState(() {});
  //   Map<String, dynamic> requestBody = {
  //     "email": _emailTEControllor.text.trim(),
  //     "password": _passwordlTEControllor.text
  //   };

  //   NetworkRespons respons =
  //       await NetworkClient.postRequest(url: Urls.loginUrl, body: requestBody);
  //   _loginInProgress == false;
  //   setState(() {});
  //   if (respons.isSuccess) {
  //     LoginModels logingModel = LoginModels.fromJson(respons.data!);
  //     AuthController.saveUserInformation(
  //         logingModel.token, logingModel.userModel);

  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const MainBottomNavScreen(),
  //         ),
  //         (pat) => false);
  //   } else {
  //     snackBarMassage(context, 'Login Faill !', true);
  //   }
  // }

  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegsterScreen(),
      ),
    );
  }

  void _onTapPorgetPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ForgetPasswordEmailVerifay()));
  }

  @override
  void dispose() {
    _emailTEControllor.dispose();
    _passwordlTEControllor.dispose();
    super.dispose();
  }
}
