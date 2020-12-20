import 'package:flutter/material.dart';
import 'package:alpaga/screens/home/home_screen.dart';
import 'package:alpaga/screens/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => Login(),
      // '/home': (BuildContext context) => HomeScreen(),
    };
    return MaterialApp(

      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        print("on generate routes settings : $settings");
        final loc = Uri.parse(settings.name);
        print(" path: ${loc.path}");
        print(" query params ${loc.queryParameters}");
        String code = loc.queryParameters["code"];
        return MaterialPageRoute(
          builder: (context) {
            return Login(twitchCode: code);
          },
        );
      },

      initialRoute: '/',
      routes: routes,
      theme: ThemeData(fontFamily: 'HelveticaNeue'),
      debugShowCheckedModeBanner: false,
      title: 'Alpaga',
    );
  }
}
