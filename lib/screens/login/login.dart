import 'package:alpaga/res.dart';
import 'package:flutter/material.dart';
import 'package:alpaga/screens/home/home_screen.dart';
import 'package:alpaga/services/api_service.dart';
import 'package:alpaga/utils/color_constants.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image(
      image: AssetImage(Res.alpagaBaseLogo),
      width: 200.0,
      height: 200.0,
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                fontWeight: FontWeight.bold)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
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
          Center(
            child: Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.2,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 62.0),
                    logo,
                    SizedBox(height: 8.0),
                    Center(
                        child: Text(
                      "Alpaga",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.alpaBlue,
                      ),
                    )),
                    SizedBox(height: 48.0),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
