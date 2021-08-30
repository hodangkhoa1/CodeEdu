final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String emailNullError = "Please enter your email";
const String invalidEmailError = "Please enter valid email";
const String passwordNullError = "Please enter your password";
const String shortPasswordError = "Password is too weak";
const String matchPasswordError = "Password does not match";
const String nameUserNullError = "Please enter your Username";
const String phoneNumberNullError = "Please enter your phone number";
const String shortUserNameError = "Please enter Username larger than 5";
const String shortPhoneNumberError = "Please enter 10 numbers";
const String confirmPasswordError = "Please confirm password";

class Validations {
  static bool isValidEmail(String email){
    return email != null && emailValidatorRegExp.hasMatch(email);
  }

  static bool isStrongPassword(String password, [int minLength = 8]){
    if(password == null || password.length < minLength){
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    if(hasUppercase){
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      if(hasDigits){
        bool hasLowercase = password.contains(RegExp(r'[a-z]'));
        if(hasLowercase){
          bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
          return hasSpecialCharacters;
        }
      }
    }

    return false;
  }

  static bool isConfirmPassword(String password, String confirmPassword){
    if(password == confirmPassword){
      return true;
    }
    return false;
  }
}