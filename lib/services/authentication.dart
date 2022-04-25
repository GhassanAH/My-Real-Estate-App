import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

class Authentication {
  Userinfo? userinfo;
  User? user;

  Authentication();

  Future<void> getUserInfo(String externelUser) async {
    if (externelUser.isEmpty) {
      await getCurrentUser();
    } else {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference document =
          firestore.collection("users").doc("QTe2uORiwbdog9BcRXoXfA3hdQU2");
      print(externelUser);
      DocumentSnapshot? data;
      // String? email = user?.email;
      print(document);
      await document.get().then((value) => {data = value});

      userinfo = Userinfo(
          data!['full_name'],
          data!['email'],
          data!['phoneNumber'],
          data!['userType'],
          data!['userName'],
          data!['profileImageUrl'],
          externelUser);
    }
  }

  Future<void> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;

    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference document = firestore.collection("users").doc(user?.uid);

      DocumentSnapshot? data;
      String? email = user?.email;

      await document.get().then((value) => {data = value});
      userinfo = Userinfo(
          data!['full_name'],
          email!,
          data!['phoneNumber'],
          data!['userType'],
          data!['userName'],
          data!['profileImageUrl'],
          user?.uid);
    }
  }

  Future<String> updateUser(String? id) async {
    String statement = "";
    var collection = FirebaseFirestore.instance.collection('users');
    collection
        .doc(id)
        .update({'userType': 'seller'}) // <-- Updated data
        .then((_) => statement = 'Success')
        .catchError((error) => statement = 'Failed: $error');
    return statement;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
