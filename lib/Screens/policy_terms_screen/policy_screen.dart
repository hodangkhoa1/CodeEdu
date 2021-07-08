import 'package:code_edu/Screens/policy_terms_screen/components/body.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({
    Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Policy and terms",
          style: TextStyle(
            fontSize: 20
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
      ),
      body: Body(),
    );
  }
}