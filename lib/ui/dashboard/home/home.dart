import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/services/show_messages.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/helpers/widgets/logout_bottomsheet.dart';
import 'package:bright_kid/ui/dashboard/home/over_view_screen.dart';
import 'package:bright_kid/ui/dashboard/home/see_course_screen.dart';
import 'package:bright_kid/ui/dashboard/home/start_activity_screen.dart';
import 'package:bright_kid/ui/dashboard/home/weekly_calendar_view.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/global_function.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();

  int secondContainerTotalPercentageActivities;

  int overAllAvg = 0;
  double activitiesAvg = 0.0;

  Future<void> calculateTotalAverage() async {
    await Provider.of<DashboardProvider>(context, listen: false)
        .getEnrollmentFunc();

    activitiesAvg = 0.0;
    overAllAvg = 0;
    getActivitiesOverviewList.forEach((e) {
      // List ratingInside = e.activities.map((e) =>
      //   e.completed * 100,
      // ).toList();
      double sumInside = e.activities.fold(0, (p, c) => p + c.completed);
      print((sumInside / e.activities.length) * 100);
      activitiesAvg += (sumInside / e.activities.length) * 100;

      // if (sumInside > 0) {
      //   double insideAverage = sumInside / ratingInside.length;
      // }
    });
    Future.delayed(Duration(milliseconds: 600), () {
      if (activitiesAvg > 0) {
        overAllAvg = (activitiesAvg / getActivitiesOverviewList.length)
            .ceilToDouble()
            .toInt();
        print(
            "overAll ==> $overAllAvg::: avg ==>$activitiesAvg::length ${getActivitiesOverviewList.length}");
        setState(() {

        });
      } else {
        overAllAvg = 0;
      }
    });
  }

  @override
  void initState() {
    calculateTotalAverage();

    // double sum = ratings.fold(0, (p, c) => p + c);
    // if (sum > 0) {
    //   double average = sum / ratings.length;
    //   totalPercentageAvg = average.toInt();
    //   print(totalPercentageAvg);
    // }

    super.initState();
  }

  String greeting() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, _) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: WillPopScope(
          onWillPop: onWillPop,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: scaffold,
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.only(
                        top: Get.height * .045,
                        bottom: Get.height * .01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: strokedText(
                                    color: themeColor,
                                    fontSize: Get.width * .045,
                                    text: '${greeting()}!',
                                    isProgressIndicator: false),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: Text(
                                  loginData?.loginUser?.name ?? '',
                                  style: MyTextStyle.mulish().copyWith(
                                      fontSize: Get.width * .035,
                                      color: lightBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(LogoutBottomSheet());
                            },
                            child: Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      (loginData?.loginUser?.profilePic == '')
                                          ? AssetImage(dp)
                                          : NetworkImage(
                                              loginData.loginUser.profilePic,
                                            ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * .04),
                    Row(
                      children: [
                        strokedText(
                            text: 'Course',
                            fontSize: Get.width * .045,
                            color: themeColor,
                            isProgressIndicator: false),
                        Spacer(),
                        Image.asset(calendarIcon, scale: 1.8),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => WeeklyCalendarView());
                          },
                          child: Text(
                            'weekly calendar',
                            style: MyTextStyle.mulishBlack().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * .045,
                              color: themeColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            subjectContainer(0, homeImage1),
                            SizedBox(height: 10),
                            subjectContainer(1, homeImage2),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget subjectContainer(int index, String img) {
    double percentage = double.parse(
        getEnrollmentModel?.getEnrollmenItems?.first?.percentageCompleted ??
            '0.0');
    double percentage2 = percentage * 100;
    int inPercentage = percentage2.round();
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: Get.width,
      height: Get.height * .5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xffF2F2F2), Color(0xffDDE7FB)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(.25),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height * .25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                ),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.fill,
                )),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    index == 0
                        ? getEnrollmentModel
                                ?.getEnrollmenItems?.first?.courseName ??
                            ''
                        : "${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''} activities",
                    textAlign: TextAlign.center,
                    style: MyTextStyle.mulishBlack().copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff314A72),
                        fontSize: Get.width * .04),
                  ),
                  SizedBox(height: Get.height * .04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      startCourseWidget(
                        0,
                        index == 0 ? 'See Overview' : 'See Progress',
                        overViewIcon,
                        index == 0
                            ? OverViewScreen(
                                courseId: getEnrollmentModel
                                        ?.getEnrollmenItems?.first?.courseId ??
                                    0,
                              )
                            : SeeCourseScreen(
                                percentageCompleted: inPercentage,
                                activitiesPercentage: overAllAvg,
                                courseName:
                                    '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}',
                                courseId: getEnrollmentModel
                                        ?.getEnrollmenItems?.first?.courseId ??
                                    0,
                                homeScreenContainer: index,
                              ),
                      ),
                      startCourseWidget(
                        1,
                        index == 0 ? 'See Progress' : 'Start Activity',
                        startCourseIcon,
                        index == 0
                            ? SeeCourseScreen(
                                percentageCompleted: inPercentage,
                                activitiesPercentage: overAllAvg,
                                courseName:
                                    '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}',
                                courseId: getEnrollmentModel
                                        ?.getEnrollmenItems?.first?.courseId ??
                                    0,
                                homeScreenContainer: index,
                              )
                            : StartActivityScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: Get.height * .19,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: index == 0 ? inPercentage : overAllAvg,
                  stepSize: 10,
                  gradientColor: LinearGradient(colors: [
                    Color(0xffFDAF31),
                    Color(0xffFDD060),
                  ]),
                  unselectedColor: Colors.white.withOpacity(.50),
                  padding: 0,
                  width: 80,
                  height: 80,
                  selectedStepSize: 17,
                  child: Center(
                    child: strokedText(
                        color: lightBlue,
                        fontSize: Get.width * .04,
                        text: index == 1 ? "$overAllAvg%" : "$inPercentage%",
                        // text: "100%",
                        isProgressIndicator: true),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget startCourseWidget(int index, String text, image, Widget screen) {
    return GestureDetector(
      onTap: () {
        Get.to(() => screen);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, scale: 4),
            SizedBox(height: 4),
            Text(
              text,
              style: MyTextStyle.mulish().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff314A72),
                  fontSize: Get.width * .033),
            ),
          ],
        ),
      ),
    );
  }
}
