import 'package:bandhana/users/full_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import 'package:bandhana/common_files/api.dart';

class Profile {
  String? name,
      email,
      mobile_no,
      gender,
      state,
      city,
      village,
      dob,
      father_name,
      father_profession,
      mother_name,
      mother_profession,
      mother_village,
      asset,
      height,
      color,
      education,
      sibling,
      gotra,
      permanent_address,
      img;
  int id = 0;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        mobile_no: json['mobile_no'],
        gender: json['gender'],
        state: json['state'],
        city: json['city'],
        village: json['village'],
        dob: json['dob'],
        father_name: json['father_name'],
        father_profession: json['father_profession'],
        mother_name: json['mother_name'],
        mother_profession: json['mother_profession'],
        mother_village: json['mother_village'],
        asset: json['asset'],
        height: json['height'],
        color: json['color'],
        education: json['education'],
        sibling: json['sibling'],
        gotra: json['gotra'],
        permanent_address: json['permanent_address'],
        img: json['img']);
  }

  Profile(
      {required this.id,
      this.name,
      this.email,
      this.mobile_no,
      this.gender,
      this.state,
      this.city,
      this.village,
      this.dob,
      this.father_name,
      this.father_profession,
      this.mother_name,
      this.mother_profession,
      this.mother_village,
      this.asset,
      this.height,
      this.color,
      this.education,
      this.sibling,
      this.gotra,
      this.permanent_address,
      this.img});
}

class Girls extends StatefulWidget {
  @override
  State<Girls> createState() => _GirlsState();
}

class _GirlsState extends State<Girls> {
  List<dynamic> profiles = [];
  late String token;
  @override
  void initState() {
    super.initState();
    _getStoredToken();
  }

  Future<void> _getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
    });
    var url = Uri.parse('${api.baseUrl}profileList?gender=female');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseJson = json.decode(response.body);

    if (responseJson['result'] == 'success') {
      setState(() {
        // profiles = responseJson['data'];
        profiles = (responseJson['data'] as List<dynamic>)
            .map((item) => Profile.fromJson(item))
            .toList();
      });
    }
    print('working now $profiles');
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return profiles == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: profiles.map((profile) {
                  counter++;
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: Text("$counter"),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: profile.img != null
                                ? DecorationImage(
                                    image: NetworkImage(profile.img),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: AssetImage('female.png'),
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 10),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text('नाम : ' + profile.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              Text('जन्मतिथि :' + profile.dob.toString(),
                                  style: TextStyle(fontSize: 13)),
                              Text('ग्राम : ' + profile.village.toString(),
                                  style: TextStyle(fontSize: 13)),
                              Text('शिक्षा : ' + profile.education.toString(),
                                  style: TextStyle(fontSize: 13)),
                              Text('गोत्र : ' + profile.gotra.toString(),
                                  style: TextStyle(fontSize: 13)),
                              ElevatedButton(
                                onPressed: () {
                                  showProfile(profile.id);
                                },
                                child: Text('पूर्ण परिचय '),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }

  Future<void> showProfile(profileID) async {
    var url = Uri.parse('${api.baseUrl}fullProfile/$profileID');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var profileData = jsonDecode(response.body);
    var profileMainData = profileData['data'];
    print('mydata1 $profileData');
    if (profileData['result'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullProfile(profileMainData: profileMainData),
        ),
      );
    } else {
      print('notify' + profileData);
    }
  }
}
