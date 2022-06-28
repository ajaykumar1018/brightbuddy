import 'package:bright_kid/ui/dashboard/home/mont_library_details.dart';
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

class MontLibraryItem extends StatelessWidget {
  final String title;
  final DateTime issueDate;
  final DateTime dueDate;
  final DateTime returnDate;
  const MontLibraryItem({
    Key key,
    @required this.title,
    @required this.issueDate,
    @required this.dueDate,
    @required this.returnDate,
  }) : super(key: key);

  void selectedMontLibrary(BuildContext context, String title,
      DateTime issueDate, DateTime dueDate, DateTime returnDate) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        context: context,
        builder: (_) {
          return MontLibraryDetails(
            title: title,
            issueDate: issueDate,
            dueDate: dueDate,
            returnDate: returnDate,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          selectedMontLibrary(context, title, issueDate, dueDate, returnDate),
      child: Card(
        color: returnDate == null
            ? Color.fromRGBO(220, 231, 251, 1)
            : Colors.white,
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
                DateFormat('dd/MM/yy hh:mm').format(issueDate),
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
                        horizontal: 10,
                      ),
                      child: Image.asset(
                        bookCheckIcon,
                        scale: .6,
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
                          '',
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
