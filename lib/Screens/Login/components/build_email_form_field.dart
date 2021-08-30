import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';

TextFieldContainer buildEmailFormField(BuildContext context, String language, List<String> emailErrors, String emailNullError, String pleaseEnterYourEmail, TextEditingController emailTextEditingController, String email, Function(String) onChanged, Function(String) validator, String hintText) {
    return TextFieldContainer(
      color: (language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(pleaseEnterYourEmail)) ? Colors.red : Colors.blue,
      child: TextFormField(
        controller: emailTextEditingController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.email_outlined,
            color: (language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(pleaseEnterYourEmail)) ? Colors.red : Colors.blue,
          ),
          border: InputBorder.none
        ),
      ),
    );
  }