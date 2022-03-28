import 'package:bright_kid/helpers/provider/auth_provider.dart';
import 'package:bright_kid/helpers/widgets/form_fields.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:bright_kid/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SetPasswordBottomSheet extends StatefulWidget {
  String userEmail;
  SetPasswordBottomSheet({this.userEmail});

  @override
  _SetPasswordBottomSheetState createState() => _SetPasswordBottomSheetState();
}

class _SetPasswordBottomSheetState extends State<SetPasswordBottomSheet> {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffF3F9FE),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26))),
            // height: Get.width * .7,
            padding: EdgeInsets.only(
              left: Get.width * .05,
              right: Get.width * .05,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: fromKey,
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
                      'Set Password',
                      textAlign: TextAlign.center,
                      style: MyTextStyle.mulishBlack().copyWith(
                        color: Color(0xff314A72),
                        fontSize: Get.width * .05,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello User, This is your first login on-to\n BK@Home app, please set\n your password.',
                      textAlign: TextAlign.center,
                      style: MyTextStyle.mulishBlack().copyWith(
                        color: Color(0xff748A9D),
                        fontSize: Get.width * .04,
                      ),
                    ),
                    SizedBox(height: 15),
                    GlobalFormField(
                      hint: "password",
                      prefixIcon: Image.asset(
                        password,
                        scale: 4,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          provider.secureSetPassword();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: 0,
                          child: provider.setPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      controller: _passwordController,
                      type: TextInputType.text,
                      validator: FieldValidator.validatePassword,
                      action: TextInputAction.next,
                      secureText: provider.setPasswordVisible,
                    ),
                    SizedBox(height: 5),
                    GlobalFormField(
                      hint: "confirm_password",
                      prefixIcon: Image.asset(
                        password,
                        scale: 4,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          provider.secureConfirmSetPasswordVisible();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: 0,
                          child: provider.confirmSetPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      controller: _confirmPasswordController,
                      type: TextInputType.text,
                      validator: (value) =>
                          FieldValidator.validatePasswordMatch(
                              _passwordController.text,
                              _confirmPasswordController.text),
                      action: TextInputAction.done,
                      secureText: provider.confirmSetPasswordVisible,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (fromKey.currentState.validate()) {
                            provider.onsetPasswordButtonTapped(
                              widget.userEmail,
                              _passwordController.text,
                              _confirmPasswordController.text,
                            );
                          }
                        },
                        child: gradientButton(
                          height: 42,
                          width: Get.width * .7,
                          text: 'Set Password',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
