import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/data/googleAccount.dart';

class DatabaseGoogle {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> createAccountGoogle(OurGoogle google) async {
    String errorMsg = "error";

    try {
      await _firebaseFirestore.collection("googleAccounts").doc(google.uid).set({
        'uid': google.uid,
        'email': google.email,
        'fullName': google.fullName,
        'phoneNumber': google.phoneNumber,
        'urlImage': google.urlImage,
        'enroll': google.enroll,
        'accountCreated': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }

    return errorMsg;
  }
}