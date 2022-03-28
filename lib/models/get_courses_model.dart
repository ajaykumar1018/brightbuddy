class GetCoursesModel {
  List<GetCoursesItems> getCoursesItems;
  Meta meta;

  GetCoursesModel({this.getCoursesItems, this.meta});

  GetCoursesModel.fromJson(dynamic json) {
    if (json["items"] != null) {
      getCoursesItems = [];
      json["items"].forEach((v) {
        getCoursesItems.add(GetCoursesItems.fromJson(v));
      });
    }
    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (getCoursesItems != null) {
      map["items"] = getCoursesItems.map((v) => v.toJson()).toList();
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

class GetCoursesItems {
  int id;
  String name;
  int position;
  List<int> contentIds;
  List<OurImage> images;
  dynamic description;
  int durationInSeconds;

  GetCoursesItems(
      {this.id,
      this.name,
      this.position,
      this.contentIds,
      this.images,
      this.description,
      this.durationInSeconds});

  GetCoursesItems.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    position = json["position"];
    contentIds =
        json["content_ids"] != null ? json["content_ids"].cast<int>() : [];
    description = json["description"];
    durationInSeconds = json["duration_in_seconds"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["position"] = position;
    map["content_ids"] = contentIds;
    map["description"] = description;
    map["duration_in_seconds"] = durationInSeconds;
    return map;
  }
}

class OurImage {
  String image;
  OurImage({this.image});
}
