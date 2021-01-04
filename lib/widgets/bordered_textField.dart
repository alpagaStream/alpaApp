import 'package:alpaga/screens/login/twitch_login.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:flutter/material.dart';

import '../res.dart';

class CommonStyle{
  static InputDecoration textFieldStyle({String labelTextStr="",String hintTextStr=""}) {
    return InputDecoration(
      hintText: hintTextStr,
      // prefixIcon: Icon(
      //   Icons.email,
      // ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorConstants.darkOrange),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),
    );
  }
}

