import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/helpers/widgets/logout_bottomsheet.dart';
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

class NoticeBoardDetails extends StatelessWidget {
  NoticeBoardDetails({
    Key key,
  }) : super(key: key);
  final noticeId = Get.arguments;

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
                            children: [Text('notice'), Text('25/06 12:34 PM')],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Notice title',
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
                                  'https://static.wikia.nocookie.net/dccu/images/2/2e/Batman_-_Justice_League_-_promo.jpg/revision/latest?cb=20191214215631',
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
                                  'If the [softWrap] is true or null, the glyph causing overflow, and those that follow, will not be rendered. Otherwise, it will be shown with the given overflow option',
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
                        Container(
                          margin: EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Acknowledged'),
                            style: style,
                          ),
                        ),
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
