
// import 'dart:async';

// import 'package:code_edu/validators/reg_validator.dart';

// class LoginBloc {
//   StreamController _userNameController = new StreamController();
//   StreamController _passWordController = new StreamController();
//   StreamController _confirmPasswordController = new StreamController();

//   Stream get getUserName => _userNameController.stream;
//   Stream get getPassword => _passWordController.stream;
//   Stream get getConfirmPassword => _confirmPasswordController.stream;

//   bool isValidLogin(String userName, String passWord){
//     if(!Validations.isValidUser(userName)){
//       _userNameController.sink.addError("This account is Invalid");
//       return false;
//     }
//     _userNameController.sink.add("OK");
//     if(!Validations.isPassword(passWord)){
//       _passWordController.sink.addError("Password must be more than 6 characters");
//       return false;
//     }
//     _passWordController.sink.add("OK");
//     return true;
//   }

//   bool isValidSignUp(String userName, String passWord, String confirmPassword){
//     if(!Validations.isValidUser(userName)){
//       _userNameController.sink.addError("This account is Invalid");
//       return false;
//     }
//     _userNameController.sink.add("OK");
//     if(!Validations.isPassword(passWord)){
//       _passWordController.sink.addError("Password must be more than 6 characters");
//       return false;
//     }
//     _passWordController.sink.add("OK");
//     // ignore: unrelated_type_equality_checks
//     if(passWord != confirmPassword){
//       _confirmPasswordController.sink.addError("Password does not match");
//       return false;
//     }
//     _confirmPasswordController.sink.add("OK");
//     return true;
//   }

//   void dispose(){
//     _userNameController.close();
//     _passWordController.close();
//     _confirmPasswordController.close();
//   }
// }