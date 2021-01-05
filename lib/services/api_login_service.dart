import 'dart:convert' as convert;
import 'package:alpaga/models/user.dart';
import 'package:alpaga/services/static_api_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiLoginServices {


  static  Future<User> signIn(String userName, String password, String email) async {

    print("********* sign in ***********");
    var url = ApiData.baseURL + 'users/register';
    final params = jsonEncode({
      "email": email,
      "username": userName,
      "password": password

    });
    var response = await http.post(url, body: params, headers: ApiData.apiHeaders());
    print(response.body);
    if (response.statusCode == 200) {
        var user = await logIn(userName, password, email);
        return user;
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
      return null;
    }
  }

  static  Future<User> logIn(String userName, String password, String email) async {

    print("********* Authenticate ***********");
    var url = ApiData.baseURL + 'users/authenticate';
    final params = jsonEncode({
      "email": email,
      "username": userName,
      "password": password

    });
    var response = await http.post(url, body: params, headers: ApiData.apiHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      String token = jsonResponse["token"];
      ApiData.apiToken = token;
      if(token != null) {
        var user = await getUser();
        user.email = email;
        user.password = password;
        return user;
      } else {
        return null;
      }
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
      return null;
    }
  }

  static  Future<User> twitchLogin(String twitchCode) async {

    print("********* twitch Login ***********");
    var url = ApiData.baseURL + 'users/login/twitch';
    final params = jsonEncode({"code": twitchCode});
    var response = await http.post(url, body: params, headers: ApiData.apiHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      String token = jsonResponse["token"];
      ApiData.apiToken = token;
      if(token != null) {
        var user = await getUser();
        return user;
      } else {
        return null;
      }
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
      return null;
    }
  }

  static Future<User> getUser() async {

    print("********* get User w token : ${ApiData.apiToken} ***********");
    var url = ApiData.baseURL + 'users/current';
    var response = await http.get(url, headers: ApiData.apiHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var currentUser = User.fromJson(jsonResponse);
      return currentUser;
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
      return null;
    }
  }

}
