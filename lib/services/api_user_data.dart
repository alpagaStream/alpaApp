import 'dart:convert' as convert;
import 'package:alpaga/models/live_stream.dart';
import 'package:alpaga/models/user.dart';
import 'package:alpaga/services/static_api_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiUserData {

  static  Future<User> updateUser(User user, String userName, String password) async {

    print("********* update user ***********");
    var url = ApiData.baseURL + 'users/current';
    var paramsMap = {
      "username": userName,
    };
    if(password != null && password.isNotEmpty) {
      paramsMap["password"] = password;
    }

    final params = jsonEncode(paramsMap);

    var response = await http.patch(url, body: params, headers: ApiData.apiHeaders());
    print(response.body);
    if (response.statusCode == 200) {
        user.username = userName;
        if(password != null && password.isNotEmpty) {
          user.password = password;
        }

        return user;
    } else {
      print("Request $url failed with status: ${response.statusCode}.");
      return null;
    }
  }

  static Future<List<LiveStream> > getStreams() async {
    var streamHistory = [];
    print("********* get user stream history ***********");
    var url = ApiData.baseURL + 'users/current/hostings';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      jsonResponse.forEach((data) {
        streamHistory.add(LiveStream.fromJson(data));
      });
      print(streamHistory);
      // List<LiveStream> liveStreams = <LiveStream>[
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      //   new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
      // ];
      return streamHistory;
    } else {
      print("Request failed with status: ${response.statusCode}.");
      return null;
    }
  }

}
