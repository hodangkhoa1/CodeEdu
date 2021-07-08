import 'package:code_edu/Screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget{

  @override
  final Size preferredSize;

  BuildAppBar({
    @required double height,
    Key key,
  }) : preferredSize = Size.fromHeight(height), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Programming C",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
      ),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () async {
            await _asyncConfirmDialog(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
          )
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange,
              Colors.purple
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}

enum ConfirmAction { Cancel, Accept}  
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {  
  return showDialog<ConfirmAction>(  
    context: context,  
    barrierDismissible: false,
    builder: (BuildContext context) {  
      return AlertDialog(  
        title: Text('Exit the Quiz'),
        content: const Text('Do you want to exit?'),  
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: const Text('Cancel'),  
            onPressed: () {  
              Navigator.of(context).pop(ConfirmAction.Cancel);  
            },  
          ),  
          // ignore: deprecated_member_use
          FlatButton(  
            child: const Text('OK'),  
            onPressed: () {  
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },  
          )  
        ],  
      );  
    },  
  );  
}  