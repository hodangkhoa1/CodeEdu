import 'package:code_edu/Screens/settings_screen/components/icon_widget.dart';
import 'package:code_edu/components/language_picker_widget.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AccountPage extends StatelessWidget {
  static const keyLanguage = 'key-language';
  static const keyPassword = 'key-password';

  const AccountPage({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Account Settings",
      subtitle: "Privacy, Security, Language",
      leading: IconWidget(
        icon: Icons.person,
        color: Colors.green,
      ),
      child: SettingsScreen(
        title: "Account Settings",
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Language",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                LanguagePickerWidget(),
              ],
            ),
          ),
          TextInputSettingsTile(
            title: 'Change Password',
            settingKey: keyPassword,
            obscureText: true,
            validator: (password) => password != null && Validations.isStrongPassword(password) ? null : 'Please enter strong password',
          ),
          SimpleSettingsTile(
            title: "Account Info",
            subtitle: '',
            leading: IconWidget(
              color: Colors.purple,
              icon: Icons.text_snippet,
            ),
            onTap: (){},
          ),
          const SizedBox(height: 10),
          SimpleSettingsTile(
            title: "Security",
            subtitle: '',
            leading: IconWidget(
              color: Colors.red,
              icon: Icons.security,
            ),
            onTap: (){},
          ),
          const SizedBox(height: 10),
          SimpleSettingsTile(
            title: "Privacy",
            subtitle: '',
            leading: IconWidget(
              color: Colors.blue,
              icon: Icons.lock,
            ),
            onTap: (){},
          ),
        ]
      ),
    );
  }
}