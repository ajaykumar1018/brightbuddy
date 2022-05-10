import 'dart:io';

import 'package:bright_kid/helpers/widgets/congratulation_bottomsheet.dart';
import 'package:bright_kid/models/chapters_lesson_model.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/models/get_activities_overview_model2.dart';
import 'package:bright_kid/models/get_chapters_model.dart';
import 'package:bright_kid/models/get_courses_model.dart';
import 'package:bright_kid/models/get_enrollment_model.dart';
import 'package:bright_kid/models/weekly_calendar_model.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider() {
    notifyListeners();
  }

  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool confirmPasswordVisible = true;

  secureOldPassword() {
    oldPasswordVisible = !oldPasswordVisible;
    notifyListeners();
  }

  secureNewPassword() {
    newPasswordVisible = !newPasswordVisible;
    notifyListeners();
  }

  secureConfirmPassword() {
    confirmPasswordVisible = !confirmPasswordVisible;
    notifyListeners();
  }

  //////////Bottom Navigation//////////
  List<String> bottomNavigationActiveIconsList = [
    home,
    attendance,
    profile,
    settings
  ];

  List<String> bottomNavigationInactiveIconsList = [
    homeActive,
    attendanceActive,
    profileActive,
    settingsActive
  ];

  List<String> bottomNavigationNamesList = [
    "Home",
    "Attendance",
    "Profile",
    "Settings"
  ];

  bool isLoading = false;

  Future getEnrollmentFunc() async {
    isLoading = true;
    await apiRequest
        .getEnrollment(loginData?.loginUser?.email ?? '')
        .then((response) async {
      if (response != false) {
        getEnrollmentModel = GetEnrollmentModel.fromJson(response);
        await getActivitiesOverView(
          '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
          getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
        );
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getEnrollmentFunc2() async {
    isLoading = true;
    await apiRequest
        .getEnrollment(loginData?.loginUser?.email ?? '')
        .then((response) async {
      if (response != false) {
        getEnrollmentModel = GetEnrollmentModel.fromJson(response);
        await getCraftActivities(
          '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
          getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
        );
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getCoursesFunc(int courseId) async {
    isLoading = true;
    print('loading start');
    await apiRequest.getCourses(courseId).then((response) {
      isLoading = false;
      notifyListeners();
      print('loading stop');
      if (response != false) {
        getCoursesModel = GetCoursesModel.fromJson(response);
        print('opopopopopop');
      }
    });
  }

  Future getChaptersFunc(int courseId) async {
    isLoading = true;
    print('ooo');
    await apiRequest.getChapters(courseId).then((response) => {
          isLoading = false,
          notifyListeners(),
          if (response != false)
            {
              getChaptersModel = GetChaptersModel.fromJson(response),
            }
        });
  }

  Future getChaptersLessonFunc(String email, int courseId) async {
    isLoading = true;
    print('ooo');
    await apiRequest.getChaptersLessonFun(email, courseId).then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        chapterLessonList.clear();
        response.forEach((res) {
          chapterLessonList.add(ChaptersLessonModel.fromJson(res));
        });
        print('chapter lesson length : ${chapterLessonList?.length ?? 0}');
      }
    });
  }

  Future getActivitiesOverView(String email, int courseId) async {
    isLoading = true;
    print('isloading =  true');
    await apiRequest
        .getActivitiesOverViewList(email, courseId)
        .then((response) {
      isLoading = false;
      print('isloading =  false');
      notifyListeners();
      if (response != false) {
        getActivitiesOverviewList.clear();
        response.forEach((res) {
          getActivitiesOverviewList
              .add(GetActivitiesOverviewModel.fromJson(res));
        });
        print(getActivitiesOverviewList.length);
      }
    });
  }

  Future getGiffyData(String email, int courseId) async {
    isLoading = true;
    print('isloading =  true');
    await apiRequest.getGiffyData(email, courseId).then((response) {
      isLoading = false;
      print('isloading =  false');
      notifyListeners();
      if (response != false) {
        getActivitiesOverviewList.clear();
        response.forEach((res) {
          getActivitiesOverviewList
              .add(GetActivitiesOverviewModel.fromJson(res));
        });
        print(getActivitiesOverviewList.length);
      }
    });
  }

  Future getCraftActivities(String email, int courseId) async {
    isLoading = true;

    print('isloading =  true');
    await apiRequest.getCraftActivities(email, courseId).then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        getActivitiesOverviewList2.clear();
        response.forEach((res) {
          getActivitiesOverviewList2
              .add(GetActivitiesOverviewModel2.fromJson(res));
        });
        print("FIRST INDEX ONLY for CRAFT ACTIVITIES");
        print(getActivitiesOverviewList2[0].categoryId);
        print(getActivitiesOverviewList2[1].categoryId);

        // return getActivitiesOverviewList2;
      }
      // return [];
    });
  }

  Future submitActivity(
    String email,
    int courseId,
    String categoryId,
    String activityCode,
    int time,
    String activityName,
  ) async {
    isLoading = true;
    await apiRequest
        .submitActivity(
      email,
      courseId,
      categoryId,
      activityCode,
      time,
      activityName,
    )
        .then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        Get.back();
        Get.bottomSheet(
            CongratulationsBottom(
              title: "Your activity time has been submit \nsuccessfully.",
              status: 1,
            ),
            enableDrag: false,
            isDismissible: false);
      }
    });
  }

  Future submitActivity2(
      String email,
      int courseId,
      String categoryId,
      String activityCode,
      var file,
      String activityName,
      ) async {
    isLoading = true;
    await apiRequest
        .submitActivity2(
      email,
      courseId,
      categoryId,
      activityCode,
      file,
      activityName,
    )
        .then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        Get.back();
        Get.bottomSheet(
            CongratulationsBottom(
              title: "Your activity time has been submit \nsuccessfully.",
              status: 1,
            ),
            enableDrag: false,
            isDismissible: false);
      }
    });
  }

  Future onchangePasswordButtonTapped(
      String email, String oldPassword, String newPassword) async {
    isLoading = true;
    notifyListeners();
    apiRequest
        .changePassword(email, oldPassword, newPassword)
        .then((response) async {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('isLoggedIn', true);
        preferences.setString('email', email);
        preferences.setString('password', newPassword);
        Get.back();
        Get.bottomSheet(
            CongratulationsBottom(
              title: "Your password has been\n successfully updated",
              status: 1,
            ),
            enableDrag: false,
            isDismissible: false);
      }
    });
  }

  Future weeklyCalendarFunc(String email, int courseId) async {
    isLoading = true;
    await apiRequest.weeklyTrackingFunc(email, courseId).then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        weeklyCalendarList.clear();
        response.forEach((res) {
          weeklyCalendarList.add(WeeklyCalendarModel.fromJson(res));
        });
        print(weeklyCalendarList.length);
      }
    });
  }

  Future weeklyCalendarFunc2(String email, int courseId) async {
    isLoading = true;
    await apiRequest.weeklyTrackingFunc2(email, courseId).then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        weeklyCalendarList2.clear();
        response.forEach((res) {
          weeklyCalendarList2.add(WeeklyCalendarModel.fromJson(res));
        });
        print(weeklyCalendarList.length);
      }
    });
  }

  Future getProfileImageGallery(File _image) async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      _image = File(value.path);
      if (_image == null) {
        print('image is null');
      } else {
        profilePictureUploadApiCall(loginData?.loginUser?.email ?? '', _image);
      }
    });
  }

  Future profilePictureUploadApiCall(String email, File profilePic) async {
    isLoading = true;
    notifyListeners();
    await apiRequest
        .profilePictureUploadFunc(email: email, profilePic: profilePic)
        .then((response) {
      isLoading = false;
      notifyListeners();
      if (response != false) {
        print('before profile pic url : ${loginData.loginUser.profilePic}');
        loginData.loginUser.profilePic = response['fileURL'];
        notifyListeners();
        print('after profile pic url : ${loginData.loginUser.profilePic}');
      }
    });
  }
}
