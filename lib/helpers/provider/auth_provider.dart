import 'package:bright_kid/helpers/widgets/congratulation_bottomsheet.dart';
import 'package:bright_kid/helpers/widgets/set_password_bottomsheet.dart';
import 'package:bright_kid/models/login_model.dart';
import 'package:bright_kid/ui/dashboard/home/home.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    notifyListeners();
  }

  bool isLoading = false;

  bool loginPassVisible = true;

  // secure login password
  secureLoginPassword() {
    loginPassVisible = !loginPassVisible;
    notifyListeners();
  }

  bool setPasswordVisible = true;
  bool confirmSetPasswordVisible = true;

  secureSetPassword() {
    setPasswordVisible = !setPasswordVisible;
    notifyListeners();
  }

  secureConfirmSetPasswordVisible() {
    confirmSetPasswordVisible = !confirmSetPasswordVisible;
    notifyListeners();
  }

  Future onLoginButtonTapped(String email, String password) async {
    isLoading = true;
    notifyListeners();
    apiRequest.loginApi(email, password).then((response) async {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        if (response['code'] == 200) {
          loginData = LoginModel.fromJson(response);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool('isLoggedIn', true);
          preferences.setString('email', email);
          preferences.setString('password', password);
          Get.offAll(() => HomeView());
        } else {
          Get.bottomSheet(SetPasswordBottomSheet(userEmail: email));
        }
      }
    });
  }

  Future onsetPasswordButtonTapped(
      String email, String password, String rePassword) async {
    isLoading = true;
    notifyListeners();
    apiRequest.setPassword(email, password, rePassword).then((response) async {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        loginData = LoginModel.fromJson(response);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('isLoggedIn', true);
        preferences.setString('email', email);
        preferences.setString('password', password);
        Get.back();
        Get.bottomSheet(
            CongratulationsBottom(
              title: "Password set successfully",
              status: 0,
            ),
            enableDrag: false,
            isDismissible: false);
      }
    });
  }
}
