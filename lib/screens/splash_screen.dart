import 'dart:async';


import 'package:desktop_vendorapp/screens/auth_screen.dart';
import 'package:desktop_vendorapp/screens/login_screen.dart';
import 'package:desktop_vendorapp/screens/registre_screen.dart';
import 'package:desktop_vendorapp/services/fcm/fcm_notification_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id="Splash-screen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3,),(){
        FirebaseAuth.instance.authStateChanges().listen((User ?user) {
          if(user==null){
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          }else{
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          }
        });
    }
    );
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/logotashil.jpg"),
            const Text("تسهيل للمكاتب جلب الايدي العاملة", style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold ,fontFamily: 'Cairo'),
            ),
          ],
        ),


      ),
    );
  }
}