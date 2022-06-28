// To parse this JSON data, do
//
//     final montLib = montLibFromJson(jsonString);

import 'dart:convert';

List<MontLib> montLibFromJson(String str) =>
    List<MontLib>.from(json.decode(str).map((x) => MontLib.fromJson(x)));

String montLibToJson(List<MontLib> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MontLib {
  MontLib({
    this.kitName,
    this.issueDate,
    this.dueDate,
    this.returnDate,
  });

  String kitName;
  DateTime issueDate;
  DateTime dueDate;
  DateTime returnDate;

  factory MontLib.fromJson(Map<String, dynamic> json) => MontLib(
        kitName: json["kit_name"],
        issueDate: DateTime.parse(json["issue_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        returnDate: json["return_date"] == null
            ? null
            : DateTime.parse(json["return_date"]),
      );

  Map<String, dynamic> toJson() => {
        "kit_name": kitName,
        "issue_date": issueDate.toIso8601String(),
        "due_date": dueDate.toIso8601String(),
        "return_date": returnDate == null ? null : returnDate.toIso8601String(),
      };
}
