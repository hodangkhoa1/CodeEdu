import 'package:code_edu/requestAPI/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogleBloc {
  final authService = AuthService();
  final googleSignin = GoogleSignIn(scopes: ['email']);

  Stream<FirebaseUser> get currentUser => authService.currentUser;

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, 
        accessToken: googleAuth.accessToken
      );

      //Firebase Sign in
      final result = await authService.signInWithCredentail(credential);
      print('${result.user.email}');
    } catch (e) {
      print(e);
    }
  }

  logout(){
    authService.logout();
  }
}