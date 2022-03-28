import 'package:bright_kid/helpers/provider/auth_provider.dart';
import 'package:bright_kid/helpers/widgets/form_fields.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/global_function.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:bright_kid/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: WillPopScope(
          onWillPop: onWillPop,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  left: Get.width * .06,
                  right: Get.width * .06,
                  top: Get.height * .02,
                  bottom: Get.height * .04,
                ),
                child: Text(
                  "First time sign-up/login would take a couple of minutes. Please wait and do not close the app.",
                  style: MyTextStyle.mulish()
                      .copyWith(fontSize: Get.width * .04, color: lightBlack),
                ),
              ),
              body: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  child: Stack(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * .35,
                        child: Image.asset(login, fit: BoxFit.cover),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: Get.height * .31,
                        bottom: 0,
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ListView(
                              padding: EdgeInsets.only(top: 0),
                              children: [
                                SizedBox(
                                  height: Get.width * .05,
                                ),
                                strokedText(
                                    text: getTranslated(
                                        context, "welcome_exclamation"),
                                    fontSize: Get.width * .06,
                                    color: themeColor,
                                    isProgressIndicator: false),
                                SizedBox(
                                  height: Get.width * .05,
                                ),
                                Text(
                                  "Hey! Welcome to the bright kid at home learning journey. Let's first sign in to begin!",
                                  style: MyTextStyle.mulish().copyWith(
                                      fontSize: Get.width * .04,
                                      color: lightBlack),
                                ),
                                SizedBox(
                                  height: Get.width * .05,
                                ),
                                GlobalFormField(
                                  label: "email",
                                  hint: "email_address",
                                  prefixIcon: Image.asset(
                                    email,
                                    scale: 4,
                                  ),
                                  controller: _emailController,
                                  type: TextInputType.emailAddress,
                                  validator: FieldValidator.validateEmail,
                                  action: TextInputAction.next,
                                ),
                                SizedBox(height: Get.width * .05),
                                GlobalFormField(
                                  label: "password",
                                  hint: "password_hint",
                                  prefixIcon: Image.asset(
                                    password,
                                    scale: 4,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      provider.secureLoginPassword();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      width: 0,
                                      child: provider.loginPassVisible
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                    ),
                                  ),
                                  controller: _passwordController,
                                  type: TextInputType.text,
                                  validator: FieldValidator.validatePassword,
                                  action: TextInputAction.done,
                                  secureText: provider.loginPassVisible,
                                ),
                                SizedBox(
                                  height: Get.width * .02,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: strokedText(
                                          fontSize: Get.width * .04,
                                          color: orange,
                                          text: getTranslated(
                                              context, "forgot_password"),
                                          isProgressIndicator: false)),
                                ),
                                SizedBox(
                                  height: Get.width * .05,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        provider.onLoginButtonTapped(
                                            _emailController.text,
                                            _passwordController.text);
                                      }
                                    },
                                    child: gradientButton(
                                        text: getTranslated(context, "sign_in"),
                                        width: Get.width * .6,
                                        height: Get.width * .12),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.width * .03,
                                ),
                                SizedBox(
                                  height: Get.width * .05,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 20,
                      //   child: Text(
                      //     "First time sign-up/login would take a couple of minutes. Please wait and do not close the app.",
                      //     style: MyTextStyle.mulish().copyWith(
                      //         fontSize: Get.width * .04,
                      //         color: lightBlack),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
