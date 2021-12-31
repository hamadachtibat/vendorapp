import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/screens/dashboard_screen.dart';
import 'package:desktop_vendorapp/screens/logout_screen.dart';
import 'package:desktop_vendorapp/screens/order_screen.dart';
import 'package:desktop_vendorapp/screens/product_screen.dart';
import 'package:desktop_vendorapp/screens/report_screen.dart';
import 'package:flutter/material.dart';

class DrawerServices {
  Widget DrawerScreen(title,context) {
    if (title == Languages.of(context)!.dashboard) {
      return MainScreen();
    }
    if (title == Languages.of(context)!.employers) {
      return const ProductScreen();
    }
    if (title == 'Report') {
      return const ReportScreen();
    }
    if (title == Languages.of(context)!.myOrders) {
      return const OrdersScreen();
    }
    if (title == Languages.of(context)!.logout) {
      return const LogOutScreen();
    }
    return MainScreen();
  }
}
