import 'package:flutter/material.dart';
import 'package:alpaga/screens/dashboard/dashboard.dart';
import 'package:alpaga/screens/forms/form.dart';
import 'package:alpaga/screens/hero/hero_screen.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../res.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class ListDrawerButton extends FlatButton {
  ListDrawerButton({
    @required this.onPressed,
    @required this.selected,
    @required this.iconData,
    @required this.text
  });

  final GestureTapCallback onPressed;
  final bool selected;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(20), bottomLeft: const Radius.circular(20)),
      ),
      color: selected ? Colors.white : Colors.transparent,
      //color: Colors.grey[100],
      onPressed: onPressed,

      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.only(top: 22, bottom: 22, right: 22, left: 10),
          child: Row(children: [
            Icon(
              iconData,
              color: selected ? ColorConstants.darkOrange : ColorConstants.lightGrey,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                color: selected ? Colors.black : ColorConstants.lightGrey,
                fontSize: 18,
                fontFamily: 'HelveticaNeue',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  TabController tabController;
  int active = 0;

  @override
  void initState() {
    super.initState();

    tabController = new TabController(vsync: this, length: 3, initialIndex: 0)
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
                Dashboard(),
                FormMaterial(),
                HeroAnimation(),
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
              SizedBox(height: 22.0),
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
                child: FadeInImage.memoryNetwork(
                  height: 140,
                  width: 140,
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/250?image=9',
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                  child: Text(
                    "User name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: ResFont.openSans,
                    ),
                  )
              ),
              SizedBox(height: 22.0),
            ],
          ),
        ),
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
            ],
          ),
        ),
      ],
    );
  }
}
