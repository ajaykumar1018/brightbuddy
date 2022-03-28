import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ShowMessageForApi {
  static void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 16,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  static void snackBar(String title, String message, bool progress) {
    Get.snackbar(title, message,
        // backgroundColor: AppColor.mainColor,
        backgroundColor: themeColor,
        colorText: Colors.white,
        showProgressIndicator: progress,
        progressIndicatorBackgroundColor: Colors.lightBlueAccent,
        progressIndicatorValueColor:
            AlwaysStoppedAnimation<Color>(Colors.tealAccent),
        borderRadius: 6);
  }

  static void bottomSheet(Widget sheet) {
    Get.bottomSheet(sheet);
  }

  static void ofJson(var jsonResponse) {
    Fluttertoast.showToast(
        msg: jsonResponse['ShortMessage'],
        fontSize: 16,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  static void inDialog(String message, bool isError) {
    Color color = isError ? Colors.redAccent : Colors.green;
    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'Monts',
            fontSize: Get.height * 0.0,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Get.height * 0.032,
              backgroundColor: color,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height * 0.030,
                  child: Icon(
                    isError ? Icons.warning : Icons.done_outline,
                    color: color,
                    size: Get.height * 0.042,
                  )),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            Text(message ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Monts', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: 'Monts',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .024),
                  ),
                ),
              )
            ],
          )
        ]);
  }

  static void guestDialog(BuildContext context) {
    Color color = Colors.redAccent;
    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'Monts',
            fontSize: Get.height * 0.0,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Get.height * 0.032,
              backgroundColor: color,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height * 0.030,
                  child: Icon(
                    Icons.warning,
                    color: color,
                    size: Get.height * 0.042,
                  )),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            // Text(getTranslated(context, "you_have_to_login") ?? "",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         fontFamily: 'Monts', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                // onTap: () => AppRoutes.makeFirst(context, Login()),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: 'Monts',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .024),
                  ),
                ),
              )
            ],
          )
        ]);
  }

  static void logoutDialog(BuildContext context) {
    Color color = Colors.redAccent;
    Get.defaultDialog(
        barrierDismissible: true,
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'Monts',
            fontSize: Get.height * 0.0,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Get.height * 0.032,
              backgroundColor: color,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height * 0.030,
                  child: Icon(
                    Icons.warning,
                    color: color,
                    size: Get.height * 0.042,
                  )),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            // Text(getTranslated(context, 'auth_failed_redirect_to_home') ?? "",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         fontFamily: 'Monts', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: 'Monts',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .024),
                  ),
                ),
              )
            ],
          )
        ]);
  }

  static void ofJsonInDialog(var jsonResponse, bool isError) {
    Color color = isError ? Colors.redAccent : Colors.green;
    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'Monts',
            fontSize: Get.height * 0.0,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Get.height * 0.032,
              backgroundColor: color,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height * 0.030,
                  child: Icon(
                    isError ? Icons.warning : Icons.done_outline,
                    color: color,
                    size: Get.height * 0.042,
                  )),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            Text(jsonResponse['message'] ?? "",
                textAlign: TextAlign.center,
                style:
                    MyTextStyle.sFPro().copyWith(fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width * .35,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: Text(
                    'OK',
                    style: MyTextStyle.mulish().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .021),
                  ),
                ),
              )
            ],
          )
        ]);
  }

  static void customDialog(String title, String message, String buttonName,
      Function onPressed, bool isError) {
    Color color = isError ? Colors.redAccent : Colors.green;
    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'Monts',
            fontSize: Get.height * 0.0,
            color: color,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'Monts',
                  fontSize: Get.height * 0.03,
                  color: color,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            Text("$message",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Monts', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () {
                  if (onPressed == null) {
                    Get.back();
                  } else {
                    onPressed();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor),
                  child: Text(
                    '$buttonName',
                    style: TextStyle(
                        fontFamily: 'Monts',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .024),
                  ),
                ),
              )
            ],
          )
        ]);
  }

  static void customDialogOfJson(String title, var jsonResponse,
      String buttonName, Function onPressed, bool isError) {
    Color color = isError ? Colors.redAccent : Colors.green;
    Get.defaultDialog(
        title: '$title',
        titleStyle: TextStyle(
            fontFamily: 'Monts',
            fontSize: Get.height * 0.0,
            color: color,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
//            CircleAvatar(
//              radius: Get.height * 0.032,
//              backgroundColor: color,
//              child: CircleAvatar(
//                  backgroundColor: Colors.white,
//                  radius: Get.height * 0.030,
//                  child: Icon(
//                    isError ? Icons.warning : Icons.done_outline,
//                    color: color,
//                    size: Get.height * 0.042,
//                  )),
//            ),
            Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'Monts',
                  fontSize: Get.height * 0.03,
                  color: color,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            Text(jsonResponse['ShortMessage'] ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Monts', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () {
                  if (onPressed == null) {
                    Get.back();
                  } else {
                    onPressed();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor),
                  child: Text(
                    '$buttonName',
                    style: TextStyle(
                        fontFamily: 'Monts',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .024),
                  ),
                ),
              )
            ],
          )
        ]);
  }

  static void showSuccessSnackBar(var _scaffoldKey, jsonResponse) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(jsonResponse['ShortMessage'] ?? ""),
      duration: Duration(seconds: 3),
    ));
  }

  static void showErrorSnackBar(var _scaffoldKey, jsonResponse) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(jsonResponse['ShortMessage'] ?? ""),
      duration: Duration(seconds: 3),
    ));
  }

  static void inSnackBar(var _scaffoldKey, String message, bool isError) {
    Color color = isError ? Colors.red : Colors.green;
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }
}
