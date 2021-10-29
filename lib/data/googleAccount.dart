import 'package:cloud_firestore/cloud_firestore.dart';

class OurGoogle {
  String uid;
  String email;
  String fullName;
  String phoneNumber;
  String urlImage;
  String nameUniversity;
  bool enroll;
  Timestamp accountCreated;

  OurGoogle({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.urlImage,
    this.nameUniversity,
    this.enroll,
    this.accountCreated
  });
}

class OurGoogleDetail {
  String uid;
  String email;
  String fullName;
  String phoneNumber;
  String urlImage;
  String nameUniversity;
  bool enroll;
  Timestamp dateOfBirth;

  OurGoogleDetail.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    email = data['email'];
    fullName = data['fullName'];
    phoneNumber = data['phoneNumber'];
    urlImage = data['urlImage'];
    nameUniversity = data['nameUniversity'];
    enroll = data['enroll'];
    dateOfBirth = data['dateOfBirth'];
  }
}