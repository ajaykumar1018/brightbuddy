import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/models/chapters_lesson_model.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/ui/dashboard/home/activities_overview_details_screen.dart';
import 'package:bright_kid/ui/dashboard/home/course_topic_details.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SeeCourseScreen extends StatefulWidget {
  int percentageCompleted;
  int activitiesPercentage;
  String courseName;
  int courseId;
  int homeScreenContainer;
  var data;
  var topicList;
  int yashscreen = -1;

  SeeCourseScreen({
    this.percentageCompleted,
    this.activitiesPercentage,
    this.courseName,
    this.courseId,
    this.homeScreenContainer,
    this.data,
    this.yashscreen,
    this.topicList,
  });

  @override
  _SeeCourseScreenState createState() => _SeeCourseScreenState();
}

class _SeeCourseScreenState extends State<SeeCourseScreen> {
  @override
  void initState() {
    print('----- : ${widget.homeScreenContainer}');
    if (widget.homeScreenContainer == 0) {
      Provider.of<DashboardProvider>(context, listen: false)
          .getChaptersLessonFunc(
        '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
        widget.courseId,
      );
    } else {
      Provider.of<DashboardProvider>(context, listen: false)
          .getActivitiesOverView(
        '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
        widget.courseId,
      );
    }

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
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  margin: EdgeInsets.only(
                    top: Get.height * .037,
                    bottom: Get.height * .03,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  right: 10,
                                  left: 3,
                                ),
                                child: Image.asset(
                                  back,
                                  scale: 4,
                                ),
                              ),
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
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: (loginData?.loginUser?.profilePic == '' ||
                                    loginData?.loginUser?.profilePic == null)
                                ? AssetImage(dp)
                                : NetworkImage(
                                    loginData.loginUser.profilePic,
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05,
                    vertical: Get.height * .02,
                  ),
                  decoration: BoxDecoration(
                    // color: Color(0xff008E8A),
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: AssetImage(widget.homeScreenContainer == 0
                          ? startCourseContainerImage
                          : startCourseContainerImage2),
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
                                text: widget.homeScreenContainer == 0
                                    ? '${widget.courseName}'
                                    : "See Activity Progress",
                                fontSize: Get.width * .05,
                                color: white,
                                isProgressIndicator: false),
                          ),
                          SizedBox(height: 5),
                          widget.homeScreenContainer == 0
                              ? Text(
                                  widget.data == null
                                      ? getTranslated(
                                              Get.context, "total_topics") +
                                          "\t${chapterLessonList?.length ?? 0}"
                                      : getTranslated(
                                              Get.context, "total_topics") +
                                          "\t${widget.data.length}",
                                  style: MyTextStyle.mulish().copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                      fontSize: Get.width * .04),
                                )
                              : Text(
                                  getTranslated(Get.context, "total_topics") +
                                      "\t${getActivitiesOverviewList?.length ?? 0}",
                                  style: MyTextStyle.mulish().copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                      fontSize: Get.width * .04),
                                ),
                        ],
                      ),
                      // progressIndicator(
                      //   currentStep: widget.percentageCompleted,
                      //   fontSize: Get.width * .05,
                      //   colorWhite: false,
                      //   width: 100,
                      //   height: 100,
                      // ),
                      CircularStepProgressIndicator(
                        totalSteps: 100,
                        currentStep: widget.homeScreenContainer == 0
                            ? widget.percentageCompleted
                            : widget.activitiesPercentage,
                        stepSize: 10,
                        gradientColor: LinearGradient(colors: [
                          widget.homeScreenContainer == 0
                              ? Color(0xffFDAF31)
                              : Color(0xff47C9C6),
                          widget.homeScreenContainer == 0
                              ? Color(0xffFDD060)
                              : Color(0xff008E8A),
                        ]),
                        unselectedColor: Colors.white.withOpacity(.50),
                        padding: 0,
                        width: 100,
                        height: 100,
                        selectedStepSize: 17,
                        child: Center(
                          child: strokedText(
                              color: Colors.white,
                              fontSize: Get.width * .05,
                              text: widget.homeScreenContainer == 0
                                  ? "${widget.percentageCompleted}%"
                                  : '${widget.activitiesPercentage}%',
                              isProgressIndicator: true),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * .05),
                  child: strokedText(
                      text: getTranslated(context, "topics"),
                      fontSize: Get.width * .04,
                      color: themeColor,
                      isProgressIndicator: false),
                ),
                SizedBox(height: 10),
                (widget.homeScreenContainer == 0)
                    ? chapterLessonList == null ||
                            chapterLessonList.isEmpty == null
                        ? SizedBox()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    chapterLessonList.length, (index) {
                                  return topicsCard(
                                    chapterLessonList[index],
                                    index,
                                  );
                                }),
                              ),
                            ),
                          )
                    : getActivitiesOverviewList == null ||
                            getActivitiesOverviewList.isEmpty
                        ? SizedBox()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    getActivitiesOverviewList.length, (index) {
                                  return topicsCardForActivities(
                                    getActivitiesOverviewList[index],
                                    index,
                                  );
                                }),
                              ),
                            ),
                          )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget topicsCard(ChaptersLessonModel model, int index) {
    model.images = [
      ChaptersLessonOurImage(image: topicColor1),
      ChaptersLessonOurImage(image: topicColor2),
      ChaptersLessonOurImage(image: topicColor3),
      ChaptersLessonOurImage(image: topicColor4),
      ChaptersLessonOurImage(image: topicColor5),
      ChaptersLessonOurImage(image: topicColor6),
    ];
    return GestureDetector(
      onTap: () {
        Get.to(() => CourseTopicDetails(
              chaptersLessonModel: model,
              courseName: model?.chapterName ?? '',
            ));
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              model.images[model.images.length >= 6 ? index % 6 : index].image),
        )
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xff000000).withOpacity(.16),
            //     spreadRadius: 1,
            //     blurRadius: 4,
            //     offset: Offset(0, 1),
            //   ),
            // ],
            ),
        margin: EdgeInsets.only(
          bottom: 15,
          left: Get.width * .05,
          right: Get.width * .05,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .03,
          horizontal: Get.width * .04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * .6,
              child: Text(
                model?.chapterName ?? '',
                style: MyTextStyle.mulish().copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                    fontSize: Get.width * .038),
              ),
            ),
            // Text(
            //   '1/6',
            //   style: MyTextStyle.mulish().copyWith(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //       fontSize: Get.width * .035),
            // )
          ],
        ),
      ),
    );
  }

  Widget topicsCardyash(String name, String id, int index) {
    ChaptersLessonModel model = chapterLessonList[index];
    model.images = [
      ChaptersLessonOurImage(image: topicColor1),
      ChaptersLessonOurImage(image: topicColor2),
      ChaptersLessonOurImage(image: topicColor3),
      ChaptersLessonOurImage(image: topicColor4),
      ChaptersLessonOurImage(image: topicColor5),
      ChaptersLessonOurImage(image: topicColor6),
    ];
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              model.images[model.images.length >= 6 ? index % 6 : index].image),
        )),
        margin: EdgeInsets.only(
          bottom: 15,
          left: Get.width * .05,
          right: Get.width * .05,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .03,
          horizontal: Get.width * .04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * .6,
              child: Text(
                model?.chapterName ?? '',
                style: MyTextStyle.mulish().copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                    fontSize: Get.width * .038),
              ),
            ),
            // Text(
            //   '1/6',
            //   style: MyTextStyle.mulish().copyWith(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //       fontSize: Get.width * .035),
            // )
          ],
        ),
      ),
    );
  }

  Widget topicsCardForActivities(GetActivitiesOverviewModel model, int index) {
    model.images = [
      GetActivitiesOverviewImages(image: topicColor1),
      GetActivitiesOverviewImages(image: topicColor2),
      GetActivitiesOverviewImages(image: topicColor3),
      GetActivitiesOverviewImages(image: topicColor4),
      GetActivitiesOverviewImages(image: topicColor5),
      GetActivitiesOverviewImages(image: topicColor6),
    ];
    return GestureDetector(
      onTap: () {
        Get.to(() => ActivitiesOverViewDetailsScreen(
              activityModel: model,
            ));
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              model.images[model.images.length >= 6 ? index % 6 : index].image),
        )
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xff000000).withOpacity(.16),
            //     spreadRadius: 1,
            //     blurRadius: 4,
            //     offset: Offset(0, 1),
            //   ),
            // ],
            ),
        margin: EdgeInsets.only(
          bottom: 15,
          left: Get.width * .05,
          right: Get.width * .05,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .03,
          horizontal: Get.width * .04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * .6,
              child: Text(
                model.categoryName,
                style: MyTextStyle.mulish().copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                    fontSize: Get.width * .038),
              ),
            ),
            Text(
              '${model?.activities?.length ?? 0}',
              style: MyTextStyle.mulish().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width * .035),
            )
          ],
        ),
      ),
    );
  }
}
