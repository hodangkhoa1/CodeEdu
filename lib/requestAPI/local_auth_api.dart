import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static final _authFace = LocalAuthentication();

  static Future<bool> fingerHasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> faceHasBiometrics() async {
    try {
      return await _authFace.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> fingerAuthenticate() async {
    final isAvailable = await fingerHasBiometrics();
    if (!isAvailable) {
      return false;
    }

    try {
      // ignore: deprecated_member_use
      return await _auth.authenticateWithBiometrics(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch(e) {
      print(e);
      return false;
    }
  }

  static Future<bool> faceAuthenticate() async {
    final isAvailable = await faceHasBiometrics();
    if (!isAvailable) {
      return false;
    }

    try {
      // ignore: deprecated_member_use
      return await _authFace.authenticateWithBiometrics(
        androidAuthStrings: AndroidAuthMessages(
          signInTitle: 'Face ID Required',
        ),
        localizedReason: 'Scan Face to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch(e) {
      return false;
    }
  }
}