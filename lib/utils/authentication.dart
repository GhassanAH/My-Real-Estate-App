import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

class Authentication {
  Userinfo? userinfo;
  User? user;

  Authentication();

  Future<void> getUserInfo() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      user = auth.currentUser;

      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentReference document =
            firestore.collection("users").doc(user?.uid);
            
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
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }
}