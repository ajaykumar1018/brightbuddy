import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class StartActivityScreen extends StatefulWidget {
  const StartActivityScreen({Key key}) : super(key: key);

  @override
  _StartActivityScreenState createState() => _StartActivityScreenState();
}

class _StartActivityScreenState extends State<StartActivityScreen> {
  GetActivitiesOverviewModel activityCategorySelected;
  GetActivitiesOverviewActivities activitySubCategorySelected;
  List<String> activityCategoryList = [];
  List<GetActivitiesOverviewActivities> activitySubActivityList = [];
  CountDownController _controller = CountDownController();
  int _duration = 6000;
  bool timerStarted;
  DateTime date;
  int totalMinutes;

  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false)
        .getActivitiesOverView(
      '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
      getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    );

    activityCategoryList.clear();
    print('before my list length ${activityCategoryList.length}');
    print('before api list length ${getActivitiesOverviewList.length}');
    getActivitiesOverviewList.forEach((element) {
      activityCategoryList.add(element.categoryName);
    });
    timerStarted = false;
    print('after my list length ${activityCategoryList.length}');
    print('after api list length ${getActivitiesOverviewList.length}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashProvider, child) {
      return ModalProgressHUD(
        inAsyncCall: dashProvider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          appBar: globalAppBar('Start Activity'),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              if (activityCategorySelected == null) {
                Get.snackbar(
                    'Activity Category', 'Please select activity category',
                    backgroundColor: themeColor,
                    colorText: Colors.white,
                    progressIndicatorBackgroundColor: Colors.lightBlueAccent,
                    progressIndicatorValueColor:
                        AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    borderRadius: 6);
              } else if (activitySubCategorySelected == null) {
                Get.snackbar('Sub Category Activity',
                    'Please select sub-category activity',
                    backgroundColor: themeColor,
                    colorText: Colors.white,
                    progressIndicatorBackgroundColor: Colors.lightBlueAccent,
                    progressIndicatorValueColor:
                        AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    borderRadius: 6);
              } else if (timerStarted == false && date == null){
                Get.snackbar(
                    'Activity Timer', 'Please start timer for activity',
                    backgroundColor: themeColor,
                    colorText: Colors.white,
                    progressIndicatorBackgroundColor: Colors.lightBlueAccent,
                    progressIndicatorValueColor:
                    AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    borderRadius: 6);
              }
              else {
                print('ok');
                _controller.pause();
                timerStarted = false;
                date = DateFormat('mm:ss').parse(_controller.getTime());
                totalMinutes = date.minute;
                print('date $totalMinutes');
                if(date.second >= 1){
                  totalMinutes = totalMinutes +1;
                }
                setState(() {});
                dashProvider.submitActivity(
                  getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? '',
                  getEnrollmentModel
                      ?.getEnrollmenItems?.first?.courseId ??
                      0,
                    activityCategorySelected.categoryId,
                    activitySubCategorySelected.activityCode,
                  totalMinutes,
                    activitySubCategorySelected.activityName,
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * .13,
                vertical: Get.height * .02,
              ),
              child: gradientButton(
                  text: 'Submit', width: Get.width, height: Get.height * .065),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset(
                    startActivityImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text: 'Select Activity Category',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),
                _dropDown(
                  hintText: 'Activity Category',
                  itemsList: getActivitiesOverviewList,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text: 'Select Activity',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Get.width * .05,
                    vertical: Get.height * .01,
                  ),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1.2, color: white),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff888888).withOpacity(.26),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(border: InputBorder.none),
                        child: DropdownButtonHideUnderline(
                          child:
                              DropdownButton<GetActivitiesOverviewActivities>(
                            value: activitySubCategorySelected,
                            icon: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: limeYellow,
                              ),
                            ),
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                activitySubCategorySelected = newValue;
                                // if (index == 0) {
                                //   activityCategorySelected = newValue;
                                //   var _activities =  getActivitiesOverviewList
                                //       .where((element) =>
                                //   element.categoryName == activityCategorySelected).toList();
                                //   if(_activities.isNotEmpty){
                                //     activitySubActivityList =  _activities.first.activities
                                //     ;}
                                // } else {
                                //   activitySubCategorySelected = newValue;
                                // }
                              });
                            },
                            hint: Padding(
                              padding: EdgeInsets.only(left: 28),
                              child: Text(
                                "Select Activities",
                                style: MyTextStyle.mulishBlack()
                                    .copyWith(fontSize: 14, color: themeColor),
                              ),
                            ),
                            items: activitySubActivityList.map((GetActivitiesOverviewActivities value) {
                              return DropdownMenuItem<
                                  GetActivitiesOverviewActivities>(
                                value: value,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 28),
                                  child: Text(
                                    value.activityName,
                                    style: MyTextStyle.mulishBlack().copyWith(
                                        fontSize: 14, color: themeColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.height * .05,
                    left: Get.width * .05,
                    right: Get.width * .05,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CircularCountDownTimer(
                          duration: _duration,
                          initialDuration: 0,
                          controller: _controller,
                          width: 10,
                          height: 130,
                          ringColor: Color(0xffE1E6EC),
                          ringGradient: null,
                          fillColor: Color(0xff9D5AD2),
                          fillGradient: null,
                          backgroundColor: Color(0xffE6D9EF),
                          backgroundGradient: null,
                          strokeWidth: 6,
                          strokeCap: StrokeCap.round,
                          textStyle: TextStyle(
                              fontSize: 25.0,
                              color: themeColor,
                              fontWeight: FontWeight.bold),
                          textFormat: CountdownTextFormat.MM_SS,
                          isReverse: false,
                          isReverseAnimation: false,
                          isTimerTextShown: true,
                          autoStart: false,
                          onStart: () {
                            print('Countdown Started');
                          },
                          onComplete: () {
                            setState(() {
                              date = DateFormat('mm:ss').parse(_controller.getTime());
                            });
                            print('Countdown Ended');
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (timerStarted) {
                              _controller.pause();
                              timerStarted = false;
                              date = DateFormat('mm:ss').parse(_controller.getTime());
                              totalMinutes = date.minute;
                              if(date.second >= 1){
                                totalMinutes = totalMinutes +1;
                              }
                              print('date $totalMinutes');
                              setState(() {});
                            } else {
                              _controller.start();
                              timerStarted = true;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: Get.width,
                            height: Get.height * .065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: timerStarted ? Colors.red : Color(0xff8DC640),
                            ),
                            child: Center(
                              child: Text(
                                timerStarted ? 'Stop Timer' : 'Start Timer',
                                style: MyTextStyle.mulish().copyWith(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Get.width * .04),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // dropdown field
  Widget _dropDown({
    String hintText,
    List<GetActivitiesOverviewModel> itemsList,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .05,
        vertical: Get.height * .01,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1.2, color: white),
        boxShadow: [
          BoxShadow(
            color: Color(0xff888888).withOpacity(.26),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(border: InputBorder.none),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<GetActivitiesOverviewModel>(
                value: activityCategorySelected,
                icon: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: limeYellow,
                  ),
                ),
                isDense: true,
                onChanged: (GetActivitiesOverviewModel newValue) {
                  setState(() {
                    // activitySubActivityList.clear();
                    activitySubCategorySelected = null;
                    activityCategorySelected = newValue;
                    if (activityCategorySelected.activities.isNotEmpty) {
                      activitySubActivityList = activityCategorySelected.activities;
                    }
                  });

                },
                hint: Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    hintText,
                    style: MyTextStyle.mulishBlack()
                        .copyWith(fontSize: 14, color: themeColor),
                  ),
                ),
                items: itemsList.map((GetActivitiesOverviewModel value) {
                  return DropdownMenuItem<GetActivitiesOverviewModel>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        value.categoryName,
                        style: MyTextStyle.mulishBlack()
                            .copyWith(fontSize: 14, color: themeColor),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
