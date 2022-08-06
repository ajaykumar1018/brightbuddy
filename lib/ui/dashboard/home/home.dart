import 'dart:convert';
import 'dart:io';
import 'package:bright_kid/MesiboPlugin.dart';
import 'package:bright_kid/models/admin_detail.dart';
import 'package:bright_kid/models/user_token_for_mesibo.dart';
import 'package:bright_kid/services/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/services/api_request.dart';
import 'package:bright_kid/helpers/services/api_url.dart';
import 'package:bright_kid/helpers/services/show_messages.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/helpers/widgets/logout_bottomsheet.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/models/get_enrollment_model.dart';
import 'package:bright_kid/models/notice_model.dart';
import 'package:bright_kid/ui/dashboard/home/all_craft_activities.dart';
import 'package:bright_kid/ui/dashboard/home/mont_library_screen.dart';
import 'package:bright_kid/ui/dashboard/home/notice_board_view.dart';
import 'package:bright_kid/ui/dashboard/home/over_view_screen.dart';
import 'package:bright_kid/ui/dashboard/home/overview2.dart';
import 'package:bright_kid/ui/dashboard/home/see_course_screen.dart';
import 'package:bright_kid/ui/dashboard/home/see_course_screen2.dart';
import 'package:bright_kid/ui/dashboard/home/see_course_screen3.dart';
import 'package:bright_kid/ui/dashboard/home/start_activity_screen.dart';
import 'package:bright_kid/ui/dashboard/home/start_activity_screen2.dart';
import 'package:bright_kid/ui/dashboard/home/weekly_calendar_view.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/global_function.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:badges/badges.dart';

import 'package:device_apps/device_apps.dart';
import 'package:launch_review/launch_review.dart';
import 'package:bright_kid/token_monitor.dart';
// import 'MesiboPlugin.dart';
import 'package:flutter/services.dart';

import 'package:bright_kid/services/local_notification.dart';

class DemoUser {
  String token;
  String address;

