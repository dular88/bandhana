import 'package:bandhana/common_files/api.dart';
import 'package:bandhana/users/profile.dart';
import 'package:flutter/material.dart';
import 'package:bandhana/forgotPasswordPage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_drawer.dart';

class Suggestion extends StatefulWidget {
  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? mobileNo;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('यहाँ से लॉग इन करें '),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    minLines: 10,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'अपना सुझाव लिखें ',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.mobile_friendly)),
                    validator: (value) {
                      // define a regular expression for validating mobile numbers
                      final mobileRegExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
                      if (!mobileRegExp.hasMatch(value!)) {
                        return 'मोबाइल नंबर लिखना जरुरी हैं !!';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            regUser(context);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Processing Data')),
                            // );
                          }
                        },
                        child: Text('लॉग इन')),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text('Forgot Password?'),
                    onPressed: () {
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> regUser(context) async {
    var url = Uri.parse('${api.baseUrl}');
    var map = new Map<String, dynamic>();
    map['request_type'] = 'login';
    map['mobile_no'] = 123;
    map['pwd'] = passwordController.text;

    final response = await http.post(url, body: map);

    var responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['result'] == 'success') {
      var data = responseData['data'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', data['name']);
      await prefs.setString('email', data['name']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(),
        ),
      );
    } else {
      Flushbar(
        title: 'गलत लॉग इन ',
        message: 'कृपया अपना सही पासवर्ड लिखें ',
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}
