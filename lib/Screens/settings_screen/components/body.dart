import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/cupertino.dart';
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        top: 25,
        right: 16,
      ),
      child: ListView(
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          SizedBox(height: 10),
          BuildAccountOption(
            text: "Change Password",
            onTap: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 15),
                              buildOldPasswordField(),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                );
              });
            },
          ),
          BuildAccountOption(
            text: "Language",
            onTap: (){
              setState(() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Choose Language",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                );
              });
            },
          ),
          BuildAccountOption(
            text: "Privacy and security",
            onTap: (){},
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Icon(
                Icons.volume_up_outlined,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          SizedBox(height: 10),
          BuildNotificationOption(
            title: "Notification for you",
            isActive: true,
          ),
          BuildNotificationOption(
            title: "New for you",
            isActive: true,
          ),
        ],
      ),
    );
  }

  Padding buildOldPasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFieldContainer(
        color: Colors.grey,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Old Password",
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildNotificationOption extends StatelessWidget {
  final String title;
  final bool isActive;
  
  const BuildNotificationOption({
    Key key,
    @required this.title,
    @required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool balue) {}
          ),
        ),
      ],
    );
  }
}

class BuildAccountOption extends StatelessWidget {
  final String text;
  final Function onTap;

  const BuildAccountOption({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}