import 'package:code_edu/Screens/software_information/components/body.dart';
import 'package:flutter/material.dart';

class SoftwareInformation extends StatefulWidget {
  static String routeName = "/softwareInformation";

  const SoftwareInformation({
    Key key
  }) : super(key: key);

  @override
  _SoftwareInformationState createState() => _SoftwareInformationState();
}

class _SoftwareInformationState extends State<SoftwareInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Software Information",
          style: TextStyle(
            fontSize: 20
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ),
      body: Body(),
    );
  }
}