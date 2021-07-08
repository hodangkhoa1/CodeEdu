import 'package:code_edu/Screens/Login/components/body.dart';
import 'package:code_edu/blocs/auth_bloc_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthGoogleBloc(),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
