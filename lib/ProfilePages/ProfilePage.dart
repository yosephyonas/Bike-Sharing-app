// ignore_for_file: use_build_context_synchronously

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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage()),
                    );
                  },
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
                  onTap: () {
  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage()),
                    );                  },
                  icons: Icons.lock,
                  title: 'Change Password',
                  subtitle: 'Change your account password',
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    // Navigate to the notification settings page
                  },
                  icons: Icons.notifications,
                  title: 'Notification Settings',
                  subtitle: 'Customize your notification preferences',
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SendFeedbackPage()),
                    );
                  },
                  icons: Icons.feedback,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'Feedback',
                  subtitle: "Share your thoughts about the app",
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    // Show language selection dialog or navigate to language settings page
                  },
                  icons: Icons.language,
                  title: 'Language',
                  subtitle: 'Choose your preferred language',
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    // Show theme selection dialog or navigate to theme settings page
                  },
                  icons: Icons.color_lens,
                  title: 'Theme',
                  subtitle: 'Change the app theme',
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () => logout(context),
                  icons: Icons.exit_to_app_rounded,
                  title: "Log Out",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text(
              'Data Collection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
            const SizedBox(height: 16),
            Text(
              'Data Usage',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feedback',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            const Text(
              'We appreciate your feedback! Please let us know your thoughts, suggestions, or any issues you encountered while using our app.',
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Submit feedback logic goes here
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your current password:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              // Current password field
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Enter your new password:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              // New password field
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Submit the new password logic goes here
                Navigator.pop(context); // Close the change password page
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Selection'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              // Change the language logic for English
              changeLanguage('en');
              Navigator.pop(context); // Close the language selection page
            },
          ),
          ListTile(
            title: const Text('Spanish'),
            onTap: () {
              // Change the language logic for Spanish
              changeLanguage('es');
              Navigator.pop(context); // Close the language selection page
            },
          ),
          // Add more language options as needed
        ],
      ),
    );
  }

  void changeLanguage(String languageCode) {
    // Implement logic to change the language using your preferred localization package
    // For example, you can use the 'flutter_localizations' package
    // Set the new language as the app's locale
    // Example: AppLocalizationsDelegate().resolveSupportedLocale(languageCode),
  }
}
