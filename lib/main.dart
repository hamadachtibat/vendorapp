

import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/providers/order_provider.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:desktop_vendorapp/screens/add_newproduct_screen.dart';
import 'package:desktop_vendorapp/screens/auth_screen.dart';
import 'package:desktop_vendorapp/screens/home_screen.dart';
import 'package:desktop_vendorapp/screens/login_screen.dart';
import 'package:desktop_vendorapp/screens/registre_screen.dart';
import 'package:desktop_vendorapp/screens/splash_screen.dart';
import 'package:desktop_vendorapp/services/fcm/fcm_backround.dart';
import 'package:desktop_vendorapp/widgets/reset_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
FlutterLocalNotificationsPlugin ?flutterLocalNotificationsPlugin;
AndroidNotificationChannel ?channel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(fireBaseBackroudMsgHandler);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  channel =  const AndroidNotificationChannel('ahmed','ahmed',
      importance: Importance.max);
  await flutterLocalNotificationsPlugin!.
  resolvePlatformSpecificImplementation
  <AndroidFlutterLocalNotificationsPlugin>()?.
  createNotificationChannel(channel!);
  await FirebaseMessaging.instance.
  setForegroundNotificationPresentationOptions(
    alert: true,
    badge:true,
    sound:true,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_)=> AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (_)=> ProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (_)=> OrderProvider(),
    ),
  ],
    child: const MyApp(),
  )
  );


}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale ?_locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      locale: _locale,
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
       primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id :(context) =>  const SplashScreen(),
        AuthScreen.id :(context) =>  const AuthScreen(),
        HomeScreen.id :(context) =>  const HomeScreen(),
        RegistreScreen.id :(context)=>const RegistreScreen(),
        LoginScreen.id :(context)=>const LoginScreen(),
        ResetPassword.id :(context)=>const ResetPassword(),
        AddNewProduct.id :(context)=> AddNewProduct(),


      },
      home: const SplashScreen(),
    );
  }
}