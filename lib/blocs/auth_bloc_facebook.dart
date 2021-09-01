import 'package:code_edu/requestAPI/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBlocFacebook {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;

  loginFacebook() async {
    final res = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]
    );

    switch(res.status){
      case FacebookLoginStatus.success:
      print('It worked');

      //Get Token
      final FacebookAccessToken fbToken = res.accessToken;

      //Convert to Auth Credential
      final AuthCredential credential 
        = FacebookAuthProvider.credential(fbToken.token);

      //User Credential to Sign in with Firebase
      await authService.signInWithCredentail(credential);

      break;
      case FacebookLoginStatus.cancel:
      print('The user canceled the login');
      break;
      case FacebookLoginStatus.error:
      print('There was an error');
      break;
    }
  }

  logout(){
    authService.logout();
  }
}