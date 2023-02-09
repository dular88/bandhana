import 'package:bandhana/common_files/api.dart';
import 'package:bandhana/loginPage.dart';
import 'package:bandhana/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:bandhana/users/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bandhana/routes.dart';

class CredentialCheck extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController mobileNoController = TextEditingController();

  String? mobile_no;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credential Check'),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  Image.asset('bandhana_logo.png'),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'मोबाइल नंबर ',
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
                    controller: mobileNoController,
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
                        child: Text('लॉग इन स्टेटस')),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> regUser(context) async {
    var url = Uri.parse('${api.baseUrl}credentialCheck');
    var map = new Map<String, dynamic>();
    map['mobile_no'] = mobileNoController.text;

    final response = await http.post(url, body: map);

    var responseData = jsonDecode(response.body);
    print(responseData['result']);
    if (responseData['result'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(preData: mobileNoController),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(preData: mobileNoController),
        ),
      );
    }
  }
}
