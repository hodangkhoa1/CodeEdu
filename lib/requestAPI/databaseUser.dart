import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/data/user.dart';

class OurDatabase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String errorMsg = "error";

    try {
      await _firebaseFirestore.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'fullName': user.fullName,
        'phoneNumber': user.phoneNumber,
        'urlImage': user.urlImage,
        'enroll': user.enroll,
        'accountCreated': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }

    return errorMsg;
  }
}