import 'package:another_flushbar/flushbar.dart';
import 'package:bandhana/common_files/api.dart';
import 'package:bandhana/credentialCheck.dart';
import 'package:bandhana/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:bandhana/users/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  final TextEditingController preData;

  RegisterPage({Key? key, required this.preData}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController villageController = TextEditingController();

  String? name;

  String? email;

  String? mobileNo;

  String? state;

  String? city;

  String? village;

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'आपका रजिस्ट्रेशन सफलतापूर्वक हो गया है और आपका पासवर्ड आपके ईमेल में भेजा जाएगा |'),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text('ठीक है'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CredentialCheck(),
                    ),
                  );
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('यहाँ रजिस्टर करें'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.number,
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
                      controller: widget.preData,
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
      ),
    );
  }

  void toggleSound(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(preData: mobileNoController),
      ),
    );
  }

  Future<void> regUser(context) async {
    var url = Uri.parse('${api.baseUrl}profileStore');
    var map = new Map<String, dynamic>();
    map['name'] = nameController.text;
    map['mobile_no'] = widget.preData.text;
    map['email'] = emailController.text;
    map['state'] = stateController.text;
    map['city'] = cityController.text;
    map['village'] = villageController.text;

    final response = await http.post(url, body: map);

    var responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['result'] == 'success') {
      nameController.clear();
      mobileNoController.clear();
      emailController.clear();
      stateController.clear();
      cityController.clear();
      villageController.clear();
      _displayDialog(context);
      // Flushbar(
      //   title: 'रजिस्ट्रेशन सफल रहा  ',
      //   message: 'आपका प्रोफाइल पासवर्ड आपके ईमेल में भेजा जाएगा | ',
      //   duration: Duration(seconds: 3),
      // ).show(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LoginPage(preData: mobileNoController),
      //   ),
      // );
    } else {
      Flushbar(
        title: 'रजिस्ट्रेशन असफल ',
        message: 'कृपया दोबारा प्रयास करें !!!',
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}
