import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bandhana/common_files/api.dart';
import 'package:bandhana/users/my_drawer.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('पासवर्ड बदलें '),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25.0),
          child: Center(
            child: Form(
                child: Form(
                    key: formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          obscureText: _obscureText1,
                          decoration: InputDecoration(
                              labelText: 'पुराना पासवर्ड ',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText1
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggle1,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'पुराना पासवर्ड लिखना जरुरी है !!';
                            }
                            return null;
                          },
                          controller: oldPasswordController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextFormField(
                          obscureText: _obscureText2,
                          decoration: InputDecoration(
                              labelText: 'नया पासवर्ड ',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggle2,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'नया पासवर्ड लिखना जरुरी है !!';
                            }
                            return null;
                          },
                          controller: newPasswordController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextFormField(
                          obscureText: _obscureText3,
                          decoration: InputDecoration(
                              labelText: 'कन्फर्म पासवर्ड ',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText3
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggle3,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'कन्फर्म पासवर्ड लिखना जरुरी है !!';
                            }
                            if (value != newPasswordController.text) {
                              return 'नया पासवर्ड और कन्फर्म पासवर्ड गलत है !!';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  updatePassword(context);
                                }
                              },
                              child: Text('नया पासवर्ड सेव करें ')),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  Future<void> updatePassword(context) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    var id = prefs.getString('id');

    var url = Uri.parse('${api.baseUrl}resetPassword/$id');
    var map = new Map<String, dynamic>();
    map['pwd'] = oldPasswordController.text;
    map['newPassword'] = newPasswordController.text;

    final response = await http.put(url, body: map, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['result'] == 'success') {
      Flushbar(
        title: 'पासवर्ड बदलना सफल रहा ',
        message: 'सफलतापूर्वक पासवर्ड बदल गया  ',
        duration: Duration(seconds: 3),
      ).show(context);
    } else {
      Flushbar(
        title: 'गलत लॉग इन ',
        message: 'कृपया अपना सही पासवर्ड लिखें ',
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}
