import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/models/chapters_lesson_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CourseTopicDetails2 extends StatefulWidget {
  ChaptersLessonModel chaptersLessonModel;
  String courseName;
  int indexM;
  var data;

  CourseTopicDetails2(
      {this.chaptersLessonModel, this.courseName, this.indexM, this.data});

  @override
  _CourseTopicDetails2State createState() => _CourseTopicDetails2State();
}

class _CourseTopicDetails2State extends State<CourseTopicDetails2> {
  int totalPercentageAvg;

  @override
  void initState() {
    getPercentage();
    super.initState();
  }

  void getPercentage() {
    int sum = 0, total = 0;
    int t = widget.data[widget.indexM]['contents'].length;
    for (int i = 0; i < t; i++) {
      if (widget.data[widget.indexM]['contents'][i]['completed'] == true) sum++;
      total++;
    }

    setState(() {
      double percentage = (sum / total);
      double percentage2 = percentage * 100;
      totalPercentageAvg = percentage2.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, _) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          appBar: globalAppBar('${widget.courseName}'),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05,
                    vertical: Get.height * .02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: AssetImage(courseTopicDetailsImage),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width * .45,
                            child: strokedText(
                                text: '${widget.courseName}',
                                fontSize: Get.width * .05,
                                color: white,
                                isProgressIndicator: false),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Total Sub-Topics' +
                                "\t${widget.data[widget.indexM]['contents'].length ?? 0}",
                            style: MyTextStyle.mulish().copyWith(
                                fontWeight: FontWeight.bold,
                                color: white,
                                fontSize: Get.width * .04),
                          )
                        ],
                      ),
                      // progressIndicator(
                      //   currentStep: 50,
                      //   colorWhite: false,
                      //   width: 100,
                      //   height: 100,
                      // ),
                      CircularStepProgressIndicator(
                        totalSteps: 100,
                        currentStep: totalPercentageAvg ?? 0,
                        stepSize: 10,
                        gradientColor: LinearGradient(colors: [
                          Color(0xffFDAF31),
                          Color(0xffFDD060),
                        ]),
                        unselectedColor: Colors.white.withOpacity(.50),
                        padding: 0,
                        width: 100,
                        height: 100,
                        selectedStepSize: 17,
                        child: Center(
                          child: strokedText(
                              color: Colors.white,
                              fontSize: Get.width * .04,
                              text: "${totalPercentageAvg ?? 0}%",
                              isProgressIndicator: true),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * .05),
                  child: strokedText(
                      text: getTranslated(context, "sub_topics"),
                      fontSize: Get.width * .04,
                      color: themeColor,
                      isProgressIndicator: false),
                ),
                SizedBox(height: 10),
                widget.data[widget.indexM]['contents'] == null ||
                        widget.data[widget.indexM]['contents'] == null ||
                        widget.data[widget.indexM]['contents'].length == null ||
                        widget.data[widget.indexM]['contents'].isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'There is no sub topics',
                            style: MyTextStyle.mulish().copyWith(
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                                fontSize: Get.width * .035),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: List.generate(
                              widget.data[widget.indexM]['contents'].length,
                              (index) {
                            return subTopicsCard(
                                widget.data[widget.indexM]['contents'][index]
                                    ['content_name'],
                                "${widget.data[widget.indexM]['contents'][index]['content_id']}",
                                widget.data[widget.indexM]['contents'][index]
                                            ['completed'] ==
                                        true
                                    ? 1
                                    : 0);
                          }),
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget subTopicsCard(String name, String code, int completed) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * .53,
                child: Text(
                  name,
                  style: MyTextStyle.mulish().copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                      fontSize: Get.width * .035),
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: Get.width * .53,
                child: Text(
                  code,
                  style: MyTextStyle.mulish().copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                      fontSize: Get.width * .030),
                ),
              ),
              SizedBox(height: 10),
              // Row(
              //   children: [
              //     Image.asset(
              //       contents.contentableType == 'Quiz' ? quiz : video,
              //       scale: 3,
              //     ),
              //     SizedBox(width: 5),
              //     Text(
              //       contents?.contentableType ?? '',
              //       style: MyTextStyle.mulish().copyWith(
              //           fontWeight: FontWeight.w600,
              //           color: lightBlack,
              //           fontSize: Get.width * .03),
              //     ),
              //   ],
              // )
            ],
          ),
          progressIndicator(
            currentStep: completed == 1 ? 100 : 0,
            colorWhite: true,
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}
