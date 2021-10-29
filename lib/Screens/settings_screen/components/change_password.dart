import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key key
  }) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  TextEditingController oldPasswordTextEditingController;
  TextEditingController newPasswordTextEditingController;
  TextEditingController retypePasswordTextEditingController;
  final List<String> oldPasswordTextErrors = [];
  final List<String> newPasswordTextErrors = [];
  final List<String> retypePasswordTextErrors = [];

  @override
  void initState() {
    oldPasswordTextEditingController = TextEditingController();
    newPasswordTextEditingController = TextEditingController();
    retypePasswordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordTextEditingController.dispose();
    newPasswordTextEditingController.dispose();
    retypePasswordTextEditingController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Change Password",
          style: TextStyle(
            fontSize: 20
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              title: "Old Password",
              hint: "Please enter old password.",
              isDarkMode: isDarkMode,
              textEditingController: oldPasswordTextEditingController,
              errors: oldPasswordTextErrors,
              obscureText: false,
              widget: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: 25,
                    color: Colors.grey,
                  )
                ),
              ),
            ),
            InputField(
              title: "New Password",
              hint: "Please enter new password.",
              isDarkMode: isDarkMode,
              textEditingController: newPasswordTextEditingController,
              errors: newPasswordTextErrors,
              obscureText: false,
              widget: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: 25,
                    color: Colors.grey,
                  )
                ),
              ),
            ),
            InputField(
              title: "Retype Password",
              hint: "Please enter retype password.",
              isDarkMode: isDarkMode,
              textEditingController: retypePasswordTextEditingController,
              errors: retypePasswordTextErrors,
              obscureText: false,
              widget: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: 25,
                    color: Colors.grey,
                  )
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Color(0xFF313131),
                onPressed: (){},
                child: Text(
                  "SAVE"
                )
              ),
            )
          ],
        ),
      )
    );
  }
}