import 'package:bandhana/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:bandhana/users/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../common_files/api.dart';
import 'my_drawer.dart';

class NewUser extends StatefulWidget {
  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController villageController = TextEditingController();

  final List<String> _genders = ["Male", "Female", ""];

  String _selectedGender = "Male";

  String? name;

  String? email;

  String? mobileNo;

  String? state;

  String? city;

  String? village;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('यहाँ रजिस्टर करें'),
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
                    decoration: InputDecoration(
                        labelText: 'नाम ', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'नाम लिखना जरुरी है !!';
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  DropdownButton(
                    value: _selectedGender,
                    items: _genders.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value as String;
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'मोबाइल नंबर ',
                        border: OutlineInputBorder()),
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
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'ईमेल', border: OutlineInputBorder()),
                    validator: MultiValidator([
                      EmailValidator(errorText: 'यह सही ईमेल नहीं है !!'),
                      RequiredValidator(errorText: 'ईमेल लिखना जरुरी है !!'),
                    ]),
                    controller: emailController,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'राज्य', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'राज्य चुनना जरुरी है !!';
                      }
                      return null;
                    },
                    controller: stateController,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'शहर', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'शहर चुनना जरुरी है !!';
                      }
                      return null;
                    },
                    controller: cityController,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'गाँव', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'गाँव का नाम लिखना जरुरी है !!';
                      }
                      return null;
                    },
                    controller: villageController,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
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
                        child: Text('रजिस्टर')),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> regUser(context) async {
    var url = Uri.parse('${api.baseUrl}profileStore');
    var map = new Map<String, dynamic>();
    map['request_type'] = 'register';
    map['name'] = nameController.text;
    map['mobile_no'] = mobileNoController.text;
    map['email'] = emailController.text;
    map['state'] = stateController.text;
    map['city'] = cityController.text;
    map['village'] = villageController.text;

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
      print('notify' + responseData);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => RegisterPage(),
      //   ),
      // );
    }
  }
}
