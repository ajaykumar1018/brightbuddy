class LoginModel {
  int code;
  String message;
  LoginUser loginUser;
  LoginSchool loginSchool;

  LoginModel({this.code, this.message, this.loginUser, this.loginSchool});

  LoginModel.fromJson(dynamic json) {
    code = json["code"];
    message = json["message"];
    loginUser = json["user"] != null ? LoginUser.fromJson(json["user"]) : null;
    loginSchool = json["school"] != null ? LoginSchool.fromJson(json["school"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    map["message"] = message;
    if (loginUser != null) {
      map["user"] = loginUser.toJson();
    }
    return map;
  }
}

class LoginUser {
  String name;
  String email;
  String profilePic;
  String schoolCode;
  String level;
  String role;

  LoginUser({
    this.name,
    this.email,
    this.profilePic,
    this.schoolCode,
    this.level,
    this.role,
  });

  LoginUser.fromJson(dynamic json) {
    name = json["name"];
    email = json["email"];
    profilePic = json["profile_pic"];
    schoolCode = json["school_code"];
    level = json["level"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["profile_pic"] = profilePic;
    map["school_code"] = schoolCode;
    map["level"] = level;
    map["role"] = role;
    return map;
  }
}

class LoginSchool{
  String schoolCode;
  String schoolName;
  String schoolLogo;
  String city;
  String state;
  int pincode;

  LoginSchool({
    this.schoolCode,
    this.schoolName,
    this.schoolLogo,
    this.city,
    this.state,
    this.pincode
});

  LoginSchool.fromJson(dynamic json) {
    schoolCode = json["school_code"];
    schoolName = json["school_name"];
    schoolLogo = json["school_logo"];
    city = json["city"];
    state = json["state"];
    pincode = json["pincode"];
  }

  Map<String , dynamic> toJson() {
    var map = <String, dynamic>{};
        map["school_code"] = schoolCode;
        map["school_name"] = schoolName;
        map["school_logo"] = schoolLogo;
        map["city"] = city;
        map["state"] = state;
        map["pincode"] = pincode;
        return map;
   }
}
