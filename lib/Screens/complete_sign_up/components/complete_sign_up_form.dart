import 'package:code_edu/Screens/Login/components/body.dart';
import 'package:code_edu/blocs/auth_bloc.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:code_edu/Screens/otp/otp_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc = new AuthBloc();
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  final List<String> fisrtNameErrors = [];
  final List<String> lastNameErrors = [];
  final List<String> phoneNumberErrors = [];
  final List<String> addressErrors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 70),
          TextFormField(
            onSaved: (newValue) => firstName = newValue,
            onChanged: (value) {
              if(value.isNotEmpty && fisrtNameErrors.contains(firstNameNullError)){
                setState(() {
                  fisrtNameErrors.remove(firstNameNullError);
                });
              }
              firstName = value;
              return null;
            },
            validator: (value) {
              if(value.isEmpty && !fisrtNameErrors.contains(firstNameNullError)) {
                setState(() {
                  fisrtNameErrors.add(firstNameNullError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(
                    color: fisrtNameErrors.contains(firstNameNullError) ? Colors.red : Color(0xFF8B8B8B),
                  ),
                  gapPadding: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 10),
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: SvgPicture.asset(
                  "assets/icons/User.svg", 
                  height: 18, 
                  color: fisrtNameErrors.contains(firstNameNullError) ? Colors.red : Color(0xFF8B8B8B),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          FormError(errors: fisrtNameErrors),
          SizedBox(height: size.height * 0.01),
          TextFormField(
            onSaved: (newValue) => lastName = newValue,
            onChanged: (value) {
              if(value.isNotEmpty && lastNameErrors.contains(lastNameNullError)){
                setState(() {
                  lastNameErrors.remove(lastNameNullError);
                });
              }
              lastName = value;
              return null;
            },
            validator: (value) {
              if(value.isEmpty && !lastNameErrors.contains(lastNameNullError)) {
                setState(() {
                  lastNameErrors.add(lastNameNullError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Last Name",
              hintText: "Enter your last name",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: lastNameErrors.contains(lastNameNullError) ? Colors.red : Color(0xFF8B8B8B)),
                  gapPadding: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 10),
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: SvgPicture.asset(
                  "assets/icons/User.svg",
                  height: 18,
                  color: lastNameErrors.contains(lastNameNullError) ? Colors.red : Color(0xFF8B8B8B),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          FormError(errors: lastNameErrors),
          SizedBox(height: size.height * 0.01),
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phoneNumber = newValue,
            onChanged: (value) {
              if(value.isNotEmpty && phoneNumberErrors.contains(phoneNumberNullError)){
                setState(() {
                  phoneNumberErrors.remove(phoneNumberNullError);
                });
              }
              phoneNumber = value;
              return null;
            },
            validator: (value) {
              if(value.isEmpty && !phoneNumberErrors.contains(phoneNumberNullError)){
                setState(() {
                  phoneNumberErrors.add(phoneNumberNullError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: phoneNumberErrors.contains(phoneNumberNullError) ? Colors.red : Color(0xFF8B8B8B)),
                  gapPadding: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 10),
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: SvgPicture.asset(
                  "assets/icons/Phone.svg",
                  height: 18,
                  color: phoneNumberErrors.contains(phoneNumberNullError) ? Colors.red : Color(0xFF8B8B8B)
                ),
              )
            ),
          ),
          SizedBox(height: size.height * 0.01),
          FormError(errors: phoneNumberErrors),
          SizedBox(height: size.height * 0.01),
          TextFormField(
            onSaved: (newValue) => address = newValue,
            onChanged: (value) {
              if(value.isNotEmpty && addressErrors.contains(addressNullError)){
                setState(() {
                  addressErrors.remove(addressNullError);
                });
              }
              address = value;
              return null;
            },
            validator: (value) {
              if(value.isEmpty && !addressErrors.contains(addressNullError)){
                setState(() {
                  addressErrors.add(addressNullError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Address",
              hintText: "Enter your address",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: addressErrors.contains(addressNullError) ? Colors.red : Color(0xFF8B8B8B)),
                  gapPadding: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 10),
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: SvgPicture.asset(
                  "assets/icons/Location point.svg",
                  height: 18,
                  color: addressErrors.contains(addressNullError) ? Colors.red : Color(0xFF8B8B8B)
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          FormError(errors: addressErrors),
          SizedBox(height: size.height * 0.02),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.blue,
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    if(fisrtNameErrors.isEmpty && lastNameErrors.isEmpty && phoneNumberErrors.isEmpty && addressErrors.isEmpty){
                      authBloc.completeProfile(firstName, lastName, phoneNumber, address, (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
                    }
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            "By continuing your confirm that you agree \nwith our Term and Condition",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }
}