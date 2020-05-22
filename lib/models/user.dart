import 'dart:convert' as convert;

import 'package:bewolf/utils/prefs.dart';

class User {
  String login;
  String name;
  String email;

  User(
      {this.login,
        this.name,
        this.email});

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);

    Prefs.setString("user.prefs", json);
  }

  static Future<User> get() async {
    String json = await Prefs.getString("user.prefs");
    if (json.isEmpty) {
      return null;
    }
    Map map = convert.json.decode(json);
    User user = User.fromJson(map);
    return user;
  }

  @override
  String toString() {
    return 'User{login: $login, name: $name}';
  }
}
