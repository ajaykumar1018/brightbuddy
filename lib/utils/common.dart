import 'package:bright_kid/helpers/services/api_request.dart';
import 'package:bright_kid/models/chapters_lesson_model.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/models/get_chapters_model.dart';
import 'package:bright_kid/models/get_courses_model.dart';
import 'package:bright_kid/models/get_enrollment_model.dart';
import 'package:bright_kid/models/login_model.dart';
import 'package:bright_kid/models/weekly_calendar_model.dart';

class HeaderParameter {
  static Map<String, String> headers() {
    return {
      "X-Auth-API-Key": "d6b5f7a2908e2edd052478bfe0dd2dc3",
      "X-Auth-Subdomain": "brightcourse",
    };
  }
}

ApiRequest apiRequest = ApiRequest();

//for getting enrollment
GetEnrollmentModel getEnrollmentModel = GetEnrollmentModel();

//for getting courses
GetCoursesModel getCoursesModel = GetCoursesModel();

//for getting chapters
GetChaptersModel getChaptersModel = GetChaptersModel();

LoginModel loginData = LoginModel();

//for getting activities overview list

List<GetActivitiesOverviewModel> getActivitiesOverviewList  =[];

//for getting calendar weekly
List<WeeklyCalendarModel> weeklyCalendarList = [];

// for home screen container one see progress chapter lesson

List<ChaptersLessonModel> chapterLessonList = [];
