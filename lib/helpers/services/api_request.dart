import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bright_kid/helpers/services/api_url.dart';
import 'package:bright_kid/helpers/services/show_messages.dart';
import 'package:bright_kid/models/admin_detail.dart';
import 'package:bright_kid/models/mont_lib_model.dart';
import 'package:bright_kid/models/notice_model.dart';
import 'package:bright_kid/models/user_token_for_mesibo.dart';
// import 'package:bright_kid/models/post_model.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/global_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiRequest {
  Future getNotices(
      String schoolCode, String email, String role, String level) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      var client = http.Client();
      String uri = Apis.notices;
      var url = Uri.parse(uri +
          '?school_code=$schoolCode&email=$email&role=$role&level=$level');
      var response = await client.get(url);

      if (response.statusCode == 200) {
        print(response);
        var json = response.body;
        return noticeFromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (err) {
      print(err);
    }
  }

  Future getUserToken(String email) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      var client = http.Client();
      String uri = Apis.userToken;
      var url = Uri.parse(uri + '/$email');
      print('tokenUrl: $url');
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var json = response.body;
        return userTokenFromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (err) {
      print(err);
    }
  }

  Future getAdminDetail(String schoolCode) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      var client = http.Client();
      String uri = Apis.adminDetail;
      var url = Uri.parse(uri + '?school_code=$schoolCode');
      var response = await client.get(url);

      if (response.statusCode == 200) {
        print(response);
        var json = response.body;
        return adminDetailFromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (err) {
      print(err);
    }
  }

  Future getMontLib(String email, String level, String schoolCode) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      var client = http.Client();
      String uri = Apis.mountlib;
      var url = Uri.parse(uri + '/$email/$level/$schoolCode');
      print(url);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        print(response);
        var json = response.body;
        return montLibFromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (err) {
      print(err);
    }
  }

  Future acknowledgeNotice(String schoolCode, String email, int id) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String uri = Apis.noticeAck;
      var url = Uri.parse(uri + '/$schoolCode/$email/$id');
      var response = await http.put(url);
      var jsonResponse = json.decode(response.body);
      print(url);
      if (response.statusCode == 200) {
        if (jsonResponse['code'] == 200) {
          return jsonResponse;
        } else if (jsonResponse['code'] == 201) {
          return jsonResponse;
        } else if (jsonResponse['code'] == 204) {
          ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        } else if (jsonResponse['code'] == 401) {
          ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        }
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future loginApi(String email, String password) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.login;
      var body = {
        'email': email,
        'password': password,
      };

      var response = await http.post(Uri.parse(url), body: body);
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        if (jsonResponse['code'] == 200) {
          return jsonResponse;
        } else if (jsonResponse['code'] == 201) {
          return jsonResponse;
        } else if (jsonResponse['code'] == 204) {
          ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        } else if (jsonResponse['code'] == 401) {
          ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        }
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //
  //
  //

  Future setPassword(String email, String password, String rePassword) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.setPassword;
      var body = {
        'email': email,
        'password': password,
        're_password': rePassword,
      };

      var response = await http.post(Uri.parse(url), body: body);
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        if (jsonResponse['code'] == 207) {
          return jsonResponse;
        }
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //
  //
  //

  Future changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.changePassword;
      var body = {
        'email': email,
        'old_password': oldPassword,
        'new_password': newPassword,
      };

      var response = await http.post(Uri.parse(url), body: body);
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        if (jsonResponse['code'] == 206) {
          return jsonResponse;
        } else if (jsonResponse['code'] == 204) {
          ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        } else if (jsonResponse['code'] == 402) {
          ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        }
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //
  //
  //

  Future getEnrollment(String email) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.enrollments + "?email=$email";
      var response = await http.get(
        Uri.parse(url),
        headers: HeaderParameter.headers(),
      );
      var jsonResponse = json.decode(response.body);
      print('This is body of getEnrollment in api_request : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //
  //
  //
  Future getCourses(int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.courses + "/$courseId/chapters";
      var response = await http.get(
        Uri.parse(url),
        headers: HeaderParameter.headers(),
      );
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body of getcourses : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //
  //
  //
  Future getActivitiesOverViewList(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.activitiesList + "?email=$email&course_id=$courseId";
      print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body of get activies overview list : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future getGiffyData(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.giffy + "?email=$email&course_id=$courseId";
      print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body of getgiffydata : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future getCraftActivities(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url =
          Apis.craftActivitiesList + "?email=$email&course_id=$courseId";
      // print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      // print('response Craft :\n');
      // print('this is body Craft : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //
  //
  //
  Future submitActivity(
    String email,
    int courseId,
    String categoryId,
    String activityCode,
    int time,
    String activityName,
  ) async {
    // TODO: Geting present date
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.updateActivity;
      Map<dynamic, dynamic> body = {
        "email": "$email",
        "course_id": "$courseId",
        "category_id": "$categoryId",
        "activity_code": "$activityCode",
        "timespent": "$time",
        "activity_name": "$activityName",
        "date": "$formattedDate"
      };
      print('url  : $url');
      print('body ---- : $body');
      var response = await http.post(Uri.parse(url), body: body);
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body of submitactiviy : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  //SUBMIT ACTIVITY 2 for craft activity
  Future submitActivity2(
    String email,
    int courseId,
    String categoryId,
    String activityCode,
    var file,
    String activityName,
  ) async {
    try {
      String url = Apis.updateActivity2;
      print('url : $url');

      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );

      request.fields.addAll({
        'email': email,
        'course_id': "$courseId",
        'category_id': categoryId,
        'activity_code': activityCode,
        'activity_name': activityName
      });

      request.files.add(await http.MultipartFile.fromPath(
        "file",
        file.path,
      ));
      bool isConnected = await checkInternet();
      if (isConnected) {
        http.StreamedResponse response =
            await request.send().timeout(Duration(seconds: 60), onTimeout: () {
          ShowMessageForApi.snackBar("Loading ", "Request Time Out ", true);
          return null;
        });

        print('server status code : ${response.statusCode}');
        final responseBody = await response.stream.bytesToString();
        Map jsonResponse = jsonDecode(responseBody);
        print('jsonResponse : $jsonResponse');
        if (response.statusCode == 200) {
          return jsonResponse;
        } else {
          ShowMessageForApi.ofJsonInDialog(jsonResponse["message"], true);
          return false;
        }
      } else {
        ShowMessageForApi.inDialog('No Internet Connection', true);
      }
    } on SocketException {
      ShowMessageForApi.inDialog('No Internet Connection', true);

      print('No Internet connection');
      return false;
    } on HttpException catch (error) {
      print(error);
      ShowMessageForApi.inDialog('Couldn\'t find the results', true);
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      ShowMessageForApi.inDialog('Bad response format from server', true);
      print("Bad response format");
      return false;
    } catch (value) {
      print(value);
    }
    return false;
  }

  //
  //
  //

  //for profile picture uplaod
  Future profilePictureUploadFunc({
    String email,
    File profilePic,
  }) async {
    try {
      String url = Apis.profilePicUpload + "?email=$email";
      print('url : $url');

      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );

      request.files.add(await http.MultipartFile.fromPath(
        "file",
        profilePic.path,
      ));
      bool isConnected = await checkInternet();
      if (isConnected) {
        http.StreamedResponse response =
            await request.send().timeout(Duration(seconds: 60), onTimeout: () {
          ShowMessageForApi.snackBar("Loading ", "Request Time Out ", true);
          return null;
        });

        print('server status code : ${response.statusCode}');
        final responseBody = await response.stream.bytesToString();
        Map jsonResponse = jsonDecode(responseBody);
        print('jsonResponse : $jsonResponse');
        if (response.statusCode == 200) {
          return jsonResponse;
        } else {
          ShowMessageForApi.ofJsonInDialog(jsonResponse["message"], true);
          return false;
        }
      } else {
        ShowMessageForApi.inDialog('No Internet Connection', true);
      }
    } on SocketException {
      ShowMessageForApi.inDialog('No Internet Connection', true);

      print('No Internet connection');
      return false;
    } on HttpException catch (error) {
      print(error);
      ShowMessageForApi.inDialog('Couldn\'t find the results', true);
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      ShowMessageForApi.inDialog('Bad response format from server', true);
      print("Bad response format");
      return false;
    } catch (value) {
      print(value);
    }
    return false;
  }

  //
  //
  //
  Future weeklyTrackingFunc(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.weeklyTracking + "?email=$email&course_id=$courseId";
      print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future weeklyTrackingFunc2(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.weeklyTracking2 + "?email=$email&course_id=$courseId";
      print('url  : $url');
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future getChapters(int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.chapters + "/$courseId/contents";
      var response = await http.get(
        Uri.parse(url),
        headers: HeaderParameter.headers(),
      );
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }

  Future getChaptersLessonFun(String email, int courseId) async {
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        ShowMessageForApi.inDialog("No internet Connection", true);
        return false;
      }
      String url = Apis.progressLesson + "?email=$email&course_id=$courseId";
      var response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(response.body);
      print('response:\n');
      print('this is body : ${response.body}');
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        ShowMessageForApi.ofJsonInDialog(jsonResponse, true);
        return false;
      } else {
        ShowMessageForApi.ofJsonInDialog(
            "status code: ${response.statusCode}", true);
        return false;
      }
    } on HttpException catch (error) {
      print(error);
      toast(Get.context, 'Couldn\'t find the results');
      print("Couldn't find the post");
      return false;
    } on FormatException catch (error) {
      print(error);
      toast(Get.context, 'Bad response format from server');
      print("Bad response format");
      return false;
    } catch (value) {
      print('value: $value');
    }
    return false;
  }
}

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
  return false;
}
