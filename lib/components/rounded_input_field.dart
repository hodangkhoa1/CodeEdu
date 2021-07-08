import 'package:code_edu/blocs/login_bloc.dart';
import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  //final LoginBloc userNameBloc;
  const RoundedInputField({
    Key key,
    @required this.hintText,
    this.icon = Icons.person,
    @required this.onChanged,
    this.controller,
    //@required this.userNameBloc,
    @required this.textInputType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserNameInputFieldState();
}

class _UserNameInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: StreamBuilder(
        //stream: widget.userNameBloc.getUserName,
        builder: (context, snapshot) => TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            icon: Icon(
              widget.icon,
            ),
            hintText: widget.hintText,
            errorText: snapshot.hasError ? snapshot.error : null,
            border: snapshot.hasError ? null : InputBorder.none,
          ),
        ),
      )
    );
  }
}
