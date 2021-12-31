

import 'package:desktop_vendorapp/screens/login_screen.dart';
import 'package:desktop_vendorapp/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        },child: Text('signOut'),),
      ),
    );
  }
}
