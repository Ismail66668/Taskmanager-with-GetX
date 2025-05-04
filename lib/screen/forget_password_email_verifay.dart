import 'package:flutter/material.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';
import 'package:mytaskmanager/screen/loging_screen.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';
import 'package:mytaskmanager/widgets/snackbar_massage.dart';

import 'forget_password_otp_verifay.dart';

class ForgetPasswordEmailVerifay extends StatefulWidget {
  const ForgetPasswordEmailVerifay({super.key});

  @override
  State<ForgetPasswordEmailVerifay> createState() =>
      _ForgetPasswordEmailVerifayState();
}

class _ForgetPasswordEmailVerifayState
    extends State<ForgetPasswordEmailVerifay> {
  final TextEditingController _emailTEControllor = TextEditingController();
  final GlobalKey<FormState> _emailVKye = GlobalKey<FormState>();
  bool _emailVerifiPIndicator = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(34.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                "Your Email Address",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "A 6 Digit Verification Pin  Will Sed to your email adders",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _emailVKye,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEControllor,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'enter a email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _emailVerifiPIndicator == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      onTapVerificationEmail();
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

  void onTapVerificationEmail() {
    if (_emailVKye.currentState!.validate()) {
      String semail = _emailTEControllor.text;
      _getEmailVerification(semail);
    }
  }

  Future<void> _getEmailVerification(String email) async {
    _emailVerifiPIndicator = true;
    setState(() {});
    NetworkRespons respons =
        await NetworkClient.getRequest(url: Urls.recoverEmailUrl(email));
    _emailVerifiPIndicator = false;
    setState(() {});
    if (respons.isSuccess) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVeripaication(
              remail: _emailTEControllor.text,
            ),
          ));
      snackBarMassage(context, 'getOtp');
    } else {}
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
    _emailTEControllor.dispose();
    super.dispose();
  }
}
