import 'package:bandhana/forgotPasswordPage.dart';
import 'package:bandhana/registerPage.dart';
import 'package:bandhana/routes.dart';
import 'package:flutter/material.dart';
import 'package:bandhana/credentialCheck.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CredentialCheck());
  }
}
