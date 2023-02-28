class Apis {
  static String baseUrl = 'https://api.thinkific.com/api/public/v1/';
  // static String loginApiUrl = 'https://api-brightbeep.brightedumont.com/';
  static String loginApiUrl = 'http://192.168.1.7:8000/';
  static String login = loginApiUrl + 'auth/login';
  static String notices = loginApiUrl + 'notices/all';
  static String noticeAck = loginApiUrl + 'notices/ack';
  static String mountlib = loginApiUrl + 'montlib/find';
  static String userToken = loginApiUrl + 'users/mesibo_token';
  static String adminDetail = loginApiUrl + 'users/school/admin';
  static String setPassword = loginApiUrl + 'auth/password/set';
  static String changePassword = loginApiUrl + 'auth/password/change';
  static String enrollments = loginApiUrl + 'auth/enrollment';
  static String courses = baseUrl + 'courses';
  static String chapters = baseUrl + 'chapters';
  static String progressLesson = loginApiUrl + 'lesson/list';
  static String giffy = loginApiUrl + 'lesson/list/giffy';
  static String activitiesList = loginApiUrl + 'activities/list';
  static String craftActivitiesList = loginApiUrl + 'crafts_activities/list';
  static String updateActivity = loginApiUrl + 'activities/update_activity';
  static String updateActivity2 =
      loginApiUrl + 'crafts_activities/update_activity';
  static String weeklyTracking = loginApiUrl + 'progress/aggregate';
  static String weeklyTracking2 = loginApiUrl + 'progress/list';
  static String profilePicUpload = loginApiUrl + 'users/profile_pic/upload';
}
