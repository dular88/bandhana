import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_drawer.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name;
  late String email;
  late String mobile_no;
  late String state;
  late String city;
  late String village;
  late String gender;
  late String dob;
  late String father_name;
  late String father_profession;
  late String mother_name;
  late String mother_profession;
  late String mother_village;
  late String asset;
  late String height;
  late String color;
  late String education;
  late String sibling;
  late String gotra;
  late String permanent_address;

  void initState() {
    super.initState();
    _getStoredValue();
  }

  Future<void> _getStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      email = prefs.getString('email')!;
      mobile_no = prefs.getString('mobile_no')!;
      state = prefs.getString('state')!;
      city = prefs.getString('city')!;
      village = prefs.getString('village')!;
      gender = prefs.getString('gender')!;
      dob = prefs.getString('dob')!;
      father_name = prefs.getString('father_name')!;
      father_profession = prefs.getString('father_profession')!;
      mother_name = prefs.getString('mother_name')!;
      mother_profession = prefs.getString('mother_profession')!;
      mother_village = prefs.getString('mother_village')!;
      asset = prefs.getString('asset')!;
      height = prefs.getString('height')!;
      color = prefs.getString('color')!;
      education = prefs.getString('education')!;
      sibling = prefs.getString('sibling')!;
      gotra = prefs.getString('gotra')!;
      permanent_address = prefs.getString('permanent_address')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('मेरी जानकारी (Profile)'),
        ),
        drawer: MyDrawer(),
        // ignore: prefer_const_constructors
        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Table(
                          columnWidths: {
                            0: FractionColumnWidth(.4),
                            1: FractionColumnWidth(.6)
                          },
                          children: [
                            TableRow(children: [
                              Text("नाम "),
                              Text(name),
                            ]),
                            TableRow(children: [
                              Text("ईमेल "),
                              Text(email),
                            ]),
                            TableRow(children: [
                              Text("मोबाइल न."),
                              Text(mobile_no),
                            ]),
                            TableRow(children: [
                              Text("लिंग "),
                              Text(gender),
                            ]),
                            TableRow(children: [
                              Text("शिक्षा/व्यवसाय "),
                              Text(education),
                            ]),
                            TableRow(children: [
                              Text("ऊंचाई "),
                              Text(height),
                            ]),
                            TableRow(children: [
                              Text("रंग "),
                              Text(color),
                            ]),
                            TableRow(children: [
                              Text("पिता का नाम "),
                              Text(father_name),
                            ]),
                            TableRow(children: [
                              Text("पिता का व्यवसाय "),
                              Text(father_profession),
                            ]),
                            TableRow(children: [
                              Text("माता का नाम "),
                              Text(mother_name),
                            ]),
                            TableRow(children: [
                              Text("माता का व्यवसाय "),
                              Text(mother_profession),
                            ]),
                            TableRow(children: [
                              Text("माँ का मायका "),
                              Text(mother_village),
                            ]),
                            TableRow(children: [
                              Text("जमीन "),
                              Text(asset),
                            ]),
                            TableRow(children: [
                              Text("गोत्र "),
                              Text(gotra),
                            ]),
                            TableRow(children: [
                              Text("राज्य  "),
                              Text(state),
                            ]),
                            TableRow(children: [
                              Text("शहर  "),
                              Text(city),
                            ]),
                            TableRow(children: [
                              Text("वर्तमान पता  "),
                              Text(village),
                            ]),
                            TableRow(children: [
                              Text("स्थाई पता "),
                              Text(permanent_address),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
          ),
        ));
  }
}
