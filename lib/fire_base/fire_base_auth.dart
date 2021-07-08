import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class FireAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  // FirebaseUser fbUser;

  void signUp(String email, String password, String firstName, String lastName, String phoneNumber, String address, Function onSuccess) {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((user){
      _createUser(user.user.uid, firstName, lastName, phoneNumber, address, onSuccess);
    }).catchError((error) {
      // Hàm này dùng để Handel lỗi
    });
  }

  _createUser(String userId, String firstName, String lastName, String phoneNumber, String address, Function onSuccess){
    var user = {
      "firstName" : firstName,
      "lastName" : lastName,
      "phoneNumber" : phoneNumber,
      "address" : address
    };
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user){
      onSuccess();
    }).catchError((err){

    });
  }

  Future loginFacebook() async {
    final FacebookLoginResult result = await _facebookLogin.logIn(["email"]);
    final String token = result.accessToken.token;
    final response = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    final profile = jsonDecode(response.body);
    print(profile);
    return profile;
  }
  
  // Future _handleLogin() async {
  //   FacebookLoginResult _result = await _facebookLogin.logIn(['email']);
  //   switch(_result.status) {
  //     case FacebookLoginStatus.cancelledByUser:
  //       print("CancelledByUser");
  //       break;
  //     case FacebookLoginStatus.error:
  //       print("Error");
  //       break;
  //     case FacebookLoginStatus.loggedIn:
  //       await _loginWithFacebook(_result);
  //       break;
  //   }
  // }

  // Future _loginWithFacebook(FacebookLoginResult _result) async {
  //   FacebookAccessToken _accessToken = _result.accessToken;
  //   AuthCredential _credential = FacebookAuthProvider.getCredential(accessToken: _accessToken.token);
  //   fbUser = (await _firebaseAuth.signInWithCredential(_credential)).user;
  // }
}