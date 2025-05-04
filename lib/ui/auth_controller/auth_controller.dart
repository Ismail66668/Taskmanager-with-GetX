import 'dart:convert';

import 'package:mytaskmanager/data/models/loging_models/uaer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? token;
  static UserModel? userModels;
  static const String _tokenkye = 'tokon';
  static const String _modelKye = 'user-model';
  static Future<void> saveUserInformation(
      String accesToken, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenkye, accesToken);
    sharedPreferences.setString(_modelKye, jsonEncode(user.toJson()));

    token = accesToken;
    userModels = user;
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? saveToken = sharedPreferences.getString(_tokenkye);
    String? saveUserModel = sharedPreferences.getString(_modelKye);
    if (saveUserModel != null) {
      UserModel saveDcodModel = UserModel.fromJson(jsonDecode(saveUserModel));
      userModels = saveDcodModel;
    }
    token = saveToken;
  }

  static Future<bool> cheackUserLoggding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? usertoken = sharedPreferences.getString(_tokenkye);
    if (usertoken != null) {
      getUserInformation();
      return true;
    } else {
      return false;
    }
  }

  static Future<void> logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    token = null;
    userModels = null;
  }
}
