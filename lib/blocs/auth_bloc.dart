import 'dart:async';

import 'package:code_edu/fire_base/fire_base_auth.dart';

class AuthBloc {
  var _email, _password;
  var _firAuth = FireAuth();

  StreamController _firstNameController = new StreamController();
  StreamController _lastNameController = new StreamController();
  StreamController _phoneNumberController = new StreamController();
  StreamController _addressController = new StreamController();

  Stream get firstNameStream => _firstNameController.stream;
  Stream get lastNameStream => _lastNameController.stream;
  Stream get phoneNumberStream => _phoneNumberController.stream;
  Stream get addressStream => _addressController.stream;

  // ignore: missing_return
  bool isProfileValid(String firstName, String lastName, int phoneNumber, String address) {
    if(firstName == null || firstName.length == 0) {
      _firstNameController.sink.addError("Please enter first name");
      return false;
    }
    _firstNameController.sink.add("");

    if(lastName == null || lastName.length == 0) {
      _lastNameController.sink.addError("Please enter last name");
      return false;
    }
    _lastNameController.sink.add("");

    if(phoneNumber == null || phoneNumber.bitLength == 0) {
      _phoneNumberController.sink.addError("Please enter phone number");
      return false;
    }
    _phoneNumberController.sink.add("");

    if(address == null || address.length == 0) {
      _addressController.sink.addError("Please enter address");
      return false;
    }
    _addressController.sink.add("");
  }

  void signUp(String email, String password){
    this._email = email;
    this._password = password;
  }

  void completeProfile(String firstName, String lastName, String phoneNumber, String address, Function onSuccess){
    _firAuth.signUp(_email, _password, firstName, lastName, phoneNumber, address, onSuccess);
  }

  void dispose(){
    _firstNameController.close();
    _lastNameController.close();
    _phoneNumberController.close();
    _addressController.close();
  }
}