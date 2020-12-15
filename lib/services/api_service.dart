import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:alpaga/models/github_model.dart';

class ApiData {
  static String baseURL = "https://alpa-user.herokuapp.com/heartbeat";


  static List<GithubTrendingModel> githubTrendingModel;
  static Future<dynamic> getData() async {
    githubTrendingModel = [];
    var url =
        "https://github-trending-api.now.sh/repositories?language=&since=daily";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      jsonResponse.forEach((data) {
        ApiData.githubTrendingModel.add(GithubTrendingModel.fromJson(data));
      });
      print(ApiData.githubTrendingModel);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  static String twitchConnectURL = "https://id.twitch.tv/oauth2/authorize?client_id=Client_id&redirect_uri=redirect_uri&response_type=code&scope=user_read+chat:read+chat:edit+channel:moderate+whispers:read+whispers:edit+channel_editor";

  static Future<dynamic> twitchConnect() async {
    print("********** twitchConnect url ${twitchConnectURL}");
    var response = await http.get(twitchConnectURL);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print("********** twitchConnect response ************");
      print(jsonResponse);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

}
