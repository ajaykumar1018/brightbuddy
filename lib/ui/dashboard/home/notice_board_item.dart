import 'package:bright_kid/ui/dashboard/home/notice_board_details_screen.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NoticeBoardItem extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  const NoticeBoardItem(
      {Key key, @required this.id, @required this.title, @required this.body})
      : super(key: key);

  void selectedNotice() {
    Get.to(() => NoticeBoardDetails(), arguments: id);
    // GetStorage noticeId = GetStorage();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectedNotice,
      child: Positioned(
        child: Card(
          color: Color.fromRGBO(220, 231, 251, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          elevation: 0,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Image.asset(
                    exclamationIcon,
                    scale: .6,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    child: Text(
                      title,
                      style: MyTextStyle.mulishBlack().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * .04,
                          color: themeColor,
                          overflow: TextOverflow.ellipsis

                          //decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Text(
                      body,
                      textAlign: TextAlign.start,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
