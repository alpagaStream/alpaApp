import 'package:flutter/material.dart';
import 'package:alpaga/screens/home/home_screen.dart';
import 'package:alpaga/screens/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => Login(),
      '/home': (BuildContext context) => HomeScreen(),
    };
    return MaterialApp(
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(fontFamily: 'HelveticaNeue'),
      debugShowCheckedModeBanner: false,
      title: 'Alpaga',
    );
  }
}
