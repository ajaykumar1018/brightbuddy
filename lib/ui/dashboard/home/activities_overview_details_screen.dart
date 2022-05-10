import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ActivitiesOverViewDetailsScreen extends StatefulWidget {
  GetActivitiesOverviewModel activityModel;

  ActivitiesOverViewDetailsScreen({this.activityModel});

  @override
  _ActivitiesOverViewDetailsScreenState createState() =>
      _ActivitiesOverViewDetailsScreenState();
}

class _ActivitiesOverViewDetailsScreenState
    extends State<ActivitiesOverViewDetailsScreen> {
  int totalPercentageAvg;

  @override
  void initState() {
    List ratings =
        widget.activityModel.activities.map((e) => e.completed * 100).toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / (ratings.length * 100);
      totalPercentageAvg = average.ceilToDouble()?.toInt();
      print(totalPercentageAvg);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffold,
      appBar: globalAppBar('${widget?.activityModel?.categoryName ?? ''}'),
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
                  image: AssetImage(activitiesOverViewDetailImage),
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
                            text:
                                '${widget?.activityModel?.categoryName ?? ''}',
                            fontSize: Get.width * .05,
                            color: white,
                            isProgressIndicator: false),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Total Sub-Topics' +
                            "\t ${widget?.activityModel?.activities?.length ?? 0}",
                        style: MyTextStyle.mulish().copyWith(
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: Get.width * .04),
                      )
                    ],
                  ),
                  CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: totalPercentageAvg ?? 0,
                    stepSize: 10,
                    gradientColor: LinearGradient(colors: [
                      Color(0xff47C9C6),
                      Color(0xff008E8A),
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
            widget.activityModel == null ||
                    widget.activityModel.activities == null ||
                    widget.activityModel.activities.isEmpty
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
                          widget.activityModel.activities.length, (index) {
                        return subTopicsCard(
                            widget.activityModel.activities[index]);
                      }),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget subTopicsCard(GetActivitiesOverviewActivities activities) {
    dynamic value = activities.completed;
    int val = value.toInt();
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
              activities == null ||
                      activities.imageUrl == null ||
                      activities.imageUrl == ''
                  ? Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      child: Image.network(activities.imageUrl),
                    ),
              SizedBox(width: 10),
              Container(
                width: Get.width * .4,
                child: Text(
                  activities?.activityName ?? '',
                  style: MyTextStyle.mulish().copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                      fontSize: Get.width * .04),
                ),
              ),
            ],
          ),
          // progressIndicator(
          //   currentStep: 100,
          //   colorWhite: true,
          //   width: 80,
          //   height: 80,
          // ),
          CircularStepProgressIndicator(
            totalSteps: 100,
            currentStep: val,
            stepSize: 10,
            gradientColor: LinearGradient(colors: [
              Color(0xff47C9C6),
              Color(0xff008E8A),
            ]),
            unselectedColor: Colors.white.withOpacity(.50),
            padding: 0,
            width: 80,
            height: 80,
            selectedStepSize: 17,
            child: Center(
              child: strokedText(
                  color: Color(0xff008E8A),
                  fontSize: Get.width * .04,
                  text: "$val%",
                  isProgressIndicator: true),
            ),
          ),
        ],
      ),
    );
  }
}
