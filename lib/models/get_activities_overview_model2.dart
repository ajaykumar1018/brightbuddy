class GetActivitiesOverviewModel2 {
  List<GetActivitiesOverviewActivities2> activities;
  String categoryId;
  String categoryName;
  List<GetActivitiesOverviewImages> images;

  GetActivitiesOverviewModel2(
      {this.activities, this.categoryId, this.categoryName});

  GetActivitiesOverviewModel2.fromJson(dynamic json) {
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities.add(GetActivitiesOverviewActivities2.fromJson(v));
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

class GetActivitiesOverviewActivities2 {
  String activityCode;
  String activityName;
  int activityTime;
  dynamic completed;
  String parent_category_id;
  int timespent;
  String imageUrl;

  GetActivitiesOverviewActivities2(
      {this.activityCode,
      this.activityName,
      this.activityTime,
        this.parent_category_id,
      this.completed,
      this.timespent,
      this.imageUrl});

  GetActivitiesOverviewActivities2.fromJson(dynamic json) {
    activityCode = json['activity_code'];
    activityName = json['activity_name'];
    completed = json['completed'];
    timespent = json['timespent'];
    imageUrl = json['image_url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['activity_code'] = activityCode;
    parent_category_id = "";
    map['activity_name'] = activityName;
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
