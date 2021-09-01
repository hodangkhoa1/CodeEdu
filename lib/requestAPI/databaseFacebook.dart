import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/data/facebookAccount.dart';

class DatabaseFacebook {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> createAccountFacebook(OurFacebook facebook) async {
    String errorMsg = "error";

    try {
      await _firebaseFirestore.collection("facebookAccounts").doc(facebook.uid).set({
        'uid': facebook.uid,
        'email': facebook.email,
        'fullName': facebook.fullName,
        'phoneNumber': facebook.phoneNumber,
        'urlImage': facebook.urlImage,
        'enroll': facebook.enroll,
        'accountCreated': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }

    return errorMsg;
  }
}