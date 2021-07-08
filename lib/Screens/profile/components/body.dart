import 'dart:io';
import 'package:code_edu/Screens/profile/components/profile_pic.dart';
import 'package:code_edu/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool hide = false;

  File _pickedFile;
  //final ImagePicker _imagePicker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      _pickedFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              SizedBox(height: 35),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    ProfilePic(
                      hide: hide,
                      avatarImage: _pickedFile,
                      onPressedCamera: (){
                        setState(() {
                          takePhoto(ImageSource.camera);
                        });
                      },
                      onPressedGallery: (){
                        setState(() {
                          takePhoto(ImageSource.gallery);
                        });
                      },
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Khoa Ho Dang",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueAccent
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "0918110701",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              hide = !hide;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ProfileCategories(
                isActive: hide,
              ),
              SizedBox(height: 30),
              // ignore: deprecated_member_use
              OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                onPressed: (){},
                child: Text(
                  "SIGN OUT",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCategories extends StatelessWidget {
  final bool isActive;

  const ProfileCategories({
    Key key,
    @required this.isActive
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> labelText = [
      {"icon": FontAwesomeIcons.userAlt, "text": "Last Name"},
      {"icon": FontAwesomeIcons.userAlt, "text": "First Name"},
      {"icon": FontAwesomeIcons.userAlt, "text": "Middle name"},
      {"icon": FontAwesomeIcons.userAlt, "text": "Phone Number"},
      {"icon": FontAwesomeIcons.envelope, "text": "Email"},
    ];
    return Column(
      children: [
        ...List.generate(labelText.length, (index) => ProfileCard(
            icon: labelText[index]["icon"],
            text: labelText[index]["text"],
            isActive: isActive,
          )
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final String text;
  const ProfileCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.orange
              ),
            ),
          ),
        ),
        TextFieldContainer(
          color: isActive == false ? Colors.blue : Colors.grey,
          child: TextFormField(
            enabled: !isActive,
            decoration: InputDecoration(
              hintText: "Ho",
              hintStyle: TextStyle(
                fontSize: 18,
                color: isActive == false ? Colors.blue : Colors.grey
              ),
              icon: Icon(
                icon,
                color: isActive == false ? Colors.blue : Colors.grey[400],
                size: 22,
              ),
              border: InputBorder.none
            ),
          ),
        ),
      ],
    );
  }
}