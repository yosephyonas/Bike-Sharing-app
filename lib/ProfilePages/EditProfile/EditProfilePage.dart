// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kushneta/ProfilePages/userpreference/UserPreference.dart';
import 'package:kushneta/ProfilePages/widget/AppBar.dart';
import 'package:kushneta/ProfilePages/widget/BottonWidget.dart';
import 'package:kushneta/ProfilePages/widget/ProfileWidget.dart';
import 'package:kushneta/ProfilePages/widget/TextFieldWidget.dart';
import 'package:kushneta/UserModel/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => (
      Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
                onClicked: () async {
                  final image = await ImagePicker()
                      .getImage(source: ImageSource.gallery);

                  if (image == null) return;

                  final directory = await getApplicationDocumentsDirectory();
                  final name = basename(image.path);
                  final imageFile = File('${directory.path}/$name');
                  final newImage =
                  await File(image.path).copy(imageFile.path);

                  setState(() => user = user.copy(imagePath: newImage.path));
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: user.name,
                onChanged: (name) => user = user.copy(name: name),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) => user = user.copy(email: email),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Save',
                onClicked: () {
                  UserPreferences.setUser(user);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      )
  );
}