  DemoUser(String t, String a) {
    token = t;
    address = a;
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  int noticeCount;
  List<Notice> notices;
  UserToken tokenDetails;
  List<AdminDetail> adminDetails;
  int secondContainerTotalPercentageActivities;

  int overAllAvg = 0;
  double activitiesAvg = 0.0;
  static MesiboPluginApi _mesibo = MesiboPluginApi();
  static const callbacks = const MethodChannel("mesibo.com/callbacks");
  String mesiboStatus = 'Mesibo status: Not Connected.';

  Text mStatusText;

  String remoteUser;
  bool mOnline = false, mLoginDone = false;

  String _token;
  Future<void> calculateTotalAverage() async {
    await Provider.of<DashboardProvider>(context, listen: false)
        .getEnrollmentFunc()
        .then((value) {
      activitiesAvg = 0.0;
      overAllAvg = 0;
      getActivitiesOverviewList.forEach((e) {
        // List ratingInside = e.activities.map((e) =>
        //   e.completed * 100,
        // ).toList();
        double sumInside = e.activities.fold(0, (p, c) => p + c.completed);
        // print((sumInside / e.activities.length) * 100);
        if (e.activities.length != 0)
          activitiesAvg += (sumInside / e.activities.length) * 100;

        // if (sumInside > 0) {
        //   double insideAverage = sumInside / ratingInside.length;
        // }
      });
      if (activitiesAvg > 0 && getActivitiesOverviewList.length > 0) {
        overAllAvg = (activitiesAvg / (getActivitiesOverviewList.length * 100))
            .ceilToDouble()
            .toInt();
        print(
            "overAll ==> $overAllAvg::: avg ==>$activitiesAvg::length ${getActivitiesOverviewList.length}");
        setState(() {});
      } else {
        overAllAvg = 0;
      }

      print("overall AVG is  : ");
      print(overAllAvg);
    });
  }

  void setToken(String token) {
    print('======================FCM Token===================: $token');
    setState(() {
      _token = token;
    });
  }

  Stream<String> _tokenStream;
  @override
  void initState() {
    calculateTotalAverage();
    getEnrollmentFunc4();
    getEnrollmentFunc5();
    getNotices();

    getMesiboDetails();
    // getUserToken();

    super.initState();
    callbacks.setMethodCallHandler(callbackHandler);

    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BHVAy2ic9La0QZyPzpQEh7PgYoeMMH0s4Cj1lqpIpMgvhJiO2IsczkIlKnePalOulPEeRdH17Mve_r_Oq4Bpv0A')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification.title);
          print(message.notification.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification.title);
          print(message.notification.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  void Mesibo_onConnectionStatus(int status) {
    print('Mesibo_onConnectionStatus: ' + status.toString());
    mesiboStatus = 'Mesibo status: ' + status.toString();
    setState(() {});

    if (1 == status) mOnline = true;
  }

  // void showNotifocation() {}

  Future<dynamic> callbackHandler(MethodCall methodCall) async {
    print('Native call!');
    var args = methodCall.arguments;
    print('Above method call ===========${methodCall.method}');
    switch (methodCall.method) {
      case "Mesibo_onConnectionStatus":
        Mesibo_onConnectionStatus(args['status'] as int);
        return "";
        break;
      case 'Mesibo_onMessage':
        // showNotificaion();
        break;
      default:
        return "";
        break;
    }
  }

  bool isLoading2 = false;
  Future getMesiboDetails() async {
    isLoading2 = true;
    Future.wait([
      getUserToken(),
      getAdminDetail(),
    ]).then((value) {
      isLoading2 = false;
      print('value all: $value');
      DemoUser user = DemoUser(value[0], loginData?.loginUser?.email);
      _loginUser1(user, value[1]);
    }).catchError((err) {
      print(err);
      isLoading2 = false;
    });
  }

  Future<dynamic> getUserToken() async {
    tokenDetails = await ApiRequest().getUserToken(
      loginData?.loginUser?.email,
    );
    if (tokenDetails != null) {
      return tokenDetails.mesiboUserToken;
    }
  }

  Future<dynamic> getAdminDetail() async {
    adminDetails = await ApiRequest().getAdminDetail(
      loginData?.loginUser?.schoolCode,
    );

    if (adminDetails != null) {
      return adminDetails[0].email;
    }
    // return adminDetails;
  }

  getNotices() async {
    notices = await ApiRequest().getNotices(
        loginData?.loginUser?.schoolCode,
        loginData?.loginUser?.email,
        loginData?.loginUser?.role,
        loginData?.loginUser?.level);
    if (notices != null) {
      setState(() {
        notices = notices.where((element) => !element.acknowledgment).toList();
        noticeCount = notices.length;
      });
    } else {
      notices = [];
      setState(() {
        noticeCount = 0;
      });
    }
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

  bool isLoading = false;

  Future getEnrollmentFunc4() async {
    isLoading = true;
    await apiRequest
        .getEnrollment(loginData?.loginUser?.email ?? '')
        .then((response) async {
      if (response != false) {
        getEnrollmentModel = GetEnrollmentModel.fromJson(response);
        await getCraftActivities2(
          '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
          getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
        );
      } else {
        isLoading = false;
      }
    });
  }

  Future getEnrollmentFunc5() async {
    isLoading = true;
    await apiRequest
        .getEnrollment(loginData?.loginUser?.email ?? '')
        .then((response) async {
      if (response != false) {
        getEnrollmentModel = GetEnrollmentModel.fromJson(response);
        await getGiffyData2(
          '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
          getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
        );
      } else {
        isLoading = false;
      }
    });
  }

  var craftData, giffyData;
  int sum = 0, total = 0, craft_percentage = 0;
  int sum1 = 0, total1 = 0, giffy_percentage = 0;
  double percentage = 0;
  double percentage2 = 0;
  int intPercentage = 0, intPercentage1 = 0;
  List craftActivityList = [];
  var enrolled_course_name;

  Future getCraftActivities2(String email, int courseId) async {
    isLoading = true;
    await apiRequest.getCraftActivities(email, courseId).then((response) {
      isLoading = false;
      craftData = response;
      if (response != false) {
        getActivitiesOverviewList.clear();
        response.forEach((res) {
          int t = res['activities'].length;
          for (int i = 0; i < t; i++) {
            if (res['activities'][i]['completed'] == 1) sum++;
            craftActivityList.add(res['activities'][i]);
            total++;
          }
        });
      }
    });
    double percentage;
    setState(() {
      if (total == 0 || total == null) {
        percentage = 0;
      } else {
        percentage = (sum / total);
      }
      double percentage2 = percentage * 100;
      intPercentage = percentage2.round();
    });
  }

  Future getGiffyData2(String email, int courseId) async {
    isLoading = true;
    await getGiffyData(email, courseId).then((response) {
      isLoading = false;
      giffyData = response;
      print("GIFFYDATA");
      print(giffyData);
      if (response != false) {}
    });

    if (total1 == 0) {
      setState(() {
        double percentage = 0.0;
        percentage = (0.00);
        double percentage2 = percentage * 100;
        intPercentage1 = percentage2.round();
      });
    } else {
      setState(() {
        double percentage = 0.0;
        percentage = (sum1 / total1);
        double percentage2 = percentage * 100;
        intPercentage1 = percentage2.round();
      });
    }
  }

  Future getCraftActivities(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url =
          Apis.craftActivitiesList + "?email=$email&course_id=$courseId";
      // print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      // print('response Craft :\n');
      // print('this is body Craft : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future getGiffyData(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.giffy + "?email=$email&course_id=$courseId";
      // print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      // print('response Craft :\n');
      // print('this is body Craft : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  bool isLoading1 = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, _) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading || isLoading1 || isLoading2,
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
                                  image: (loginData?.loginUser?.profilePic ==
                                              '' ||
                                          loginData?.loginUser?.profilePic ==
                                              null)
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
                    GestureDetector(
                      onTap: () {
                        Get.to(() => MontLibraryScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Spacer(),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                bookCheckIcon,
                              ),
                              SizedBox(width: 5),
                              Column(children: [
                                Text(
                                  'Mont.',
                                  style: MyTextStyle.mulishBlack().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width * .045,
                                    color: themeColor,

                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'Library',
                                  style: MyTextStyle.mulishBlack().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width * .045,
                                    color: themeColor,

                                    //decoration: TextDecoration.underline,
                                  ),
                                )
                              ]),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _showMessages();
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  messageIcon,
                                ),
                                SizedBox(width: 5),
                                Column(children: [
                                  Text(
                                    'Messages',
                                    style: MyTextStyle.mulishBlack().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width * .045,
                                      color: themeColor,

                                      //decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => NoticeBoardView());
                            },
                            child: Column(
                              children: <Widget>[
                                noticeCount != null && noticeCount > 0
                                    ? Badge(
                                        badgeContent: Text(
                                          noticeCount.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        badgeColor:
                                            Color.fromRGBO(190, 2, 2, 1),
                                        child: Image.asset(
                                          noticeBoardIcon,
                                        ),
                                      )
                                    : Image.asset(
                                        noticeBoardIcon,
                                      ),
                                SizedBox(width: 5),
                                Column(children: [
                                  Text(
                                    'Notice',
                                    style: MyTextStyle.mulishBlack().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width * .045,
                                      color: themeColor,

                                      //decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Text(
                                    'Board',
                                    style: MyTextStyle.mulishBlack().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width * .045,
                                      color: themeColor,

                                      //decoration: TextDecoration.underline,
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => WeeklyCalendarView(),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  calendarMonthIcon,
                                ),
                                SizedBox(width: 5),
                                Column(children: [
                                  Text(
                                    'Weekly',
                                    style: MyTextStyle.mulishBlack().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width * .045,
                                      color: themeColor,

                                      //decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Text(
                                    'Tracking',
                                    style: MyTextStyle.mulishBlack().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width * .045,
                                      color: themeColor,

                                      //decoration: TextDecoration.underline,
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            subjectContainer(0, homeImage1),
                            SizedBox(height: 10),
                            subjectContainer(1, 'assets/images/Montessori.png'),
                            SizedBox(height: 10),
                            subjectContainerNurseryCraftActivities(
                                1, 'assets/images/ArtnCarfts.png'),
                            SizedBox(height: 10),
                            subjectContainerNurseryBrightGiffy(
                                0, 'assets/images/BrightGiffy.png'),
                            SizedBox(height: 10),
                            subjectContainerScanner(
                                0, 'assets/images/ARScanner.png'),
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
    enrolled_course_name =
        '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}'
            .split(":")[0];
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
                        ? '$enrolled_course_name :  Concepts\nRevision & Practice Tracker'
                        : "$enrolled_course_name :  Montessori Activities\nRevision & Practice Tracker",
                    // ? getEnrollmentModel
                    //         ?.getEnrollmenItems?.first?.courseName ??
                    //     ''
                    // : "${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''} activities",
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
          enrolled_course_name.replaceAll(RegExp(r"\s+"), "") == 'Level'
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black54,
                      child: Stack(
                        children: [
                          Positioned(
                            top: Get.height * .01,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 75.0,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Locked',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Not registered for DIY @ Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Please ask center for registration',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget subjectContainerNurseryCraftActivities(int index, String img) {
    enrolled_course_name =
        '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}'
            .split(":")[0];
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
                    "$enrolled_course_name :  Craft Activities\nPractice Tracking",
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
                        'See Progress',
                        overViewIcon,
                        SeeCourseScreen3(
                          percentageCompleted: intPercentage,
                          activitiesPercentage: intPercentage,
                          courseName:
                              '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}',
                          courseId: getEnrollmentModel
                                  ?.getEnrollmenItems?.first?.courseId ??
                              0,
                          homeScreenContainer: index,
                          yashscreen: 3,
                          data: craftData,
                        ),
                      ),
                      startCourseWidget(
                        1,
                        'Start Activity',
                        startCourseIcon,
                        StartActivityScreen2(data: craftData),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLoading1 = true;
                          });
                          craftActivityList.clear();
                          getEnrollmentFunc4().then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllCraftActivities(
                                        data: craftActivityList,
                                      )),
                            );
                            setState(() {
                              isLoading1 = false;
                            });
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/learning.png',
                                  scale: 9),
                              SizedBox(height: 4),
                              Text(
                                'My Crafts',
                                style: MyTextStyle.mulish().copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff314A72),
                                    fontSize: Get.width * .033),
                              ),
                            ],
                          ),
                        ),
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
                  currentStep: index == 1 ? intPercentage : overAllAvg,
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
                        text: "$intPercentage%",
                        // text: "100%",
                        isProgressIndicator: true),
                  ),
                ),
              ),
            ),
          ),
          enrolled_course_name.replaceAll(RegExp(r"\s+"), "") == 'Level'
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black54,
                      child: Stack(
                        children: [
                          Positioned(
                            top: Get.height * .01,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 75.0,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Locked',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Not registered for DIY @ Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Please ask center for registration',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget subjectContainerNurseryBrightGiffy(int index, String img) {
    enrolled_course_name =
        '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}'
            .split(":")[0];
    double percentageBrightGiffy = double.parse(getEnrollmentModel
            ?.getEnrollmenItems?.first?.giffyPercentageCompleted ??
        '0.0');
    print("percentageBrightGiffy: $percentageBrightGiffy");
    double percentageBrightGiffy2 = percentageBrightGiffy * 100;
    int inPercentageBrightGiffy = percentageBrightGiffy2.round();
    print("BRIGHT GOFFY PERCENTAGE: $inPercentageBrightGiffy");
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
                    "$enrolled_course_name :  Interactive Fun Learning\nPractice Tracker",
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
                          'See Overview',
                          overViewIcon,
                          OverViewScreen2(
                            courseId: getEnrollmentModel
                                    ?.getEnrollmenItems?.first?.courseId ??
                                0,
                            data: giffyData,
                          )),
                      startCourseWidget(
                          1,
                          'See Progress',
                          startCourseIcon,
                          SeeCourseScreen2(
                            percentageCompleted: inPercentageBrightGiffy,
                            activitiesPercentage: inPercentageBrightGiffy,
                            // percentageCompleted: intPercentage1,
                            // activitiesPercentage: intPercentage1,
                            courseName: '$enrolled_course_name :  Bright Giffy',
                            courseId: getEnrollmentModel
                                    ?.getEnrollmenItems?.first?.courseId ??
                                0,
                            homeScreenContainer: index,
                            data: giffyData,
                            yashscreen: 4,
                          )),
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
                  // currentStep: index == 0 ? intPercentage1 : overAllAvg,
                  currentStep:
                      index == 0 ? inPercentageBrightGiffy : overAllAvg,
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
                        // text: "$intPercentage1%",
                        text: "$inPercentageBrightGiffy%",
                        // text: "100%",
                        isProgressIndicator: true),
                  ),
                ),
              ),
            ),
          ),
          enrolled_course_name.replaceAll(RegExp(r"\s+"), "") == 'Level'
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black54,
                      child: Stack(
                        children: [
                          Positioned(
                            top: Get.height * .01,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 75.0,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Locked',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Not registered for DIY @ Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Please ask center for registration',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget subjectContainerScanner(int index, String img) {
    enrolled_course_name =
        '${getEnrollmentModel?.getEnrollmenItems?.first?.courseName ?? ''}'
            .split(":")[0];
    double percentageBrightGiffy = double.parse(getEnrollmentModel
            ?.getEnrollmenItems?.first?.giffyPercentageCompleted ??
        '0.0');
    print("percentageBrightGiffy: $percentageBrightGiffy");
    double percentageBrightGiffy2 = percentageBrightGiffy * 100;
    int inPercentageBrightGiffy = percentageBrightGiffy2.round();
    print("BRIGHT GOFFY PERCENTAGE: $inPercentageBrightGiffy");
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
                    "$enrolled_course_name :  Scan, Solve & Learn\nAnytime, Anywhere Teacher",
                    textAlign: TextAlign.center,
                    style: MyTextStyle.mulishBlack().copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff314A72),
                        fontSize: Get.width * .04),
                  ),
                  SizedBox(height: Get.height * .04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [openApp("Scan Now", camScanIcon)],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: Get.height * .19,
          //   left: 0,
          //   right: 0,
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         shape: BoxShape.circle,
          //       ),
          //       child: CircularStepProgressIndicator(
          //         totalSteps: 100,
          //         currentStep:
          //             index == 0 ? inPercentageBrightGiffy : overAllAvg,
          //         stepSize: 10,
          //         gradientColor: LinearGradient(colors: [
          //           Color(0xffFDAF31),
          //           Color(0xffFDD060),
          //         ]),
          //         unselectedColor: Colors.white.withOpacity(.50),
          //         padding: 0,
          //         width: 80,
          //         height: 80,
          //         selectedStepSize: 17,
          //         child: Center(
          //           child: strokedText(
          //               color: lightBlue,
          //               fontSize: Get.width * .04,
          //               // text: "$intPercentage1%",
          //               text: "$inPercentageBrightGiffy%",
          //               // text: "100%",
          //               isProgressIndicator: true),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void appChecker() async {
    bool isInstalled = await DeviceApps.isAppInstalled('com.zappar.Zappar');
    if (isInstalled == true) {
      DeviceApps.openApp('com.zappar.Zappar');
    } else {
      LaunchReview.launch(androidAppId: "com.zappar.Zappar");
    }
  }

  Widget openApp(String text, image) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => screen);
        appChecker();
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

  @override
  void dispose() {
    super.dispose();
  }

  void showAlert(String title, String body) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(body),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool isOnline() {
    if (mOnline) return true;
    // showAlert("Not Online", "First login with a valid token");
    return false;
  }

  void _loginUser1(user, email) {
    if (mLoginDone) {
      // showAlert("Failed",
      //     "You have already initiated login. If the connection status is not 1, check the token and the package name/bundle ID");
      _mesibo.showMessages(remoteUser);
      return;
    }
    print("userDetails: ${user.token}");
    print('email_id: $email');
    mLoginDone = true;
    print("\n Inside Login User1 \n");
    print(user.token);
    print(
        "==========================================================================================");
    _mesibo.setup(user.token);
    print(
        '=========================Token=================== line 1642 $_token');
    _mesibo.setPushToken(_token, false);

    print("\n Below Setup");
    print(
        "==========================================================================================");
    remoteUser = email;

    //school admin email
  }

  void _showMessages() {
    print("remoteUser============" + remoteUser);
    if (!isOnline()) {
      getMesiboDetails();
    } else {
      _mesibo.showMessages(remoteUser);
    }
  }
}
