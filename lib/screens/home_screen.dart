

import 'package:desktop_vendorapp/screens/registre_screen.dart';
import 'package:desktop_vendorapp/services/drawer_services.dart';
import 'package:desktop_vendorapp/services/fcm/fcm_notification_handler.dart';
import 'package:desktop_vendorapp/widgets/drawer_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../main.dart';
import 'dashboard_screen.dart';
class HomeScreen extends StatefulWidget {
  static const String id = 'Home-screnn';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DrawerServices _drawerServices = DrawerServices();
  final GlobalKey<SliderMenuContainerState> _key =
  GlobalKey<SliderMenuContainerState>();
  String ?title;
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value){
      print('token value for this user $value');
    });
    FirebaseMessaging.instance.subscribeToTopic(
        FirebaseAuth.instance.currentUser!.uid).then((value) =>
        print('success'));
    initFirebaseMessagingHandler(channel!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: SliderMenuContainer(
          slideDirection:Localizations.localeOf(context).languageCode == 'ar'?
          SlideDirection.RIGHT_TO_LEFT:SlideDirection.LEFT_TO_RIGHT,
            appBarColor: Colors.white,
            appBarHeight: 80,
            key: _key,
            sliderMenuOpenSize: 200,
            trailing: Row(children: [
              IconButton(onPressed: (){},icon: const Icon(CupertinoIcons.search), ),
              IconButton(onPressed: (){},icon: const Icon(CupertinoIcons.bell), ),

            ],),
            title: const Text(
              '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
            sliderMenu: MenuWidget(
              onItemClick: (title) {
                _key.currentState!.closeDrawer();
                setState(() {
                  this.title = title;
                });
              },
            ),
            sliderMain: _drawerServices.DrawerScreen(title,context)),
      ),
    );
  }
}
