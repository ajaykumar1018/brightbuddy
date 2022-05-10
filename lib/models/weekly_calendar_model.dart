class WeeklyCalendarModel {
  int week;
  String dateRange;
  double activityProgress;
  int activitiesCompleted;
  double lessonProgress;
  int lessonsCompleted;
  var weekData;

  WeeklyCalendarModel({
      this.week, 
      this.dateRange, 
      this.activityProgress, 
      this.activitiesCompleted, 
      this.lessonProgress, 
      this.lessonsCompleted, this.weekData});

  WeeklyCalendarModel.fromJson(dynamic json) {
    week = json['week'];
    dateRange = json['date_range'];
    activityProgress = json['activity_progress'];
    activitiesCompleted = json['activities_completed'];
    lessonProgress = json['lesson_progress'];
    lessonsCompleted = json['lessons_completed'];
    weekData = json;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['week'] = week;
    map['date_range'] = dateRange;
    map['activity_progress'] = activityProgress;
    map['activities_completed'] = activitiesCompleted;
    map['lesson_progress'] = lessonProgress;
    map['lessons_completed'] = lessonsCompleted;
    return map;
  }

}