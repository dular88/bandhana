import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'my_drawer.dart';
import 'package:flutter/widgets.dart';

class SelectedProfile extends StatefulWidget {
  const SelectedProfile({Key? key}) : super(key: key);

  @override
  State<SelectedProfile> createState() => _SelectedProfileState();
}

class _SelectedProfileState extends State<SelectedProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('मेरी जानकारी (Profile)'),
        ),
        drawer: MyDrawer(),
        // ignore: prefer_const_constructors
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Card(
                  child: Column(children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.location_city,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.domain,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.face,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(
                        text: 'johndoe@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ])),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('This is a widget text',
                      style: TextStyle(fontSize: 24.0))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('This is a widget text',
                        style: TextStyle(fontSize: 24.0)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('This is a widget text',
                        style: TextStyle(fontSize: 24.0)),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
