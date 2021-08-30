import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';

TextFieldContainer buildPasswordFormField(BuildContext context, String language, List<String> checkErrors, String checkNullError, String pleaseEnterField, TextEditingController passwordTextEditingController, bool obscureText, String password, Function(String) onChanged, Function(String) validator, String yourPassword, Function onToggleShowPass, bool activeShowPass) {
    return TextFieldContainer(
      color: (language == "English" ? checkErrors.contains(checkNullError) : checkErrors.contains(pleaseEnterField)) ? Colors.red : Colors.blue,
      child: TextFormField(
        controller: passwordTextEditingController,
        obscureText: obscureText,
        onSaved: (newValue) => password = newValue,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          hintText: yourPassword,
          icon: Icon(
            Icons.lock,
            color: (language == "English" ? checkErrors.contains(checkNullError) : checkErrors.contains(pleaseEnterField)) ? Colors.red : Colors.blue,
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: onToggleShowPass,
            child: Icon(
              activeShowPass ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }