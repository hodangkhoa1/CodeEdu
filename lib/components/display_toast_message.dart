import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

displayToastMessage(BuildContext context, String message) {
  Fluttertoast.showToast(msg: message);
}