class GetChaptersModel {
  List<GetChaptersItems> getChaptersItems;
  Meta meta;

  GetChaptersModel({this.getChaptersItems, this.meta});

  GetChaptersModel.fromJson(dynamic json) {
    if (json["items"] != null) {
      getChaptersItems = [];
      json["items"].forEach((v) {
        getChaptersItems.add(GetChaptersItems.fromJson(v));
      });
    }
    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (getChaptersItems != null) {
      map["items"] = getChaptersItems.map((v) => v.toJson()).toList();
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
  int nextPage;
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

class GetChaptersItems {
  int id;
  String name;
  String contentableType;
  int position;
  bool free;
  int chapterId;
  String takeUrl;

  GetChaptersItems(
      {this.id,
      this.name,
      this.contentableType,
      this.position,
      this.free,
      this.chapterId,
      this.takeUrl});

  GetChaptersItems.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    contentableType = json["contentable_type"];
    position = json["position"];
    free = json["free"];
    chapterId = json["chapter_id"];
    takeUrl = json["take_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["contentable_type"] = contentableType;
    map["position"] = position;
    map["free"] = free;
    map["chapter_id"] = chapterId;
    map["take_url"] = takeUrl;
    return map;
  }
}
