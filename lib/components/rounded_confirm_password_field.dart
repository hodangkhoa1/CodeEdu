import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedConfirmPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  // final LoginBloc confirmPasswordBloc;
  final TextEditingController controller;

  const RoundedConfirmPasswordField({
    Key key,
    @required this.onChanged,
    @required this.controller,
    // @required this.confirmPasswordBloc,
  }) : super(key: key);

  @override
  _RoundedConfirmPasswordFieldState createState() => _RoundedConfirmPasswordFieldState();
}

class _RoundedConfirmPasswordFieldState extends State<RoundedConfirmPasswordField> {
  bool _activeShowPass = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: StreamBuilder(
        //stream: widget.confirmPasswordBloc.getConfirmPassword,
        builder: (context, snapshot) => TextField(
          obscureText: !_activeShowPass,
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: "Confirm password",
            icon: Icon(
              Icons.lock,
            ),
            suffixIcon: GestureDetector(
              onTap: onToggleShowPass,
              child: Icon(
                _activeShowPass ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            border: snapshot.hasError ? null : InputBorder.none,
            errorText: snapshot.hasError ? snapshot.error : null,
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _activeShowPass = !_activeShowPass;
    });
  }
}