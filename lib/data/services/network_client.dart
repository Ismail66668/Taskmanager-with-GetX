import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:mytaskmanager/screen/loging_screen.dart';
import 'package:mytaskmanager/screen/run_app.dart';
import 'package:mytaskmanager/ui/auth_controller/auth_controller.dart';

class NetworkRespons {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMassage;

  NetworkRespons(
      {required this.isSuccess,
      required this.statusCode,
      this.data,
      this.errorMassage});
}

class NetworkClient {
  static final Logger _logger = Logger();
  static Future<NetworkRespons> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': AuthController.token ?? ''
      };
      _preRequest(url, headers);

      Response response = await get(uri, headers: headers);

      _postRequest(url, response.statusCode,
          haders: response.headers, responsbody: response.body);

      if (response.statusCode == 200) {
        final dcodeJson = jsonDecode(response.body);
        return NetworkRespons(
            isSuccess: true, statusCode: response.statusCode, data: dcodeJson);
      } else if (response.statusCode == 401) {
        _moveToLoggingScreen();
        return NetworkRespons(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: "");
      } else {
        final jesonDecode = jsonDecode(response.body);
        String errorMassage = jesonDecode['data'] ?? 'Somethink wont wrong !';

        return NetworkRespons(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: errorMassage);
      }
    } catch (e) {
      return NetworkRespons(isSuccess: false, statusCode: -1);
    }
  }

  static Future<NetworkRespons> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': AuthController.token ?? ''
      };
      _preRequest(url, headers);
      Response response =
          await post(uri, headers: headers, body: jsonEncode(body));

      _postRequest(url, response.statusCode,
          haders: response.headers, responsbody: response.body);

      if (response.statusCode == 200) {
        final jesonDecode = jsonDecode(response.body);
        return NetworkRespons(
            isSuccess: true,
            statusCode: response.statusCode,
            data: jesonDecode);
      } else if (response.statusCode == 401) {
        _moveToLoggingScreen();
        return NetworkRespons(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: "");
      } else {
        final jesonDecode = jsonDecode(response.body);
        String errorMassage = jesonDecode['data'] ?? 'Somethink wont wrong !';

        return NetworkRespons(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: errorMassage);
      }
    } catch (e) {
      return NetworkRespons(
          isSuccess: false, statusCode: -1, errorMassage: e.toString());
    }
  }

  static void _preRequest(String url, Map<String, String> haders,
      {Map<String, dynamic>? body}) {
    _logger.i('URL=>$url \n Headers=> $haders\n Body=>$body');
  }

  static void _postRequest(String url, int statusCode,
      {Map<String, dynamic>? haders, dynamic responsbody}) {
    _logger.i(
        'Url=> $url \n StatusCode=> $statusCode \n Haders=> $haders \n ResponsBody=> $responsbody');
  }

  static Future<void> _moveToLoggingScreen() async {
    await AuthController.logOutUser();
    Navigator.pushAndRemoveUntil(
        Taskmanager.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const LogingScreen(),
        ),
        (predicate) => false);
  }
}
