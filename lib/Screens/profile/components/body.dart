import 'package:code_edu/Screens/profile/components/profile_pic.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final String urlImage;
  final String nameProfile;
  final String emailProfile;

  const Body({
    Key key,
    @required this.nameProfile,
    @required this.emailProfile,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool hide = false;

  //File _pickedFile;
  //final ImagePicker _imagePicker = ImagePicker();

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _pickedFile = pickedFile;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Align(
              alignment: Alignment.center,
              child: ProfilePic(
                hide: hide,
                avatarImage: widget.urlImage != null ? widget.urlImage : "https://firebasestorage.googleapis.com/v0/b/codeeduapp.appspot.com/o/21-avatar-outline.gif?alt=media&token=7b98a6a0-15c8-4fd0-9d78-2ed2d468112a",
                onPressedCamera: (){
                  setState(() {
                    //takePhoto(ImageSource.camera);
                  });
                },
                onPressedGallery: (){
                  setState(() {
                    //takePhoto(ImageSource.gallery);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 55),
            child: ProfileCategories(
              textInfo: "KhoaHoDang",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, bottom: 40),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  "Private Information",
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email,
              ),
              SizedBox(width: 10),
              Text(
                "hodangkhoa110701@gmail.com",
                style: TextStyle(
                  fontSize: 17
                ),
              ), //phone number, home
            ],
          )
        ],
      ),
    );
  }
}

class ProfileCategories extends StatelessWidget {
  final String textInfo;

  const ProfileCategories({
    Key key,
    @required this.textInfo
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> labelText = [
      {"textName": "Name", "textInfo": textInfo},
      {"textName": "University", "textInfo": textInfo},
      {"textName": "Location", "textInfo": textInfo},
    ];
    return Column(
      children: [
        ...List.generate(labelText.length, (index) => ProfileCard(
            textInfo: labelText[index]["textInfo"],
            textName: labelText[index]["textName"],
          )
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String textName;
  final String textInfo;
  const ProfileCard({
    Key key,
    @required this.textName,
    @required this.textInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textName,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        Text(
          textInfo,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey
          ),
        )
      ],
    );
  }
}