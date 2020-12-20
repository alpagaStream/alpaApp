import 'package:alpaga/res.dart';
import 'package:alpaga/screens/login/sign_in.dart';
import 'package:alpaga/widgets/twitch_connect_button.dart';
import 'package:flutter/material.dart';
import 'package:alpaga/screens/home/home_screen.dart';
import 'package:alpaga/services/api_service.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../fonts.dart';

class Login extends StatefulWidget {

  Login({
    @optionalTypeArgs this.twitchCode,
  });

  final String twitchCode;

  @override
  _LoginState createState() => _LoginState(twitchCode: twitchCode,);
}


class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  bool isLoggingIn = false;
  bool isChecked = false;
  AnimationController controller;
  Animation cardInAnim;
  final String twitchCode;

  _LoginState({
    @optionalTypeArgs this.twitchCode,
  });

  @override
  void initState() {
    super.initState();

    finishTwitchLogin();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    cardInAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1.0, curve: Curves.fastOutSlowIn)));
  }

  finishTwitchLogin() async {
    if(twitchCode != null) {
      isLoggingIn = true;
      await ApiData.twitchLogin(twitchCode).then((value) {
        print("ApiData.twitchLogin then : ");
        if(ApiData.currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(currentUser: ApiData.currentUser,)),
          );
        }
        else {
          this.setState(() {
            isLoggingIn = false;
          });
        }
      },
          onError:(e) {
            this.setState(() {
              isLoggingIn = false;
            });
          }

      );

    }

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      cursorColor: ColorConstants.darkOrange,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.darkOrange),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      cursorColor: ColorConstants.darkOrange,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.darkOrange),
        ),
      ),
    );

    final loginButton = Container(
      width: 90,
      height: 40,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.alpaBlue,
        child: Text('Log In',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {

      },
    );

    final signUpButton = FlatButton(
      child: Text(
          'Sign up',
          style: TextStyle(
              fontSize: 16,
              color: ColorConstants.darkOrange,
              fontWeight: FontWeight.bold
          )
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SignIn(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
    );

    final loginCard = Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(20)),
        ),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(42),
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 1.2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 42.0),
              Image(
                image: AssetImage(Res.alpagaBaseLogo),
                width: 160.0,
                height: 160.0,
              ),
              SizedBox(height: 8.0),
              Center(
                  child: Text(
                    "ALPAGA",
                    style: TextStyle(
                      fontFamily: ResFont.fascinate,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.alpaBlue,
                    ),
                  )),
              SizedBox(height: 30.0),
              isLoggingIn
                  ? SpinKitRotatingCircle(
                color: ColorConstants.twitchViolet,
                size: 50.0,
              )
                  :  TwitchConnectButton(),
              SizedBox(height: 30.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: ColorConstants.lightOrange,
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                      Text("Remember Me")
                    ],
                  ),
                  forgotLabel,
                ],
              ),
              SizedBox(height: 18.0),
              loginButton,
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'No account yet ?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      signUpButton,
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );

    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ColorConstants.lightOrange, ColorConstants.darkOrange])
                  ),
                ),
                AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 100),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: loginCard
                ),
              ],
            ),
          );
        }
    );

  }
}
