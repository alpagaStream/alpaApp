import 'package:alpaga/models/user.dart';
import 'package:alpaga/widgets/bordered_textField.dart';
import 'package:alpaga/widgets/twitch_connect_button.dart';
import 'package:flutter/material.dart';


import '../../fonts.dart';
import '../../res.dart';

class Settings extends StatefulWidget {

  Settings({
    @required this.currentUser,
  });

  final User currentUser;

  @override
  _SettingsState createState() => _SettingsState(currentUser: currentUser);
}


class _SettingsState extends State<Settings> {

  _SettingsState({
    @required this.currentUser,
  });

  final User currentUser;

  final userNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final password1TextController = TextEditingController();
  final password2TextController = TextEditingController();
  bool loading = false;
  bool editing = false;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
            padding: const EdgeInsets.all(30.0),
            children: <Widget>[
              Text(
                  "ACCOUNT SETTINGS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: ResFont.openSans,
                  )
              ),
              SizedBox(height: 30.0),
              Container(
                width: 600,
                height: 300,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(140.0),
                      child: FadeInImage.assetNetwork(
                        height: 140,
                        width: 140,
                        placeholder: Res.peoplePlaceHolder,
                        image: currentUser.pictureURL,
                      ),
                    ),
                    Row(
                      children: [
                        Text("Username"),
                        BorderedTextField(
                          controller: userNameTextController,
                          hintText: currentUser.username,
                        ).customize(),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Email"),
                        Text(currentUser.username),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Password"),
                        Text("Change password"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Twitch account"),
                        currentUser.twitchId != null ? Text(currentUser.twitchId) : TwitchConnectButton(),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Created on"),
                        Text(currentUser.createdAt),
                      ],
                    ),
                  ],
                ),
              ),
            ]
        )
    );
  }
}
