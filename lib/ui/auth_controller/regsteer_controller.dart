import 'package:get/get.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';

class RegsteerController extends GetxController {
  bool _registaioInProgress = true;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;
  bool get registaioInProgress => _registaioInProgress;

  Future<bool> regstarUser(
      String email, fastName, lastName, mobile, password) async {
    _registaioInProgress = true;
    bool isSuccess = false;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": fastName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password
    };
    NetworkRespons respons = await NetworkClient.postRequest(
        url: Urls.registerUrl, body: requestBody);
    isSuccess = true;
    _errorMassage = null;
    update();
    if (respons.isSuccess) {
    } else {
      _errorMassage = respons.errorMassage;
    }
    _registaioInProgress = false;
    update();
    return isSuccess;
  }
}
