import 'package:cloud_firestore/cloud_firestore.dart';

class OurFacebook {
  String uid;
  String email;
  String fullName;
  String phoneNumber;
  String urlImage;
  bool enroll;
  Timestamp accountCreated;

  OurFacebook({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.urlImage,
    this.enroll,
    this.accountCreated
  });
}

class OurFacebookDetail {
  String uid;
  String email;
  String fullName;
  String phoneNumber;
  String urlImage;
  bool enroll;

  OurFacebookDetail.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    email = data['email'];
    fullName = data['fullName'];
    phoneNumber = data['phoneNumber'];
    urlImage = data['urlImage'];
    enroll = data['enroll'];
  }
}