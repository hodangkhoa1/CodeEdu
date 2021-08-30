import 'package:code_edu/Screens/to_do_app/components/to_do_widget.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key key
  }) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      bottom: 6
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value){
                              
                            },
                            decoration: InputDecoration(
                              hintText: "Enter task title",
                              border: InputBorder.none
                            ),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter description for the task...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                  ),
                  TodoWidget(
                    text: "Tomorrow learn code java",
                    isDone: false,
                  ),
                  TodoWidget(
                    text: "Tomorrow learn code flutter",
                    isDone: true,
                  ),
                  TodoWidget(
                    text: "Tomorrow learn code iot",
                    isDone: true,
                  ),
                  TodoWidget(
                    text: "Tomorrow learn code C",
                    isDone: false,
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFFE3577),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}