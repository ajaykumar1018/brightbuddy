import 'dart:convert';
import 'dart:io';

import 'package:bright_kid/helpers/services/api_url.dart';
import 'package:bright_kid/helpers/services/show_messages.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/global_function.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
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
      String url = Apis.enrollments + "?query[email]=$email";
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
      };
      print('url  : $url');
      print('body ---- : $body');
      var response = await http.post(Uri.parse(url), body: body);
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

  //
  //
  //

  //for profile picture uplaod
  Future profilePictureUploadFunc({
    String email,
    File profilePic,
  }) async {
    try {
      String url = Apis.profilePicUpload+"?email=$email";
      print('url : $url');

      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );

      request.files.add(
          await http.MultipartFile.fromPath("file", profilePic.path));
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
