import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndividualWeek extends StatefulWidget {
  IndividualWeek({this.data});

  var data;

  @override
  _IndividualWeekState createState() => _IndividualWeekState();
}

class _IndividualWeekState extends State<IndividualWeek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffold,
      appBar: globalAppBar('Week ${widget.data['week']}'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SizedBox(height: 10),
            widget.data['completions'] == null ||
                    widget.data['completions'].isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'There is no Activity this Week',
                        style: MyTextStyle.mulish().copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                            fontSize: Get.width * .035),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      children: List.generate(widget.data['completions'].length,
                          (index) {
                        return subTopicsCard(widget.data['completions'][index]);
                      }),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget subTopicsCard(var data) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .05,
        vertical: Get.height * .01,
      ),
      padding: EdgeInsets.symmetric(
        vertical: Get.height * .01,
        horizontal: Get.width * .04,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(.16),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // data['completion_image'] == null || data['completion_image'] == ''
              //     ?
              Container(
                width: 0,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // : Container(
              //     width: 50,
              //     height: 50,
              //     child: Image.network(data['completion_image']),
              //   ),
              SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    width: Get.width * .4,
                    child: Text(
                      data['name'] ?? '',
                      style: MyTextStyle.mulish().copyWith(
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                          fontSize: Get.width * .04),
                    ),
                  ),
                  Container(
                    width: Get.width * .4,
                    child: Text(
                      "${data['type'].replaceFirst(data['type'][0], data['type'][0].toUpperCase())}" ??
                          '',
                      style: MyTextStyle.mulish().copyWith(
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                          fontSize: Get.width * .03),
                    ),
                  ),
                  //TODO:1 Commented code for Time spent in week wise calender.
                  // data['timespent'] == ""
                  //     ? SizedBox()
                  //     : Container(
                  //         width: Get.width * .4,
                  //         child: Text(
                  //           "Time Spent : ${data['timespent']}",
                  //           style: MyTextStyle.mulish().copyWith(
                  //               fontWeight: FontWeight.bold,
                  //               color: themeColor,
                  //               fontSize: Get.width * .03),
                  //         ),
                  //       ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
