// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:kushneta/LoginPage/SignIn.dart';
import 'package:kushneta/ProfilePages/EditProfile/EditProfilePage.dart';
import 'package:kushneta/ProfilePages/SendFeedbackPage.dart';
import 'package:kushneta/ProfilePages/userpreference/UserPreference.dart';
import 'package:kushneta/ProfilePages/widget/ProfileWidget.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    final user = UserPreferences.getUser();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
    appBar: AppBar(
    title: const Text(
    "Settings",
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    ),
    body: Padding(
    padding: const EdgeInsets.all(10),
    child: ListView(
    children: [
    // user card
    ProfileWidget(
    imagePath: user.imagePath,
    onClicked: () async {
    await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
    setState(() {});
    },
    ),
    Text(
    user.name,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
    const SizedBox(height: 4),
    Text(
    user.email,
    style: const TextStyle(color: Colors.grey),
    ),
    SettingsGroup(
    items: [
    SettingsItem(
    onTap: () {},
    icons: Icons.fingerprint,
    iconStyle: IconStyle(
    iconsColor: Colors.white,
    withBackground: true,
    backgroundColor: Colors.red,
    ),
    title: 'Privacy',
    subtitle: "Lock Ziar'App to improve your privacy",
    ),
    ],
    ),
    SettingsGroup(
    items: [
    SettingsItem(
    onTap: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SendFeedbackPage()),
    );
    },
    icons: Icons.feedback,
    iconStyle: IconStyle(
    backgroundColor: Colors.purple,
    ),
    title: 'Feedback',
    subtitle: "Share us your thought about the app",
    ),
    ],
    ),
    // You can add a settings title
    SettingsGroup(
    items: [
    SettingsItem(
    onTap: () {
    logout(context);
    },
    icons: Icons.exit_to_app_rounded,
    title: "Log Out",
    ),
    ],
    ),
    ],
    ),
    ),
        ),
    );
  }
}
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignIn()));
}