import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum UserType { seller, buyer }

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formGlobalKey = GlobalKey<FormState>();
  UserType? _character = UserType.seller;
  var fullName = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();
  var userName = TextEditingController();
  var password = TextEditingController();
  var loading = false;

  Future<void> signUpUser() async {
    if (formGlobalKey.currentState!.validate()) {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        var user = userCredential.user;

        if (user != null) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          CollectionReference users = firestore.collection("users");

          await users.doc(user.uid).set({
            'user_id': auth.currentUser?.uid,
            'full_name': fullName.text,
            'phoneNumber': phoneNumber.text,
            'userName': userName.text,
            'userType': _character.toString().split('.').last,
            "profileImageUrl": ""
          });

          Navigator.of(context).pushReplacementNamed("/");
        } else {
          
        }
      } catch (e) {
         setState(() {
            loading = false;
          });
      }
    }else{
      setState(() {
            loading = false;
     });
    }

  }

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: loading
          ? SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/login_wall.jpg')
                )
              ),
              padding: EdgeInsets.all(12.2),
              child: ListView(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(15.2),
                      child: Form(
                        key: formGlobalKey,
                        child: Column(
                          children: [
                            Text(
                              "SignUp Now",
                              style: TextStyle(
                                 color: Colors.amber ,fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 15,),
                            Divider(
                              height: 10,
                              indent: 60,
                              endIndent: 60,
                              thickness: 1,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (fullname) {
                                if (fullname!.isEmpty) {
                                  return "The full name can not be empty";
                                } else if (fullname.length > 100) {
                                  return "The fullname is very long";
                                } else {
                                  return null;
                                }
                              },
                              controller: fullName,
                              maxLength: 20,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                              decoration: InputDecoration(
                                filled: true,
                                  labelStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.white30,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white,width:1),
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                  labelText: "Full Name",
                                  icon: Icon(Icons.person,color: Colors.white,)),

                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (phoneNumber) {
                                if (phoneNumber!.isEmpty) {
                                  return "The phone number can not be empty";
                                } else if (phoneNumber.length != 8) {
                                  return "The phone number should be 8 digits";
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneNumber,
                              keyboardType: TextInputType.number,
                              maxLength: 20,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                              decoration: InputDecoration(
                                  filled: true,
                                  labelStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.white30,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white,width:1),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  labelText: "Phone Number",
                                  helperText: '8 numbers',
                                  icon: Icon(Icons.phone,color: Colors.white,)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "The email can not be empty";
                                } else if (email.length > 150) {
                                  return "The email is too long";
                                } else if (!isEmailValid(email)) {
                                  return "Email format is invalid";
                                } else {
                                  return null;
                                }
                              },
                              controller: email,
                              maxLength: 50,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                              decoration: InputDecoration(
                                  filled: true,
                                  labelStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.white30,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white,width:1),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  labelText: "Email",
                                  helperText: 'example@gmai.com',
                                  icon: Icon(Icons.email,color: Colors.white,)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (username) {
                                if (username!.isEmpty) {
                                  return "The username can not be empty";
                                } else if (username.length > 50 ||
                                    username.length < 2) {
                                  return "The username is too long or the username is too short";
                                } else {
                                  return null;
                                }
                              },
                              controller: userName,
                              maxLength: 20,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white30,
                                  labelStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white,width:1),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  labelText: "Username",
                                  icon: Icon(Icons.verified_user,color: Colors.white,)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (password) {
                                if (password!.isEmpty) {
                                  return "The password can not be empty";
                                } else if (password.length < 6) {
                                  return "The password is too short";
                                } else {
                                  return null;
                                }
                              },
                              controller: password,
                              obscureText: true,
                              maxLength: 20,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white30,
                                  labelStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white,width:1),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  labelText: "Password",

                                  icon: Icon(Icons.key,color: Colors.white,)),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text('Seller',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
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
                                    title: Text('Buyer',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
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
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                signUpUser();
                              },
                              child: Text("SIGN UP"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 17),

                                primary: Colors.lightBlue,
                                onPrimary: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
