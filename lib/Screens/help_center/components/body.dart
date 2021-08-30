import 'package:bubble/bubble.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({
    Key key
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => showBottomPopup(context));
  }

  final messageController = TextEditingController();
  // ignore: deprecated_member_use
  List<Map> messages = List();
  // void response(query) async {
  //   AuthGoogle authGoogle = await AuthGoogle(
  //     fileJson: "assets/service/eloquent-hour-319919-0d112c009154.json"
  //   ).build();
  //   Dialogflow dialogflow = Dialogflow(
  //     authGoogle: authGoogle,
  //     language: Language.english,
  //   );
  //   print(dialogflow.toString());
  //   AIResponse aiResponse = await dialogflow.detectIntent("Hi!!!");
  //   print(aiResponse.getMessage());
  //   setState(() {
  //     messages.insert(
  //       0,
  //       {
  //         "data" : 0,
  //         "messages" : aiResponse.getListMessage()[0]["text"]["text"][0].toString()
  //       }
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Today, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return chat(
                  messages[index]["messages"].toString(),
                  messages[index]["data"]
                );
              }
            )
          ),
          Divider(
            height: 5,
            color: Colors.grey[400],
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Row(
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.blue,
                    size: 26,
                  )
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    FontAwesomeIcons.solidImage,
                    color: Colors.blue,
                    size: 26,
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    FontAwesomeIcons.microphone,
                    color: Colors.blue,
                    size: 26,
                  ),
                ),
                Container(
                  height: 40,
                  width: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: isDarkMode ? Color(0xFF313131) : Colors.grey[200],
                    border: Border.all(
                      color: isDarkMode ? Colors.grey : Colors.transparent
                    )
                  ),
                  padding: EdgeInsets.only(left: 15, top: 18),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.grey : Colors.black26
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.grey : Colors.black
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    if(messageController.text.isNotEmpty) {
                      setState(() {
                        messages.insert(0, {
                          "data" : 1,
                          "message" : messageController.text
                        });
                      });
                      //response(messageController.text);
                      messageController.clear();
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    size: 30,
                    color: Colors.blue,
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showBottomPopup(BuildContext context) async {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    
    showGeneralDialog(
      barrierLabel: "CodeEdu Bot",
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
              color: isDarkMode ? Color(0xFF202020) : Colors.white,
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
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "CodeEdu Bot",
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Hello. My name is CodeEdu bot.\nCan I help you ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                        height: 1.5
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: RoundeButton(
                      color: isDarkMode ? Color(0xFF313131) : Colors.blue,
                      text: "Get Started",
                      press: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0 ? Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/robot.jpg"),
            ),
          ) : Container(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Bubble(
              radius: Radius.circular(15),
              color: data == 0 ? Color.fromRGBO(23, 157, 139, 1) : Colors.orangeAccent,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 200
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          data == 0 ? Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/default.jpg"),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}