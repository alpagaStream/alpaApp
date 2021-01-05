import 'package:alpaga/models/user.dart';
import 'package:alpaga/screens/dashboard/hosting.dart';
import 'package:alpaga/screens/forms/settings.dart';
import 'package:alpaga/services/api_user_data.dart';
import 'package:flutter/material.dart';
import 'package:alpaga/utils/color_constants.dart';

import '../../fonts.dart';
import '../../res.dart';
import 'list_drawer_button.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({
    @required this.currentUser,
  });

  final User currentUser;

  @override
  HomeScreenState createState() => HomeScreenState(currentUser: currentUser);
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  HomeScreenState({
    @required this.currentUser,
  });

  User currentUser;

  TabController tabController;
  int active = 0;

  @override
  void initState() {
    super.initState();

    tabController = new TabController(vsync: this, length: 2, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  toggleAutoHosting(bool value) async {

    final oldUser = currentUser;
    setState(() {
      currentUser.autoHostActive = value;
    });
    final user = await ApiUserData.updateUser(user: currentUser, autoHosting: value);
    setState(() {
      currentUser = user ?? oldUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
            elevation: 0.0,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ColorConstants.lightOrange, ColorConstants.darkOrange])
                ),
                margin: EdgeInsets.all(0),
                height: MediaQuery.of(context).size.height,
                width: 300,
                child: listDrawerItems(false)),
          ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                Hosting(currentUser: currentUser),
                Settings(currentUser: currentUser),
              ],
            ),
          )
        ],
      ),
      drawer: Padding(
          padding: EdgeInsets.only(top: 56),
          child: Drawer(child: listDrawerItems(true))),
    );
  }

  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 32.0),
              Center(
                  child: Text(
                    "ALPAGA",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: ResFont.fascinate,
                    ),
                  )
              ),
              SizedBox(height: 18.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(140.0),
                child: FadeInImage.assetNetwork(
                  height: 140,
                  width: 140,
                  placeholder: Res.peoplePlaceHolder,
                  image: currentUser.pictureURL,
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                  child: Text(
                    currentUser.username,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: ResFont.openSans,
                    ),
                  )
              ),
            ],
          ),
        ),
        SizedBox(height: 22.0),
        Container(
          margin: EdgeInsets.only(top: 12, left: 25),
          child: Column(
            children: <Widget>[
              ListDrawerButton(
                  iconData: Icons.dashboard,
                  text: "Hosting",
                  selected: tabController.index == 0,
                  onPressed: () {
                    print(tabController.index);
                    tabController.animateTo(0);
                    drawerStatus ? Navigator.pop(context) : print("");
                  }
              ),
              ListDrawerButton(
                  iconData: Icons.settings,
                  text: "Settings",
                  selected: tabController.index == 1,
                  onPressed: () {
                    print(tabController.index);
                    tabController.animateTo(1);
                    drawerStatus ? Navigator.pop(context) : print("");
                  }
              ),
              SizedBox(height: 22.0),
              Center(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: currentUser.autoHostActive,
                      onChanged: (value) {
                        setState(() {
                          toggleAutoHosting(value);
                        });
                      },
                      activeTrackColor: ColorConstants.alpaBlue.withOpacity(0.7),
                      activeColor: ColorConstants.alpaBlue,
                    ),
                    Text(
                      "Auto Hosting",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: ResFont.openSans,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
