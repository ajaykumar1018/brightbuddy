// To parse this JSON data, do
//
//     final adminDetail = adminDetailFromJson(jsonString);

import 'dart:convert';

List<AdminDetail> adminDetailFromJson(String str) => List<AdminDetail>.from(
    json.decode(str).map((x) => AdminDetail.fromJson(x)));

String adminDetailToJson(List<AdminDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminDetail {
  AdminDetail({
    this.name,
    this.email,
    this.mesiboUserToken,
  });

  String name;
  String email;
  String mesiboUserToken;

  factory AdminDetail.fromJson(Map<String, dynamic> json) => AdminDetail(
        name: json["name"],
        email: json["email"],
        mesiboUserToken: json["mesibo_user_token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mesibo_user_token": mesiboUserToken,
      };
}
