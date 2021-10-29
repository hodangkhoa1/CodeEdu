import 'package:code_edu/model/theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController textEditingController;
  final Widget widget;
  final bool isDarkMode;
  final TextInputType keyboardType;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final Function(String) validator;
  final List<String> errors;
  final Color color;
  final bool enabled;
  final bool obscureText;

  const InputField({
    Key key,
    @required this.title,
    @required this.hint,
    @required this.isDarkMode,
    @required this.textEditingController,
    @required this.errors,
    @required this.obscureText,
    this.widget,
    this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.color,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: (textEditingController.text.trim().isNotEmpty || errors.isNotEmpty) ? color : Colors.grey,
                width: 1
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    enabled: enabled,
                    cursorColor: isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: textEditingController,
                    keyboardType: keyboardType,
                    onSaved: onSaved,
                    onChanged: onChanged,
                    validator: validator,
                    style: subTitleStyle,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                        )
                      )
                    ),
                  )
                ),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          )
        ],
      ),
    );
  }
}