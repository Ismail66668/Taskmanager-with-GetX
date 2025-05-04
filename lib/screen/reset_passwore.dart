import 'package:flutter/material.dart';
import 'package:mytaskmanager/screen/main_bottom_nav_screen.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';
import 'loging_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _newPasswordTEControllor =
      TextEditingController();
  final TextEditingController _confromPasswordTEControllor =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                "Set Password",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Minumum lanth password 8 charecter with letter and number combination",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: _newPasswordTEControllor,
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'enter a password';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'new password'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: _confromPasswordTEControllor,
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'enter a password';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'confrom password'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: _onTapConfromPassword,
                  child: Text(
                    "Confrim",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 18),
                  )),
              const SizedBox(
                height: 16,
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
                      onTap: _tapToSingIng,
                      child: const Text(
                        "SingIn",
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      )),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void _tapToSingIng() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LogingScreen(),
        ),
        ((pet) => false));
  }

  @override
  void dispose() {
    _newPasswordTEControllor.dispose();
    _confromPasswordTEControllor.dispose();
    super.dispose();
  }

  void _onTapConfromPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavScreen(),
        ));
  }
}
