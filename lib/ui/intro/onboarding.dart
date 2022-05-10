import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/ui/auth/login.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFEA93),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * .04,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(logo2, height: Get.height * .1),
                ),
                SizedBox(
                  height: Get.width * .1,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Learning by\ndoing!',
                        textAlign: TextAlign.center,
                        style: MyTextStyle.babib().copyWith(
                            fontSize: Get.width * .1,
                            fontWeight: FontWeight.bold,
                            color: themeColor),
                      ),
                      SizedBox(
                        height: Get.width * .04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(() => LoginView(),
                              transition: Transition.rightToLeftWithFade,
                              duration: Duration(milliseconds: 300));
                        },
                        child: gradientButton(
                            height: Get.width * .1,
                            width: Get.width * .3,
                            text: getTranslated(context, "sign_in")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        onBoarding2,
                      ),
                      fit: BoxFit.fill)),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}
