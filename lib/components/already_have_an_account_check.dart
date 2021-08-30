import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? AppLocalizations.of(context).doNotHaveAnAccount : AppLocalizations.of(context).alreadyHaveAnAccount,
          style: TextStyle(color: Color(0xFF8B8B8B)),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? AppLocalizations.of(context).signUp : AppLocalizations.of(context).login,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}