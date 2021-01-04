import 'package:flutter/cupertino.dart';

class User {

  String username = '';
  String pictureURL = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String twitchId;
  String createdAt = '';

  save() {
    print('saving user using a web service');
  }

  User(@optionalTypeArgs this.username);

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }


}