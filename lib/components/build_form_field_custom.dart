import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';

TextFieldContainer buildFormFieldCustom(List<String> errors, FocusNode focusNode, int minLines, int maxLines, TextEditingController textEditingController, BorderRadiusGeometry borderRadius,
    Color color, TextInputType keyboardType, bool obscureText, String value, Function(String) onChanged, Function(String) validator, String hintText, IconData icon,
    Color iconColor, Widget suffixIcon) {
  return TextFieldContainer(
    errors: errors,
    textEditingController: textEditingController,
    borderRadius: borderRadius,
    color: color,
    child: TextFormField(
      focusNode: focusNode,
      minLines: minLines,
      maxLines: maxLines,
      controller: textEditingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: (newValue) => value = newValue,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        icon: Icon(
          icon,
          color: (textEditingController.text.trim().isNotEmpty || errors.isNotEmpty) ? iconColor : Colors.grey,
        ),
        border: InputBorder.none,
        suffixIcon: suffixIcon,
      ),
    ),
  );
}