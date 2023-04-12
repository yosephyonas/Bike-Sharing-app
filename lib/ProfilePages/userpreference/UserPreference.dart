import 'dart:convert';

import 'package:kushneta/UserModel/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {
  static late SharedPreferences preferences;

  static const keyUser = 'user';
  static const myUser = User(
    imagePath:
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
    'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',

  );

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await preferences.setString(keyUser, json);
  }

  static User getUser() {
    final json = preferences.getString(keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}