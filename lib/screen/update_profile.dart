import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytaskmanager/data/models/loging_models/uaer_model.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';
import 'package:mytaskmanager/ui/auth_controller/auth_controller.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';
import 'package:mytaskmanager/widgets/snackbar_massage.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _profileUpdateFromKye = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fastNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _picImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    UserModel userModel = AuthController.userModels!;
    _emailTEController.text = userModel.email;
    _fastNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _phoneTEController.text = userModel.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _profileUpdateFromKye,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Update Profile",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: _onTapGetPhoto,
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Center(
                            child: Text(
                          _picImage?.name ?? 'chose photo',
                          style: const TextStyle(fontSize: 14),
                        )),
                      ),
                      Container(
                        // ignore: sort_child_properties_last
                        child: Center(
                            child: Text(
                          " Photo",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'enter a email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _fastNameTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'Fast Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Fast Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'Last Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Last Name'),
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
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _updateProfileInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _onTapUpdateProfileButton();
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapGetPhoto() {
    _image();
  }

  Future<void> _image() async {
    XFile? img = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      _picImage = img;
      setState(() {});
    }
  }

  void _onTapUpdateProfileButton() {
    if (_profileUpdateFromKye.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _fastNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text,
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text;
    }

    if (_picImage != null) {
      List<int> imageByte = await _picImage!.readAsBytes();
      String encodedImage = base64UrlEncode(imageByte);
      requestBody['photo'] = encodedImage;
    }
    NetworkRespons response = await NetworkClient.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );
    _updateProfileInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _passwordTEController.clear();
      setState(() {});

      snackBarMassage(context, 'Update Profile successfully!');
    } else {
      snackBarMassage(context, 'Update Profile Unsccessfull!');
    }
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
}
