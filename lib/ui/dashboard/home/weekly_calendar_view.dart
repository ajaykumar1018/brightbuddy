import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/models/weekly_calendar_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class WeeklyCalendarView extends StatefulWidget {
  const WeeklyCalendarView({Key key}) : super(key: key);

  @override
  _WeeklyCalendarViewState createState() => _WeeklyCalendarViewState();
}

class _WeeklyCalendarViewState extends State<WeeklyCalendarView> {

  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false)
        .weeklyCalendarFunc(
      '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
      getEnrollmentModel
          ?.getEnrollmenItems?.first?.courseId ??
          0,
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashProvider, child){
      return ModalProgressHUD(
        inAsyncCall: dashProvider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          appBar: globalAppBar('Calendar View'),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * .05,
              vertical: Get.height * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    strokedText(
                        text: 'Weekly Engagement',
                        fontSize: Get.width * .045,
                        color: themeColor,
                        isProgressIndicator: false),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color:Color(0xffFDAF31),
                                shape: BoxShape.circle,
                              ),
                            ),
                            strokedText(
                                text: 'Activity Progress',
                                fontSize: Get.width * .033,
                                color: themeColor,
                                isProgressIndicator: false),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color:Color(0xff008E8A),
                                shape: BoxShape.circle,
                              ),
                            ),
                            strokedText(
                                text: 'Lesson Progress',
                                fontSize: Get.width * .033,
                                color: themeColor,
                                isProgressIndicator: false),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: weeklyCalendarList?.length??0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _tracker(weeklyCalendarList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _tracker(WeeklyCalendarModel model) {

    dynamic value1 = model.lessonProgress * 100;
    dynamic value2 = model.activityProgress * 100;
    int val1;
    int val2;
    if(value1 >=  100){
      value1 = 100;
      val1 =  value1.toInt();
    }
    else{
      val1 =  value1.toInt();
    }
    if(value2 >= 100){
      value2 = 100;
      val2 =  value2.toInt();
    }
    else{
      val2 =  value2.toInt();
    }


    return Container(
      padding: EdgeInsets.only(left: 7 , right : 7, top: 20),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(.16),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF3F9FE),
            ),
            child: Stack(
              children: [
                CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: val1,
                  stepSize: 0,
                  gradientColor: LinearGradient(colors: [
                    Color(0xff47C9C6),
                    Color(0xff008E8A),
                  ]),
                  unselectedColor: Colors.transparent,
                  padding: 0,
                  width: 100,
                  height: 100,
                  selectedStepSize: 22,
                  child: Center(
                    child: strokedText(
                        color: Colors.transparent,
                        fontSize: Get.width * .05,
                        text: "30%",
                        isProgressIndicator: true),
                  ),
                ),
                Positioned(
                  top: 15,
                  child: CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: val2,
                    stepSize: 10,
                    gradientColor: LinearGradient(colors: [
                      Color(0xffFDAF31),
                      Color(0xffFDD060),
                    ]),
                    unselectedColor: Colors.white.withOpacity(.50),
                    padding: 0,
                    width: 80,
                    height: 80,
                    selectedStepSize: 20,
                    child: FittedBox(
                      child: Center(
                        child: strokedText(
                            color: Colors.red,
                            fontSize: Get.width * .03,
                            text: "${model?.dateRange??''}",
                            isProgressIndicator: true),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          strokedText(
              text: 'Week ${model.week}',
              fontSize: Get.width * .04,
              color: themeColor,
              isProgressIndicator: false),
        ],
      ),
    );
  }
}
