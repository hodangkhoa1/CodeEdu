import 'package:code_edu/AllWidgets/error_message_dialog.dart';
import 'package:flutter/material.dart';

void showDialogError(BuildContext context, String title, String description, String buttonText, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorMessageDialog(
          title: title,
          description: description,
          buttonText: buttonText,
          isDarkMode: isDarkMode,
        );
      }
    );
  }