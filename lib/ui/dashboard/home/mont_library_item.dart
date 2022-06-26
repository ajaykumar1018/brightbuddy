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

class MontLibraryItem extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  const MontLibraryItem(
      {Key key, @required this.id, @required this.title, @required this.body})
      : super(key: key);

  void selectedMontLibrary(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        context: context,
        builder: (_) {
          return MontLibraryDetails();
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedMontLibrary(context),
      child: Positioned(
        child: Card(
          color: Color.fromRGBO(220, 231, 251, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          elevation: 0,
          child: Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Image.asset(
                      bookCheckIcon,
                      scale: .6,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
