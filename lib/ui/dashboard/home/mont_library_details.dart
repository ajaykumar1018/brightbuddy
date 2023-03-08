import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MontLibraryDetails extends StatelessWidget {
  const MontLibraryDetails(
      {Key key, this.title, this.issueDate, this.dueDate, this.returnDate})
      : super(key: key);

  final String title;
  final DateTime issueDate;
  final DateTime dueDate;
  final DateTime returnDate;

  String get getDue {
    String color;
    if (dueDate.compareTo(DateTime.now()) > 0) {
      color = 'green';
    } else {
      color = 'red';
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              DateFormat('dd/MM/yy hh:mm').format(issueDate),
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  defaultImage,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyTextStyle.mulishBlack().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * .04,
                      color: themeColor,

                      //decoration: TextDecoration.underline,
                    ),
                  ),
                  Text('Date issued : ' +
                      DateFormat('dd/MM/yy').format(issueDate))
                ],
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          returnDate == null
              ? Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: getDue == 'green' ? Colors.green : Colors.red),
                    onPressed: () {},
                    child: Text('Due for Return : ' +
                        DateFormat('dd/MM/yy').format(dueDate)),
                  ),
                )
              : Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Returned On : ' +
                        DateFormat('dd/MM/yy').format(returnDate)),
                  ),
                ),
        ],
      ),
    );
  }
}
