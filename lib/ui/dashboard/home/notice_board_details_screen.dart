import 'package:bright_kid/helpers/services/api_request.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/helpers/widgets/logout_bottomsheet.dart';
import 'package:bright_kid/ui/dashboard/home/notice_board_view.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class NoticeBoardDetails extends StatelessWidget {
  NoticeBoardDetails({
    Key key,
  }) : super(key: key);
  final details = Get.arguments;

  void handleAcknowledgment() async {
    print('hiii');
    var data = loginData?.loginUser;
    var res = await ApiRequest()
        .acknowledgeNotice(data?.schoolCode, data?.email, details['id']);

    if (res != null) {
      Get.off(() => NoticeBoardView());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.green,
        textStyle: const TextStyle(fontSize: 20, fontFamily: 'SFPro'));
    return ModalProgressHUD(
      inAsyncCall: false,
      progressIndicator: MyLoader(),
      child: Scaffold(
        backgroundColor: scaffold,
        appBar: globalAppBar('Notice Board'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * .05,
                vertical: Get.height * 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Image.asset(
                        noticeBoardIcon,
                        scale: 0.8,
                      ),
                      Text(
                        'Notice Board',
                        style: MyTextStyle.mulishBlack().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * .05,
                          color: themeColor,

                          //decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(LogoutBottomSheet());
                    },
                    child: Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (loginData?.loginUser?.profilePic == '')
                              ? AssetImage(dp)
                              : NetworkImage(
                                  loginData.loginUser.profilePic,
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Color.fromRGBO(220, 231, 251, 1),
                    margin: EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    height: 524,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('notice'),
                              Text(DateFormat('dd/MM/yy hh:mm a')
                                  .format(details['dateTime']))
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                details['title'],
                                style: MyTextStyle.mulishBlack().copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * .04,
                                  color: themeColor,

                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Image.network(
                                  details['imageUrl'],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  details['body'],
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        !details['acknowledgment']
                            ? Container(
                                margin: EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: handleAcknowledgment,
                                  child: Text('Acknowledged'),
                                  style: style,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
