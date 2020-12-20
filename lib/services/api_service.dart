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

  static User currentUser;

  static  Future<dynamic> twitchLogin(String twitchCode) async {

    print("********* twitch Login ***********");
    var url = baseURL + 'users/login/twitch';
    final params = jsonEncode({"code": twitchCode});
    var response = await http.post(url, body: params, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      String token = jsonResponse["token"];
      if(token != null) {
        await getUser(token);
      }
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
    }

  }

  static Future<dynamic> getUser(String alpaToken) async {

    print("********* get User w token : $alpaToken ***********");
    var url = baseURL + 'users/current';
    var response = await http.get(url, headers: {'Content-Type': 'application/json',  "Authorization": "Bearer $alpaToken"});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      currentUser = User.fromJson(jsonResponse);
      print(jsonResponse);
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
    }
  }

}
