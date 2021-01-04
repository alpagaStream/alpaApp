import 'dart:convert' as convert;
import 'package:alpaga/models/user.dart';
import 'package:alpaga/services/static_api_data.dart';
import 'package:http/http.dart' as http;
import 'package:alpaga/models/github_model.dart';
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

}
