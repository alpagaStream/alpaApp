import 'package:alpaga/models/user.dart';
import 'package:alpaga/services/api_user_data.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:alpaga/utils/dialog.dart';
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

  User currentUser;

  final userNameTextController = TextEditingController();
  final password0TextController = TextEditingController();
  final password2TextController = TextEditingController();
  final password1TextController = TextEditingController();
  bool loading = false;
  bool editing = false;

  editButtonPressed() async{
    if(!editing) {
      setState(() {
        editing = true;
      });
    }
    else {
      String userName = userNameTextController.text;
      String pw0 = password0TextController.text;
      String pw1 = password1TextController.text;
      String pw2 = password2TextController.text;

      if (pw1.isNotEmpty && (pw0.isEmpty || pw0 != currentUser.password)) {
        MyDialog.showMyDialog(context, 'Error!', 'Incorrect password!');
        return;
      }

      if (pw1.isNotEmpty && pw2.isEmpty || pw2 != pw1) {
        MyDialog.showMyDialog(context, 'Error!', "Passwords doesn't match");
        return;
      }

      var user = await ApiUserData.updateUser(user:currentUser, userName:userName, password: pw1);

      setState(() {
        editing = false;
        this.currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final userName = TextFormField(
      enabled: editing,
      keyboardType: TextInputType.name,
      autofocus: false,
      obscureText: false,
      cursorColor: ColorConstants.darkOrange,
      controller: userNameTextController,
      decoration: CommonStyle.textFieldStyle(hintTextStr: currentUser.username),
    );

    final email = TextFormField(
      enabled: false,
      autofocus: false,
      decoration: CommonStyle.textFieldStyle(hintTextStr: currentUser.email),
    );

    final password = TextFormField(
      enabled: editing,
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true,
      cursorColor: ColorConstants.darkOrange,
      controller: password0TextController,
      decoration: CommonStyle.textFieldStyle(hintTextStr: currentUser.password),
    );

    final newPassword = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true,
      cursorColor: ColorConstants.darkOrange,
      controller: password1TextController,
      decoration: CommonStyle.textFieldStyle(hintTextStr: "New Password"),
    );

    final validatePassword = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true,
      cursorColor: ColorConstants.darkOrange,
      controller: password2TextController,
      decoration: CommonStyle.textFieldStyle(hintTextStr: "Verify New Password"),
    );

    final  editButton = Container(
      width: 90,
      height: 40,
      child: RaisedButton(
        onPressed: () {
          editButtonPressed();
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.alpaBlue,
        child: Text('Edit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );

    final cancelButton = Container(
      width: 90,
      height: 40,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            editing = false;
          });
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Cancel',
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.alpaBlue,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );

    final double textSpacing = 8;

    return new Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                    "ACCOUNT SETTINGS",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: ResFont.openSans,
                    )
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 70,
                    minHeight: 70,
                    maxWidth: 465,
                    maxHeight: double.infinity,
                  ),
                  child: Container(
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
                        SizedBox(height: 32.0),
                        ListTile(
                          leading: Container(
                            width: 100,
                            child: Text("Username"),
                          ),
                          title: userName,
                        ),
                        SizedBox(height: textSpacing),
                        ListTile(
                          leading: Container(
                            width: 100,
                            child: Text("Email"),
                          ),
                          title: email,
                        ),
                        SizedBox(height: textSpacing),
                        ListTile(
                          leading: Container(
                            width: 100,
                            child: Text("Password"),
                          ),
                          title: password,
                        ),

                        if(editing) SizedBox(height: textSpacing),

                        if(editing)
                          ListTile(
                              leading: Container(
                                width: 100,
                                child: Text(""),
                              ),
                              title: newPassword
                          ),

                        if(editing) SizedBox(height: textSpacing),

                        if(editing)
                          ListTile(
                            leading: Container(
                              width: 100,
                              child: Text(""),
                            ),
                            title: validatePassword,
                          ),

                        SizedBox(height: textSpacing),
                        ListTile(
                          leading: Container(
                            width: 100,
                            child: Text("Twitch account"),
                          ),
                          title: currentUser.twitchId != null ? Text(currentUser.twitchId) :
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            child: TwitchConnectButton(),
                          ),

                        ),
                        SizedBox(height: textSpacing),
                        ListTile(
                          leading: Container(
                            width: 100,
                            child: Text("Created on"),
                          ),
                          title: Text(currentUser.createdAt),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if(editing) cancelButton,
                              SizedBox(width: 12,),
                              editButton
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              ,
            ]
        ),
      ),

    );
  }
}
