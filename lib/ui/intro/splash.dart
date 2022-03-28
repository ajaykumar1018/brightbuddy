import 'dart:async';

import 'package:bright_kid/models/login_model.dart';
import 'package:bright_kid/ui/dashboard/home/home.dart';
import 'package:bright_kid/ui/intro/onboarding.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/singleton_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String email;
  String password;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: 3), vsync: this, value: 0.05);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    initiatePrefs();
    Timer(Duration(seconds: 3), () {
      MyUser.isLoggedIn
          ? loginSharedPrefsApiCall()
          : Get.offAll(() => OnboardingView());
    });

    super.initState();
  }

  Future loginSharedPrefsApiCall() async {
    await apiRequest.loginApi(email, password).then((response) async {
      if (response != false) {
        loginData = LoginModel.fromJson(response);
        print('user login successfully done');
        Get.offAll(() => HomeView());
      }
    });
  }

  initiatePrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString('email');
    password = preferences.getString('password');
    MyUser.isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
    print("shared preferences : ${MyUser.isLoggedIn}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Container(
              width: Get.width * .7,
              height: Get.width * .7,
              child: Image.asset(logo)),
        ),
      ),
    );
  }
}
