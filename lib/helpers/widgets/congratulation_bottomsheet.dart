import 'dart:async';

import 'package:bright_kid/ui/dashboard/home/home.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationsBottom extends StatefulWidget {
  final String title;
  //0 mean from login and 1 mean from change password
  int status;

  CongratulationsBottom({this.title, this.status});

  @override
  _CongratulationsBottomState createState() => _CongratulationsBottomState();
}

class _CongratulationsBottomState extends State<CongratulationsBottom> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      widget.status == 1 ? Get.back() : Get.offAll(() => HomeView());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xffF3F9FE),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        height: Get.width * .65,
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * .05, vertical: Get.height * .02),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                congratulationIcon,
                scale: 3.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Congratulations",
              style: MyTextStyle.mulishBlack().copyWith(
                  color: Color(0xff314A72),
                  fontSize: Get.width * .045,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Get.height * .02,
            ),
            Container(
              width: Get.width * .7,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: MyTextStyle.mulish().copyWith(
                  color: Color(0xff748A9D),
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width * .04,
                ),
              ),
            ),
          ],
        ));
  }
}
