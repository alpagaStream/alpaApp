import 'package:alpaga/screens/login/twitch_login.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:flutter/material.dart';

import '../res.dart';

class TwitchConnectButton extends FlatButton {
  TwitchConnectButton();

  @override
  Widget build(BuildContext context) {
    final buttonHeight = 48.0;
    return FlatButton(
      color: ColorConstants.twitchViolet,
      height: buttonHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(const Radius.circular(4)),
      ),
      onPressed: () async {
        print("****** twitchButton onPressed ********");
        TwitchLogin.login(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
        child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Image(
                image: AssetImage(Res.twitchLogoButton),
                height: 26,
                width: 26,
              ),
              SizedBox(
                width: 14,
              ),
              Container(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                    'TWITCH CONNECT',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    )
                ),
              ),

            ]),
      ),
    );
  }
}

