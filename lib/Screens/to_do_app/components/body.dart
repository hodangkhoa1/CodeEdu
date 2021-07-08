import 'package:code_edu/Screens/to_do_app/components/widget.dart';
import 'package:code_edu/Screens/to_do_app/components/task_page.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({
    Key key
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => showBottomPopup(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32
        ),
        color: Color(0xFFF6F6F6),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Image(
                    image: AssetImage("assets/images/icon-app.png"),
                    width: 60,
                    height: 60,
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowBehaviour(),
                    child: ListView(
                      children: [
                        TaskCardWidget(
                          title: "Get Started!",
                          desc: "Hello Khoa! Welcome to Todoo, this is a default task that you can edit or delete to start using the app.",
                        ),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskPage(),
                    )
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF7349FE),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  void showBottomPopup(BuildContext context) async{
    showGeneralDialog(
      barrierLabel: "Todoo",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 305,
            margin: EdgeInsets.only(
              bottom: 50,
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40)
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Image(
                        image: AssetImage("assets/images/icon-app.png"),
                        width: 60,
                        height: 60,
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "What Todoo!",
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "What todoo, is a app to list your \ntask and to check when finished.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: RoundeButton(
                      text: "Get Started",
                      press: () => Navigator.of(context).pop(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}