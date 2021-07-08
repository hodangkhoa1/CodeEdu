import 'package:code_edu/requestAPI/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthBloc {
  final authService = AuthService();
  final facebook = FacebookLogin();

  Stream<FirebaseUser> get currentUser => authService.currentUser;

  loginFacebook() async {
    print("Thành công");

    final result = await facebook.logIn(["email", "public_profile", "user_friends"]);
    print(result.errorMessage);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("The user cancel the login");
        break;
      case FacebookLoginStatus.error:
        print("There was an error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Thành công login");
        break;
    }
  }
}
