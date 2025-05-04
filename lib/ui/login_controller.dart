import 'package:get/get.dart';

import '../data/models/loging_models/loging_model.dart';
import '../data/services/network_client.dart';
import '../data/utils/urls/urls.dart';
import 'auth_controller/auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String? _errorMassage;

  bool get loginProgress => _loginInProgress;
  String? get errorMassage => _errorMassage;

  Future<bool> loging(String email, String password) async {
    _loginInProgress = true;
    bool isSuccess = false;
    update();
    Map<String, dynamic> requestBody = {"email": email, "password": password};

    NetworkRespons respons =
        await NetworkClient.postRequest(url: Urls.loginUrl, body: requestBody);
    update();
    if (respons.isSuccess) {
      LoginModels logingModel = LoginModels.fromJson(respons.data!);
      await AuthController.saveUserInformation(
          logingModel.token, logingModel.userModel);
      isSuccess = true;
      _errorMassage = null;
      update();
    } else {
      _errorMassage = respons.errorMassage;
    }
    _loginInProgress = false;
    update();
    return isSuccess;
  }
}
