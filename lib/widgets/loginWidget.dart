import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formGlobalKeyLogin = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var loading = false;

  Future<void> LoginUser() async {
    if (formGlobalKeyLogin.currentState!.validate()) {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        var user = userCredential.user;
        if (user != null) {
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          setState(() {
            loading = false;
          });
        }
      } catch (e) {
          setState(() {
            loading = false;
          });
      }
    }
  }

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? SpinKitRotatingCircle(
                color: Colors.black,
                size: 50.0,
              )
            : Center(
                child: Container(
                    width: double.infinity,
                    height: 500,
                    padding: EdgeInsets.all(12.2),
                    child: ListView(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.1),
                            child: Form(
                              key: formGlobalKeyLogin,
                              child: Column(
                                children: [
                                  Text(
                                    "Login Now",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800),
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
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: "Email",
                                        icon: Icon(Icons.email)),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    validator: (password) {
                                      if (password!.isEmpty) {
                                        return "The password can not be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: password,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: "Password",
                                        icon: Icon(Icons.key)),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              loading = true;
                                            });
                                            LoginUser();
                                          },
                                          child: Text("Login"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            onPrimary: Colors.white,
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
        );
  }
}