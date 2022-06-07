import 'dart:io';

import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/services/api_url.dart';
import 'package:bright_kid/helpers/widgets/changepassword_bottomSheet.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/ui/auth/login.dart';
import 'package:bright_kid/utils/cache_avatar.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutBottomSheet extends StatefulWidget {
  @override
  _LogoutBottomSheetState createState() => _LogoutBottomSheetState();
}

class _LogoutBottomSheetState extends State<LogoutBottomSheet> {
  File _profileImage;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashProvider, child) {
      return ModalProgressHUD(
        inAsyncCall: dashProvider.isLoading,
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
                GestureDetector(
                  onTap: () {
                    dashProvider
                        .getProfileImageGallery(_profileImage)
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   image: (loginData?.loginUser?.profilePic == '')
                      //       ? AssetImage(dp)
                      //       : NetworkImage(
                      //           loginData.loginUser.profilePic,
                      //         ),
                      // ),
                    ),
                    child: Stack(
                      children: [
                        (loginData?.loginUser?.profilePic == '' ||
                                loginData?.loginUser?.profilePic == null)
                        ? Image.asset(dp)
                        // ? Container(
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: AssetImage(
                        //           dp),
                        //       fit: BoxFit.cover,
                        //     ),
                        //     //shape: BoxShape.circle,
                        //   ),
                        // )
                            // ? AssetImage(dp)
                            : Container(
                                width: 70,
                                height: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    loginData.loginUser.profilePic,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        // CachedAvatar(
                        //   radius: 33,
                        //   imageUrl:loginData.loginUser.profilePic,
                        // ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Image.asset(cameraIcon, scale: 4)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  loginData?.loginUser?.name ?? '',
                  textAlign: TextAlign.center,
                  style: MyTextStyle.mulishBlack().copyWith(
                    color: Color(0xff314A72),
                    fontSize: Get.width * .038,
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .03,
                    vertical: Get.height * .02,
                  ),
                  margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff888888).withOpacity(.26),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _profileData('Name', loginData?.loginUser?.name ?? ''),
                      SizedBox(height: 10),
                      _profileData('Email', loginData?.loginUser?.email ?? ''),
                      SizedBox(height: 10),
                      _profileData('Password', '*****'),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.bottomSheet(ChangePasswordBottomSheet());
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(changePasswordIcon, scale: 4),
                              SizedBox(width: 5),
                              Text(
                                'Change Password',
                                textAlign: TextAlign.center,
                                style: MyTextStyle.mulishBlack().copyWith(
                                  color: Color(0xffFAAB3B),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: Get.width * .03,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      Get.offAll(() => LoginView());
                    },
                    child: gradientButton(
                      height: 42,
                      width: Get.width * .7,
                      text: 'Log Out',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _profileData(String text, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: MyTextStyle.mulishBlack().copyWith(
            color: Color(0xff314A72),
            fontWeight: FontWeight.bold,
            fontSize: Get.width * .038,
          ),
        ),
        Expanded(
          child: Text(
            name,
            textAlign: TextAlign.end,
            style: MyTextStyle.mulishBlack().copyWith(
              color: Color(0xff748A9D),
              fontWeight: FontWeight.bold,
              fontSize: Get.width * .038,
            ),
          ),
        ),
      ],
    );
  }
}
