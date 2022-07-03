// To parse this JSON data, do
//
//     final userToken = userTokenFromJson(jsonString);

import 'dart:convert';

UserToken userTokenFromJson(String str) => UserToken.fromJson(json.decode(str));

String userTokenToJson(UserToken data) => json.encode(data.toJson());

class UserToken {
  UserToken({
    this.name,
    this.email,
    this.mesiboUserToken,
  });

  String name;
  String email;
  String mesiboUserToken;

  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
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
