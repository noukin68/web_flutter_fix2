import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_flutter/api_urls.dart';
import 'package:web_flutter/authProvider.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/services/navigation_service.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int userId = 0;

  bool _isAuthorized = false;
  bool _hasLicense = false;

  bool get isAuthorized => _isAuthorized;
  bool get hasLicense => _hasLicense;

  void updateAuthorization(bool isAuthorized, bool hasLicense) {
    _isAuthorized = isAuthorized;
    _hasLicense = hasLicense;
    notifyListeners();
  }

  void updateUserId(int userId) {
    this.userId = userId;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage(context, 'Введите email и пароль');
      return;
    }

    try {
      var requestBody = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        Uri.parse(ApiUrls.userLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        _isAuthorized = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);

        var responseData = json.decode(response.body);
        int userId = responseData['userId'];

        updateAuthorization(true, _hasLicense);
        updateUserId(userId);

        await _checkLicenseStatus(context, userId);

        AuthorizationProvider.of(context)
            ?.updateAuthorization(true, _hasLicense);
        notifyListeners();
      } else {
        _showErrorMessage(context, 'Неверный email или пароль');
      }
    } catch (e) {
      _showErrorMessage(context, 'Ошибка аутентификации: $e');
    }
  }

  Future<void> _checkLicenseStatus(BuildContext context, int userId) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiUrls.licenseStatusUrl}/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var licenseStatus = json.decode(response.body);
        bool hasLicense = licenseStatus['active'] == true;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('hasLicense', hasLicense);

        _isAuthorized = true;
        _hasLicense = hasLicense;
        updateAuthorization(_isAuthorized, _hasLicense);

        String route = hasLicense ? ProfileRoute : RatesRoute;
        locator<NavigationService>().navigateTo(route, arguments: userId);
        notifyListeners();
      } else if (response.statusCode == 404) {
        locator<NavigationService>().navigateTo(RatesRoute, arguments: userId);
      } else {
        _showErrorMessage(context, 'Ошибка при проверке статуса лицензии');
      }
    } catch (e) {
      _showErrorMessage(context, 'Ошибка при проверке статуса лицензии: $e');
    }
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      updateUserId(0);
      updateAuthorization(false, false);
      clearControllers();

      AuthorizationProvider.of(context)?.updateAuthorization(false, false);

      locator<NavigationService>().navigateTo(LoginRoute);
    } catch (e) {
      _showErrorMessage(context, 'Error logging out: $e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
