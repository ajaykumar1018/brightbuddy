class ChaptersLessonModel {
  int chapterId;
  String chapterName;
  List<ChaptersLessonOurImage> images;
  List<ChaptersLessonContents> contents;

  ChaptersLessonModel({
      this.chapterId, 
      this.chapterName, 
      this.contents});

  ChaptersLessonModel.fromJson(dynamic json) {
    chapterId = json['chapter_id'];
    chapterName = json['chapter_name'];
    if (json['contents'] != null) {
      contents = [];
      json['contents'].forEach((v) {
        contents.add(ChaptersLessonContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['chapter_id'] = chapterId;
    map['chapter_name'] = chapterName;
    if (contents != null) {
      map['contents'] = contents.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ChaptersLessonContents {
  String contentableType;
  String takeUrl;
  int contentId;
  String contentName;
  bool completed;

  ChaptersLessonContents({
      this.contentableType, 
      this.takeUrl, 
      this.contentId, 
      this.contentName, 
      this.completed});

  ChaptersLessonContents.fromJson(dynamic json) {
    contentableType = json['contentable_type'];
    takeUrl = json['take_url'];
    contentId = json['content_id'];
    contentName = json['content_name'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['contentable_type'] = contentableType;
    map['take_url'] = takeUrl;
    map['content_id'] = contentId;
    map['content_name'] = contentName;
    map['completed'] = completed;
    return map;
  }

}

class ChaptersLessonOurImage {
  String image;
  ChaptersLessonOurImage({this.image});
}