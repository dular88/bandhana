import 'package:bandhana/common_files/api.dart';
import 'package:bandhana/users/dashboard.dart';
import 'package:bandhana/users/profile.dart';
import 'package:flutter/material.dart';
import 'package:bandhana/forgotPasswordPage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController preData;

  LoginPage({Key? key, required this.preData}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? mobileNo;

  String? password;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('यहाँ से लॉग इन करें '),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    enabled: false,
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
                    controller: widget.preData,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        labelText: 'पासवर्ड',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: _toggle,
                        )),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'पासवर्ड लिखना जरुरी है !!'),
                    ]),
                    controller: passwordController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            login(context);
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
                      widget.preData.text = '123';
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

  Future<void> login(context) async {
    var url = Uri.parse('${api.baseUrl}profileLogin');
    var map = new Map<String, dynamic>();
    map['mobile_no'] = widget.preData.text;
    map['pwd'] = passwordController.text;

    final response = await http.post(url, body: map);

    var responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['result'] == 'success') {
      var data = responseData['data'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseData['token']);
      await prefs.setString('id', data['id'].toString());
      await prefs.setString('name', data['name']);
      await prefs.setString('email', data['email'] ?? '');
      await prefs.setString('state', data['state'] ?? '');
      await prefs.setString('city', data['city'] ?? '');
      await prefs.setString('village', data['village'] ?? '');
      await prefs.setString('mobile_no', data['mobile_no'] ?? '');
      await prefs.setString('gender', data['gender'] ?? '');
      await prefs.setString('dob', data['dob'] ?? '');
      await prefs.setString('father_name', data['father_name'] ?? '');
      await prefs.setString(
          'father_profession', data['father_profession'] ?? '');
      await prefs.setString('mother_name', data['mother_name'] ?? '');
      await prefs.setString(
          'mother_profession', data['mother_profession'] ?? '');
      await prefs.setString('mother_village', data['mother_village'] ?? '');
      await prefs.setString('height', data['height'] ?? '');
      await prefs.setString('color', data['color'] ?? '');
      await prefs.setString('gotra', data['gotra'] ?? '');
      await prefs.setString('education', data['education'] ?? '');
      await prefs.setString(
          'permanent_address', data['permanent_address'] ?? '');
      await prefs.setString('sibling', data['sibling'] ?? '');
      await prefs.setString('asset', data['asset'] ?? '');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
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
