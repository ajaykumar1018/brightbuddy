class Apis {
  static String baseUrl = 'https://api.thinkific.com/api/public/v1/';
  static String loginApiUrl =
      'http://3.7.252.152:8000/';
  static String login = loginApiUrl + 'auth/login';
  static String setPassword = loginApiUrl + 'auth/password/set';
  static String changePassword = loginApiUrl + 'auth/password/change';
  static String enrollments = baseUrl + 'enrollments';
  static String courses = baseUrl + 'courses';
  static String chapters = baseUrl + 'chapters';
  static String progressLesson = loginApiUrl + 'lesson/list';
  static String activitiesList = loginApiUrl + 'activities/list';
  static String updateActivity = loginApiUrl + 'activities/update_activity';
  static String weeklyTracking = loginApiUrl + 'progress/aggregate';
  static String profilePicUpload = loginApiUrl + 'users/profile_pic/upload';
}
