//Montesori
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
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class StartActivityScreen extends StatefulWidget {
  const StartActivityScreen({Key key}) : super(key: key);

  @override
  _StartActivityScreenState createState() => _StartActivityScreenState();
}

class _StartActivityScreenState extends State<StartActivityScreen> {
  double cw = 0, fmw = 0, sw = 0, aw = 0, lw = 0;
  GetActivitiesOverviewModel activityCategorySelected;
  GetActivitiesOverviewActivities activitySubCategorySelected;
  TextEditingController timees = TextEditingController();
  List<String> activityCategoryList = [];
  List<GetActivitiesOverviewActivities> activitySubActivityList = [];
  List<GetActivitiesOverviewActivities> subActivities = [];

  int timeF = 0;

  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];
  var dataMap;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    dataMap = <String, double>{
      "Cognitive Skill": cw,
      "Fine Motor Skills": fmw,
      "Sensorial Skills": sw,
      "Arithmetic Skills": aw,
      "Language Skills": lw,
    };

    await Provider.of<DashboardProvider>(context, listen: false)
        .getActivitiesOverView(
      '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
      getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    );

    activityCategoryList.clear();
    setState(() {});
    print('before my list length ssx ${activityCategoryList.length}');
    print('before api list length ${getActivitiesOverviewList.length}');
    getActivitiesOverviewList.forEach((element) {
      activityCategoryList.add(element.categoryName);

      for (int i = 0; i < element.activities.length; i++) {
        element.activities[i].parent_category_id = element.categoryId;
        subActivities.add(element.activities[i]);
      }
    });

    print("THIS ARE ALL THE SUB ACTIVITIES");
    print(subActivities.length);
    print('after my list length ${activityCategoryList.length}');
    print('after api list length ${getActivitiesOverviewList.length}');
  }

  DateTime _dateTime = DateTime.now();

  //Time cha kahitari

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
              // if (activityCategorySelected == null) {
              //   Get.snackbar(
              //       'Activity Category', 'Please select activity category',
              //       backgroundColor: themeColor,
              //       colorText: Colors.white,
              //       progressIndicatorBackgroundColor: Colors.lightBlueAccent,
              //       progressIndicatorValueColor:
              //           AlwaysStoppedAnimation<Color>(Colors.tealAccent),
              //       borderRadius: 6);
              // } else
              if (activitySubCategorySelected == null) {
                Get.snackbar('Sub Category Activity',
                    'Please select sub-category activity',
                    backgroundColor: themeColor,
                    colorText: Colors.white,
                    progressIndicatorBackgroundColor: Colors.lightBlueAccent,
                    progressIndicatorValueColor:
                        AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    borderRadius: 6);
              } else {
                setState(() {});
                dashProvider.submitActivity(
                  getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? '',
                  getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
                  activitySubCategorySelected.parent_category_id,
                  activitySubCategorySelected.activityCode,
                  timeF,
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
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                //   child: strokedText(
                //     text: 'Select Activity Category',
                //     fontSize: Get.width * .043,
                //     color: themeColor,
                //     isProgressIndicator: false,
                //   ),
                // ),
                // _dropDown(
                //   hintText: 'Activity Category',
                //   itemsList: getActivitiesOverviewList,
                // ),
                SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                //   child: strokedText(
                //     text: 'Select Activity',
                //     fontSize: Get.width * .043,
                //     color: themeColor,
                //     isProgressIndicator: false,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text: 'Select Activity',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),
                _dropDown2(
                  hintText: 'Select Activities',
                  itemsList: subActivities,
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(
                //     horizontal: Get.width * .05,
                //     vertical: Get.height * .01,
                //   ),
                //   decoration: BoxDecoration(
                //     color: white,
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border.all(width: 1.2, color: white),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Color(0xff888888).withOpacity(.26),
                //         spreadRadius: 1,
                //         blurRadius: 4,
                //         offset: Offset(4, 4),
                //       ),
                //     ],
                //   ),
                //   child: FormField<String>(
                //     builder: (FormFieldState<String> state) {
                //       return InputDecorator(
                //         decoration: InputDecoration(border: InputBorder.none),
                //         child: DropdownButtonHideUnderline(
                //           child:
                //               DropdownButton<GetActivitiesOverviewActivities>(
                //             value: activitySubCategorySelected,
                //             icon: Padding(
                //               padding: EdgeInsets.only(right: 15),
                //               child: Icon(
                //                 Icons.keyboard_arrow_down,
                //                 color: limeYellow,
                //               ),
                //             ),
                //             isDense: true,
                //             onChanged: (newValue) {
                //               setState(() {
                //                 activitySubCategorySelected = newValue;
                //                 // if (index == 0) {
                //                 //   activityCategorySelected = newValue;
                //                 //   var _activities =  getActivitiesOverviewList
                //                 //       .where((element) =>
                //                 //   element.categoryName == activityCategorySelected).toList();
                //                 //   if(_activities.isNotEmpty){
                //                 //     activitySubActivityList =  _activities.first.activities
                //                 //     ;}
                //                 // } else {
                //                 //   activitySubCategorySelected = newValue;
                //                 // }
                //               });
                //             },
                //             hint: Padding(
                //               padding: EdgeInsets.only(left: 28),
                //               child: Text(
                //                 "Select Activities",
                //                 style: MyTextStyle.mulishBlack()
                //                     .copyWith(fontSize: 14, color: themeColor),
                //               ),
                //             ),
                //             items: activitySubActivityList
                //                 .map((GetActivitiesOverviewActivities value) {
                //               return DropdownMenuItem<
                //                   GetActivitiesOverviewActivities>(
                //                 value: value,
                //                 child: Padding(
                //                   padding: EdgeInsets.only(left: 28),
                //                   child: Text(
                //                     value.activityName == null
                //                         ? ""
                //                         : value.activityName,
                //                     style: MyTextStyle.mulishBlack().copyWith(
                //                         fontSize: 14, color: themeColor),
                //                   ),
                //                 ),
                //               );
                //             }).toList(),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text:
                        'This activity improves your skills as per the following composition : ',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),
                SizedBox(height: 20),
                PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  centerText: "",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: false,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                  // gradientList: ---To add gradient colors---
                  // emptyColorGradient: ---Empty Color gradient---
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text: 'Enter Time Duration',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      child: TextField(
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        controller: timees,
                        keyboardType: TextInputType.phone,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "0",
                        ),
                        onChanged: (text) {
                          setState(() {
                            timeF = int.parse(text);
                            // print(searchField);
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 0),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * .05),
                      child: strokedText(
                        text: 'minutes',
                        fontSize: Get.width * .043,
                        color: themeColor,
                        isProgressIndicator: false,
                      ),
                    ),
                  ],
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
                      activitySubActivityList =
                          activityCategorySelected.activities;
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

  Widget _dropDown2({
    String hintText,
    List<GetActivitiesOverviewActivities> itemsList,
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
              child: DropdownButton<GetActivitiesOverviewActivities>(
                value: activitySubCategorySelected,
                icon: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: limeYellow,
                  ),
                ),
                isDense: true,
                onChanged: (GetActivitiesOverviewActivities newValue) {
                  setState(() {
                    activitySubCategorySelected = newValue;

                    cw = newValue.cw.toDouble();
                    aw = newValue.aw.toDouble();
                    fmw = newValue.fmw.toDouble();
                    lw = newValue.lw.toDouble();
                    sw = newValue.sw.toDouble();

                    dataMap = <String, double>{
                      "Cognitive Skill": cw,
                      "Fine Motor Skills": fmw,
                      "Sensorial Skills": sw,
                      "Arithmetic Skills": aw,
                      "Language Skills": lw,
                    };

                    // Pie chart values
                    print(cw);
                    print(aw);
                    print(fmw);
                    print(sw);
                    print(lw);
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
                items: itemsList.map((GetActivitiesOverviewActivities value) {
                  return DropdownMenuItem<GetActivitiesOverviewActivities>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        value.activityName,
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

  /// SAMPLE
  Widget hourMinute12H() {
    return TimePickerSpinner(
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget hourMinuteSecond() {
    return TimePickerSpinner(
      isShowSeconds: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget hourMinute15Interval() {
    return TimePickerSpinner(
      normalTextStyle: TextStyle(fontSize: 20),
      itemHeight: 40,
      itemWidth: 40,
      spacing: 40,
      minutesInterval: 1,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
          timeF = _dateTime.hour * 60 + _dateTime.minute;
          print(timeF);
        });
      },
    );
  }

  Widget hourMinute12HCustomStyle() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.deepOrange),
      highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.yellow),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      minutesInterval: 15,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
