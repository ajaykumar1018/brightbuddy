import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/form_fields.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:bright_kid/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  @override
  _ChangePasswordBottomSheetState createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, _) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffF3F9FE),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26), topRight: Radius.circular(26))),
          // height: Get.width * .7,
          padding: EdgeInsets.only(
            left: Get.width * .05,
            right: Get.width * .05,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Get.height * .01),
                    width: Get.width * .13,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFAAB3B),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset(changePasswordMobileIcon, scale: 5),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Change Password',
                    textAlign: TextAlign.center,
                    style: MyTextStyle.mulishBlack().copyWith(
                      color: Color(0xff314A72),
                      fontSize: Get.width * .05,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'must include upper case and numbers',
                    textAlign: TextAlign.center,
                    style: MyTextStyle.mulishBlack().copyWith(
                      color: Color(0xff748A9D),
                      fontSize: Get.width * .04,
                    ),
                  ),
                  SizedBox(height: 25),
                  GlobalFormField(
                    label: "old_password",
                    hint: "password",
                    prefixIcon: Image.asset(
                      password,
                      scale: 4,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.secureOldPassword();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: 0,
                        child: provider.oldPasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    controller: _oldPasswordController,
                    type: TextInputType.text,
                    validator: FieldValidator.validatePassword,
                    action: TextInputAction.next,
                    secureText: provider.oldPasswordVisible,
                  ),
                  SizedBox(height: 25),
                  GlobalFormField(
                    label: "new_password",
                    hint: "password",
                    prefixIcon: Image.asset(
                      password,
                      scale: 4,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.secureNewPassword();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: 0,
                        child: provider.newPasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    controller: _newPasswordController,
                    type: TextInputType.text,
                    validator: FieldValidator.validatePassword,
                    action: TextInputAction.next,
                    secureText: provider.newPasswordVisible,
                  ),
                  GlobalFormField(
                    label: "",
                    hint: "confirm_password",
                    prefixIcon: Image.asset(
                      password,
                      scale: 4,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.secureConfirmPassword();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: 0,
                        child: provider.confirmPasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    controller: _confirmNewPasswordController,
                    type: TextInputType.text,
                    validator: (value) => FieldValidator.validatePasswordMatch(
                        _newPasswordController.text,
                        _confirmNewPasswordController.text),
                    action: TextInputAction.done,
                    secureText: provider.confirmPasswordVisible,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          provider.onchangePasswordButtonTapped(
                            loginData?.loginUser?.email ?? '',
                            _oldPasswordController.text,
                            _newPasswordController.text,
                          );
                        }
                      },
                      child: gradientButton(
                        height: 42,
                        width: Get.width * .7,
                        text: 'Change Password',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
