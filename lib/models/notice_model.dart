// To parse this JSON data, do
//
//     final notice = noticeFromJson(jsonString);

import 'dart:convert';

List<Notice> noticeFromJson(String str) =>
    List<Notice>.from(json.decode(str).map((x) => Notice.fromJson(x)));

String noticeToJson(List<Notice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notice {
  Notice({
    this.id,
    this.title,
    this.body,
    this.level,
    this.attachment,
    this.createdAt,
    this.acknowledgment,
  });

  int id;
  String title;
  String body;
  String level;
  String attachment;
  DateTime createdAt;
  bool acknowledgment;

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        id: json["_id"],
        title: json["title"],
        body: json["body"],
        level: json["level"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        acknowledgment: json["acknowledgment"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "body": body,
        "level": level,
        "attachment": attachment,
        "created_at": createdAt.toIso8601String(),
        "acknowledgment": acknowledgment,
      };
}
