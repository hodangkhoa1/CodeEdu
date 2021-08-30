import 'package:code_edu/requestAPI/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

// void loginFacebook(BuildContext context, String loginSuccessMessage, String loginCancelMessage, String loginErrorMessage) async {
//   final authService = AuthService();
//   final fb = FacebookLogin();

//   try {
//     final res = await fb.logIn(
//       permissions: [
//         FacebookPermission.publicProfile,
//         FacebookPermission.email
//       ]
//     );

//     switch(res.status){
//       case FacebookLoginStatus.success:
//         //Get Token
//         final FacebookAccessToken fbToken = res.accessToken;

//         //Convert to Auth Credential
//         final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);

//         //User Credential to Sign in with Firebase
//         final result = await authService.signInWithCredentail(credential);
//         if(result.user.uid.isNotEmpty) {
//           authService.currentUser.listen((facebookUser) {
//             if(facebookUser != null) {
//               print(facebookUser.email);
//               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(
//                 urlImage: facebookUser.photoURL,
//                 nameTextAppBar: facebookUser.displayName,
//                 emailGoogleLogin: facebookUser.email,
//               )), (Route<dynamic> route) => false);
//               displayToastMessage(context, loginSuccessMessage);
//             }
//           });
//         }
//         break;
//       case FacebookLoginStatus.cancel:
//         displayToastMessage(context, loginCancelMessage);
//         break;
//       case FacebookLoginStatus.error:
//         displayToastMessage(context, loginErrorMessage);
//         break;
//     }
//   } catch (e) {
//     print(e);
//   }
// }

class AuthBlocFacebook {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;

  loginFacebook() async {
    print('Starting Facebook Login');

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
      final result = await authService.signInWithCredentail(credential);

      print('${result.user.displayName} is now logged in');

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