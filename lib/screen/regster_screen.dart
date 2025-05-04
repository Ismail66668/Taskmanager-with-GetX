// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytaskmanager/screen/loging_screen.dart';
import 'package:mytaskmanager/ui/auth_controller/regsteer_controller.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';
import 'package:mytaskmanager/widgets/snackbar_massage.dart';

class RegsterScreen extends StatefulWidget {
  const RegsterScreen({super.key});

  @override
  State<RegsterScreen> createState() => _RegsterScreenState();
}

class _RegsterScreenState extends State<RegsterScreen> {
  final GlobalKey<FormState> _regstarFromKye = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fastNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final bool _registaioInProgress = false;
  final RegsteerController _regsteerController = Get.find<RegsteerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _regstarFromKye,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Joni With Us",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your Email'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _fastNameTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Fast Name';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your Fast Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Last Name';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your Last Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    String phone = value?.trim() ?? '';
                    RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
                    if (regExp.hasMatch(phone) == false) {
                      return 'Enter your valid phone';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Phone'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordTEController,
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                      return 'enter a password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _registaioInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _onTapRegstar();
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have accaunt ?  ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    GestureDetector(
                        onTap: _apGestureRecognizer,
                        child: const Text(
                          "SingIn",
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapRegstar() {
    if (_regstarFromKye.currentState!.validate()) {
      _regstarUser();
    }
  }

  Future<void> _regstarUser() async {
    final bool isSuccess = await _regsteerController.regstarUser(
        _emailTEController.text.trim(),
        _fastNameTEController.text.trim(),
        _lastNameTEController.text.trim(),
        _phoneTEController.text.trim(),
        _passwordTEController.text);
    if (isSuccess) {
      snackBarMassage(context, "Registation Successfull !");
      _clearTEController();
    } else {
      snackBarMassage(context, "Registation  fail !", true);
    }
  }

  // Future<void> _regstarUser() async {
  //   _registaioInProgress == true;
  //   setState(() {});
  //   Map<String, dynamic> requestBody = {
  //     "email": _emailTEController.text.trim(),
  //     "firstName": _fastNameTEController.text.trim(),
  //     "lastName": _lastNameTEController.text.trim(),
  //     "mobile": _phoneTEController.text.trim(),
  //     "password": _passwordTEController.text
  //   };
  //   NetworkRespons respons = await NetworkClient.postRequest(
  //       url: Urls.registerUrl, body: requestBody);
  //   _registaioInProgress == false;
  //   setState(() {});
  //   if (respons.isSuccess) {
  //     snackBarMassage(context, "Registation Successfull !");
  //     _clearTEController();
  //   } else {
  //     snackBarMassage(context, "Registation  fail !", true);
  //   }
  // }

  void _clearTEController() {
    _emailTEController.clear();
    _passwordTEController.clear();
    _fastNameTEController.clear();
    _lastNameTEController.clear();
    _phoneTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _fastNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    super.dispose();
  }

  void _apGestureRecognizer() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LogingScreen(),
      ),
      (route) => false,
    );
  }

  // void _onTapSignUpButton() {
  //   Navigator.pop(context);
  // }
}
