import 'package:flutter/material.dart';
import 'package:bandhana/registerPage.dart';
import 'package:bandhana/forgotPasswordPage.dart';
import 'main.dart';

class Routes {
  static const String home = '/';
  static const String register = '/register';
  static const String fpass = '/fpass';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => MyApp(),
      fpass: (context) => ForgotPasswordPage(),
    };
  }
}
