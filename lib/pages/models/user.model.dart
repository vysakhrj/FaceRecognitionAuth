import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String user;
  String id;
  String role;
  String mobile;

  User({@required this.user, @required this.id, this.mobile, this.role});

  static Future<User> fromDB(String dbuserId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> data = pref.getStringList(dbuserId);
    print(data);
    return new User(
        user: data[0] ?? "",
        id: dbuserId,
        mobile: data[1] ?? "",
        role: data[2] ?? "");
  }
}
