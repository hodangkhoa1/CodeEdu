import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePic extends StatelessWidget {
  final String avatarImage;
  final Function onPressedCamera;
  final Function onPressedGallery;
  final File fileImage;
  
  const ProfilePic({
    Key key,
    @required this.avatarImage,
    @required this.onPressedCamera,
    @required this.onPressedGallery,
    @required this.fileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: fileImage == null ? NetworkImage(avatarImage) : FileImage(fileImage),
          ),
          // buildUploadStatus,
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: AnimatedOpacity(
                opacity: 1,
                duration: Duration(seconds: 2),
                // ignore: deprecated_member_use
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFFF5F6F9),
                  onPressed: () {
                    if(Platform.isIOS) {
                      return showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: onPressedCamera,
                              child: Text("Camera"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: onPressedGallery,
                              child: Text("Gallery"),
                            )
                          ],
                        )
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) {
                          return Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Choose profile photo",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // ignore: deprecated_member_use
                                    FlatButton.icon(
                                      onPressed: onPressedCamera,
                                      icon: Icon(
                                        Icons.camera,
                                        size: 28,
                                      ),
                                      label: Text(
                                        "Camera",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ),
                                    // ignore: deprecated_member_use
                                    FlatButton.icon(
                                      onPressed: onPressedGallery,
                                      icon: Icon(
                                        Icons.image,
                                        size: 28,
                                      ),
                                      label: Text(
                                        "Gallery",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                      );
                    }
                  },
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}