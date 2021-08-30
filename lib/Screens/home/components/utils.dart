import 'package:flutter/material.dart';

class Command {
  static final all = [search];

  static const search = 'search';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if(text.contains(Command.search)) {
      final body = _getTextAfterCommand(
        text: text,
        command: Command.search
      );

      copyValue(body: body);
    }
  }

  static String _getTextAfterCommand({
    @required String text,
    @required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if(indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future copyValue({
    @required String body,
  }) async {
    final value = Uri.encodeFull(body);
    return value;
  }
}