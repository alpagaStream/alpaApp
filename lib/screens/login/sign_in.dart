
import 'package:alpaga/res.dart';
import 'package:alpaga/screens/login/login.dart';
import 'package:alpaga/services/ap_logini_service.dart';
import 'package:alpaga/widgets/bordered_textField.dart';
import 'package:alpaga/widgets/twitch_connect_button.dart';
import 'package:flutter/material.dart';
import 'package:alpaga/screens/home/home_screen.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../fonts.dart';


class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {

  bool isChecked = false;
  bool isLoggingIn = false;

  final userNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final password1TextController = TextEditingController();
  final password2TextController = TextEditingController();

  AnimationController controller;
  Animation cardInAnim;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameTextController.dispose();
    emailTextController.dispose();
    password1TextController.dispose();
    password2TextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    cardInAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1.0, curve: Curves.fastOutSlowIn)));
  }

  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Incorrect sign in !'),
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  signIn() async {

    this.setState(() {
      isLoggingIn = true;
    });

    String userName = userNameTextController.text;
    String email = emailTextController.text;
    String pw1 = password1TextController.text;
    String pw2 = password2TextController.text;

    if (userName.isEmpty) {
      _showMyDialog('You must chose an user name !');
      return;
    }

    if (email.isEmpty) {
      _showMyDialog('Invalid email address');
      return;
    }

    if (pw1.isEmpty) {
      _showMyDialog('Choose a password');
      return;
    }

    if (pw2.isEmpty || pw2 != pw1) {
      _showMyDialog("Passwords doesn't match");
      return;
    }

    var user = await ApiData.signIn(userName, pw1, email);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(currentUser: user,)),
    );


    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(currentUser: user,)),
      );
    }
    else {
      this.setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final userName = BorderedTextField(
      controller: userNameTextController,
      hintText: 'User Name',
    ).customize();

    final email = BorderedTextField(
      controller: emailTextController,
      hintText: 'Email',
    ).customize();

    final password = BorderedTextField(
      obscureText: true,
      controller: password1TextController,
      hintText: 'Password',
    ).customize();

    final validatePassword = BorderedTextField(
      obscureText: true,
      controller: password2TextController,
      hintText: 'Verify Password',
    ).customize();

    final loginButton = Container(
      width: 90,
      height: 40,
      child: RaisedButton(
        onPressed: () {
          signIn();
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


    final signUpButton = FlatButton(
      child: Text(
          'Sign in',
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


            pageBuilder: (context, animation1, animation2) => Login(),
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
          padding: EdgeInsets.only(left: 102, right: 102, top: 42, bottom: 42),
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 1.2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 12.0),
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
              TwitchConnectButton(),
              SizedBox(height: 30.0),
              userName,
              SizedBox(height: 18.0),
              email,
              SizedBox(height: 18.0),
              password,
              SizedBox(height: 18.0),
              validatePassword,
              SizedBox(height: 24.0),
              isLoggingIn
                  ? SpinKitWave(
                color: ColorConstants.alpaBlue,
                size: 40.0,
              )
                  : loginButton,
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Already signed in ?',
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
