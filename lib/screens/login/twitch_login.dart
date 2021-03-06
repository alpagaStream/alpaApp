import 'package:alpaga/services/api_login_service.dart';
import 'package:alpaga/utils/platform_utils.dart';
import 'package:flutter/material.dart';

import 'dart:io' as io;

import 'package:webview_flutter/webview_flutter.dart';

import 'dart:html' as html;

class TwitchLogin extends StatefulWidget {

  static String twitchUrl = "https://id.twitch.tv/oauth2/authorize?client_id=ondqxzgmbkta5pdx97tgrh8ds49no8&redirect_uri=http://localhost:54632/%23&response_type=code&scope=user_read+chat%3Aread+chat%3Aedit+channel%3Amoderate+whispers%3Aread+whispers%3Aedit+channel_editor";

  @override
  TwitchLoginState createState() => TwitchLoginState();

  static void login(BuildContext context) {

    if(PlatformUtils.isWebPlatform()) {

      var currentUrl = html.window.location.href.substring(0, html.window.location.href.length);
      print(currentUrl);
      final uri = Uri.https("id.twitch.tv", "oauth2/authorize",
          {
            "client_id": "ondqxzgmbkta5pdx97tgrh8ds49no8",
            "redirect_uri":  currentUrl,
            // "redirect_uri": "http://localhost:54632/#",
            "response_type": "code",
            "scope": "user_read chat:read chat:edit channel:moderate whispers:read whispers:edit channel_editor",
          }
      );

      // redirect_uri=http%3A%2F%2Flocalhost%3A54632%2F%23
      print(uri);
      // return;
      html.window.location.href = uri.toString();
    }
    else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 0),
          pageBuilder: (context, animation1, animation2) => TwitchLogin(),
        ),
      );
    }
  }

}

class TwitchLoginState extends State<TwitchLogin> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (io.Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: TwitchLogin.twitchUrl,
    );
  }

}
