import 'package:bandhana/users/dashboard.dart';
import 'package:bandhana/users/newUser.dart';
import 'package:bandhana/users/resetPassword.dart';
import 'package:bandhana/users/selectedProfile.dart';
import 'package:bandhana/users/suggestion.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:bandhana/users/profile.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bandhana/credentialCheck.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late String _storedValue;
  // String? _getStoredValue;
  void initState() {
    super.initState();
    _getStoredValue();
  }

  Future<void> _getStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('name')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_storedValue),
            accountEmail: Text('a@gmail.com'),
            currentAccountPicture: CircleAvatar(child: Text('D')),
          ),
          ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('बंधना (मुख्य पेज)'),
              trailing: Icon(Icons.next_plan),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('मेरी जानकारी (Profile) '),
              trailing: Icon(Icons.next_plan),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('पासवर्ड बदलें'),
              trailing: Icon(Icons.next_plan),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPassword(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('लिस्ट में नया कैंडिडटे प्रोफाइल जोड'),
              trailing: Icon(Icons.next_plan),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewUser(),
                  ),
                );
              }),
          // ListTile(
          //     leading: Icon(Icons.contact_mail),
          //     title: Text('मेरा फेवरेट'),
          //     trailing: Icon(Icons.next_plan),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => SelectedProfile(),
          //         ),
          //       );
          //     }),
          // ListTile(
          //     leading: Icon(Icons.contact_mail),
          //     title: Text('सुझाव'),
          //     trailing: Icon(Icons.next_plan),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Suggestion(),
          //         ),
          //       );
          //     }),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Logout'),
                trailing: Icon(Icons.next_plan),
                onTap: () async {
                  // Remove the token from shared preferences
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('name');
                  prefs.remove('email');

                  // Navigate to the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
