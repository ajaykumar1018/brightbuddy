import 'package:bright_kid/ui/dashboard/home/notice_board_details_screen.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoticeBoardItem extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  final DateTime dateTime;
  final String imageUrl;
  final bool acknowledgment;
  const NoticeBoardItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.dateTime,
    @required this.imageUrl,
    @required this.acknowledgment,
  }) : super(key: key);

  void selectedNotice() {
    Get.to(() => NoticeBoardDetails(), arguments: {
      'id': id,
      'title': title,
      'body': body,
      'dateTime': dateTime,
      'imageUrl': imageUrl,
      'acknowledgment': acknowledgment,
    });
    // GetStorage noticeId = GetStorage();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectedNotice,
      child: Card(
        color: !acknowledgment ? Color.fromRGBO(220, 231, 251, 1) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        elevation: 0,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 5, right: 5),
              child: Text(
                DateFormat('dd/MM/yy hh:mm').format(dateTime),
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * .05,
                      ),
                      child: Image.asset(
                        exclamationIcon,
                        scale: .4,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * .5,
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
                        width: Get.width * .5,
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
          ],
        ),
      ),
    );
  }
}
