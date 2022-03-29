import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum UserType { seller, buyer }

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserType? _character = UserType.seller;
  var fullName = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();
  var userName = TextEditingController();
  var password = TextEditingController();

  Future<void> signUpUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      print(email.text);
      print(password.text);
      
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      

      var user = userCredential.user;
      print(user);

      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference users = firestore.collection("users");
        print(user.uid);
        print(fullName.text);

        print(phoneNumber.text);
        print(userName.text);
        print(_character.toString().split('.').last);

        await users.add({
          'user_id': auth.currentUser?.uid,
          'full_name': fullName.text,
          'phoneNumber': phoneNumber.text,
          'userName': userName.text,
          'userType': _character.toString().split('.').last
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          title: Text("Sign Up"),
          backgroundColor: Colors.black87,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.all(12.2),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/login");
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
              ),
            )
          ]),
      body: Container(
        padding: EdgeInsets.all(12.2),
        child: ListView(
          children: [
            TextField(
              controller: fullName,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Full Name"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: phoneNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Phone Number"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Email"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: userName,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Username"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Password"),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Seller'),
                    leading: Radio<UserType>(
                      value: UserType.seller,
                      groupValue: _character,
                      onChanged: (UserType? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Buyer'),
                    leading: Radio<UserType>(
                      value: UserType.buyer,
                      groupValue: _character,
                      onChanged: (UserType? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ElevatedButton(
                onPressed: () {
                  signUpUser();
                },
                child: Text("SIGN UP"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
