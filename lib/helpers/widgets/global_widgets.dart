import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

Widget gradientButton({double width, double height, String text}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        colors: <Color>[
          const Color(0xffFF7C22),
          const Color(0xffFFE600),
        ],
      ),
    ),
    child: Center(
        child: Text(
      text,
      style: MyTextStyle.mulish().copyWith(
          color: white, fontWeight: FontWeight.w600, fontSize: Get.width * .04),
    )),
  );
}

Widget strokedText(
    {String text, double fontSize, Color color, bool isProgressIndicator}) {
  return Text(
    text,
    style: isProgressIndicator
        ? MyTextStyle.sFPro().copyWith(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: color)
        : MyTextStyle.mulishBlack().copyWith(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
  );
}

Widget globalAppBar(String title) {
  return AppBar(
    backgroundColor: scaffold,
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        vectorIcon,
        scale: 1,
      ),
    ),
    centerTitle: true,
    // title: strokedText(
    //     text: title,
    //     fontSize: Get.width * .05,
    //     color: themeColor,
    //     isProgressIndicator: false),
  );
}

Widget progressIndicator(
    {int currentStep,
    bool colorWhite,
    double width,
    double height,
    double fontSize}) {
  return CircularStepProgressIndicator(
    totalSteps: 100,
    currentStep: currentStep,
    stepSize: 10,
    gradientColor: LinearGradient(colors: [
      Color(0xffFDAF31),
      Color(0xffFDD060),
    ]),
    unselectedColor: Colors.white.withOpacity(.50),
    padding: 0,
    width: width,
    height: height,
    selectedStepSize: 17,
    child: Center(
      child: strokedText(
          color: colorWhite ? lightBlue : Colors.white,
          fontSize: fontSize,
          text: "$currentStep%",
          isProgressIndicator: true),
    ),
  );
}

Widget containerDecoration(
    {double bottom,
    double,
    right,
    double left,
    double top,
    double width,
    double height}) {
  return Positioned(
    bottom: bottom,
    right: right,
    left: left,
    top: top,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: scaffold.withOpacity(.25)),
    ),
  );
}
