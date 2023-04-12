import 'package:flutter/material.dart';
import 'package:kushneta/ProfilePages/userpreference/UserPreference.dart';

AppBar buildAppBar(BuildContext context) {
  // ignore: unused_local_variable
  final user = UserPreferences.getUser();


  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: const [],
  );
}
