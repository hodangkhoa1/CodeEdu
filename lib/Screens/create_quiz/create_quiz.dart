import 'package:code_edu/Screens/create_quiz/components/body.dart';
import 'package:flutter/material.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({
    Key key
  }) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiz",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey
              ),
            ),
            Text(
              "Maker",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue
              ),
            )
          ],
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