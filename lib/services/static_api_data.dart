import 'dart:convert' as convert;
import 'package:alpaga/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiData {

  static String apiToken;
  static String baseURL = "https://alpa-user.herokuapp.com/";

  static Map<String, String> apiHeaders(){

    if(apiToken != null) {
      return {'Content-Type': 'application/json',  "Authorization": "Bearer $apiToken"};
    }
    else {
      return {'Content-Type': 'application/json'};
    }

  }


}
