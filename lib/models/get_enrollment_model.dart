class GetEnrollmentModel {
  List<GetEnrollmenItems> getEnrollmenItems;
  Meta meta;

  GetEnrollmentModel({this.getEnrollmenItems, this.meta});

  GetEnrollmentModel.fromJson(dynamic json) {
    if (json["items"] != null) {
      // print("JSON : " + json);
      getEnrollmenItems = [];
      print("YASH");
      json["items"].forEach((v) {
        print(v);
        getEnrollmenItems.add(GetEnrollmenItems.fromJson(v));
      });
    }
    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (getEnrollmenItems != null) {
      map["items"] = getEnrollmenItems.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map["meta"] = meta.toJson();
    }
    return map;
  }
}

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(dynamic json) {
    pagination = json["pagination"] != null
        ? Pagination.fromJson(json["pagination"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (pagination != null) {
      map["pagination"] = pagination.toJson();
    }
    return map;
  }
}

class Pagination {
  int currentPage;
  dynamic nextPage;
  dynamic prevPage;
  int totalPages;
  int totalItems;
  String entriesInfo;

  Pagination(
      {this.currentPage,
      this.nextPage,
      this.prevPage,
      this.totalPages,
      this.totalItems,
      this.entriesInfo});

  Pagination.fromJson(dynamic json) {
    currentPage = json["current_page"];
    nextPage = json["next_page"];
    prevPage = json["prev_page"];
    totalPages = json["total_pages"];
    totalItems = json["total_items"];
    entriesInfo = json["entries_info"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    map["next_page"] = nextPage;
    map["prev_page"] = prevPage;
    map["total_pages"] = totalPages;
    map["total_items"] = totalItems;
    map["entries_info"] = entriesInfo;
    return map;
  }
}

class GetEnrollmenItems {
  int id;
  String createdAt;
  String userEmail;
  String userName;
  String expiryDate;
  int userId;
  String courseName;
  int courseId;
  String percentageCompleted;
  dynamic completedAt;
  bool expired;
  bool isFreeTrial;
  bool completed;
  String startedAt;
  String activatedAt;
  String updatedAt;
  String giffyPercentageCompleted;

  GetEnrollmenItems(
      {this.id,
      this.createdAt,
      this.userEmail,
      this.userName,
      this.expiryDate,
      this.userId,
      this.courseName,
      this.courseId,
      this.percentageCompleted,
      this.completedAt,
      this.expired,
      this.isFreeTrial,
      this.completed,
      this.startedAt,
      this.activatedAt,
      this.updatedAt,
      this.giffyPercentageCompleted});

  GetEnrollmenItems.fromJson(dynamic json) {
    id = json["id"];
    createdAt = json["created_at"];
    userEmail = json["user_email"];
    userName = json["user_name"];
    expiryDate = json["expiry_date"];
    userId = json["user_id"];
    courseName = json["course_name"];
    courseId = json["course_id"];
    percentageCompleted = json["percentage_completed"];
    completedAt = json["completed_at"];
    expired = json["expired"];
    isFreeTrial = json["is_free_trial"];
    completed = json["completed"];
    startedAt = json["started_at"];
    activatedAt = json["activated_at"];
    updatedAt = json["updated_at"];
    giffyPercentageCompleted = json["giffy_percentage_completed"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["created_at"] = createdAt;
    map["user_email"] = userEmail;
    map["user_name"] = userName;
    map["expiry_date"] = expiryDate;
    map["user_id"] = userId;
    map["course_name"] = courseName;
    map["course_id"] = courseId;
    map["percentage_completed"] = percentageCompleted;
    map["completed_at"] = completedAt;
    map["expired"] = expired;
    map["is_free_trial"] = isFreeTrial;
    map["completed"] = completed;
    map["started_at"] = startedAt;
    map["activated_at"] = activatedAt;
    map["updated_at"] = updatedAt;
    map["giffy_percentage_completed"] = giffyPercentageCompleted;
    return map;
  }
}
