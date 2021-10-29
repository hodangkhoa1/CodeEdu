import 'package:code_edu/Screens/create_note_page/components/body.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({
    Key key
  }) : super(key: key);

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}