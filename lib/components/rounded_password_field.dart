import 'package:code_edu/blocs/login_bloc.dart';
import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  //final LoginBloc passwordBloc;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key key,
    @required this.onChanged,
    @required this.controller,
    //@required this.passwordBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowPasswordFieldState();
}

class _ShowPasswordFieldState extends State<RoundedPasswordField> {
  bool _activeShowPass = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: StreamBuilder(
        //stream: widget.passwordBloc.getPassword,
        builder: (context, snapshot) => TextField(
          obscureText: !_activeShowPass,
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              // color: kPrimaryColor,
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
