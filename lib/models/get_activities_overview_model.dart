class GetActivitiesOverviewModel {
  List<GetActivitiesOverviewActivities> activities;
  String categoryId;
  String categoryName;
  List<GetActivitiesOverviewImages> images;

  GetActivitiesOverviewModel({
    this.activities,
    this.categoryId,
    this.categoryName});

  GetActivitiesOverviewModel.fromJson(dynamic json) {
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities.add(GetActivitiesOverviewActivities.fromJson(v));
      });
    }
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (activities != null) {
      map['activities'] = activities.map((v) => v.toJson()).toList();
    }
    map['category_id'] = categoryId;
    map['category_name'] = categoryName;
    return map;
  }

}

class GetActivitiesOverviewActivities {
  String activityCode;
  String activityName;
  int activityTime;
  dynamic completed;
  int timespent;
  String imageUrl;

  GetActivitiesOverviewActivities({
    this.activityCode,
    this.activityName,
    this.activityTime,
    this.completed,
    this.timespent,
    this.imageUrl});

  GetActivitiesOverviewActivities.fromJson(dynamic json) {
    activityCode = json['activity_code'];
    activityName = json['activity_name'];
    activityTime = json['activity_time'];
    completed = json['completed'];
    timespent = json['timespent'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['activity_code'] = activityCode;
    map['activity_name'] = activityName;
    map['activity_time'] = activityTime;
    map['completed'] = completed;
    map['timespent'] = timespent;
    map['image_url'] = imageUrl;
    return map;
  }

}


class GetActivitiesOverviewImages {
  String image;
  GetActivitiesOverviewImages({this.image});
}