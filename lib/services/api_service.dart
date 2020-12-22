import 'dart:convert' as convert;
import 'package:alpaga/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:alpaga/models/github_model.dart';
import 'dart:convert';

class ApiData {

  static String baseURL = "https://alpa-user.herokuapp.com/";

  // static List<GithubTrendingModel> githubTrendingModel;
  // static Future<dynamic> getData() async {
  //   githubTrendingModel = [];
  //   var url =
  //       "https://github-trending-api.now.sh/repositories?language=&since=daily";
  //
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     print(jsonResponse);
  //     jsonResponse.forEach((data) {
  //       ApiData.githubTrendingModel.add(GithubTrendingModel.fromJson(data));
  //     });
  //     print(ApiData.githubTrendingModel);
  //   } else {
  //     print("Request failed with status: ${response.statusCode}.");
  //   }
  // }

  static  Future<User> signIn(String userName, String password, String email) async {

    print("********* sign in ***********");
    var url = baseURL + 'users/register';
    final params = jsonEncode({
      "email": email,
      "username": userName,
      "password": password

    });
    var response = await http.post(url, body: params, headers: {'Content-Type': 'application/json'});
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
    var url = baseURL + 'users/authenticate';
    final params = jsonEncode({
      "email": email,
      "username": userName,
      "password": password

    });
    var response = await http.post(url, body: params, headers: {'Content-Type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      String token = jsonResponse["token"];
      if(token != null) {
        var user = await getUser(token);
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
    var url = baseURL + 'users/login/twitch';
    final params = jsonEncode({"code": twitchCode});
    var response = await http.post(url, body: params, headers: {'Content-Type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      String token = jsonResponse["token"];
      if(token != null) {
        var user = await getUser(token);
        return user;
      } else {
        return null;
      }
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
      return null;
    }
  }

  static Future<User> getUser(String alpaToken) async {

    print("********* get User w token : $alpaToken ***********");
    var url = baseURL + 'users/current';
    var response = await http.get(url, headers: {'Content-Type': 'application/json',  "Authorization": "Bearer $alpaToken"});
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
