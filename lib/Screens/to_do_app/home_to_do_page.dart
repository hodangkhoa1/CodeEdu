import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:code_edu/Screens/to_do_app/components/body.dart';
import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({
    Key key
  }) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
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
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => HomeScreen(),
              // ));
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Todoo",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
      body: Body(),
    );
  }
}