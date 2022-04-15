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
      setState(() {
        loading = true;
      });
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
        backgroundColor: Colors.lightBlue[200],
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
              child: Center(
                  child: Container(
                      width: double.infinity,
                      height: 500,
                      padding: EdgeInsets.all(0),
                      child: ListView(
                        children: [
                          Container(

                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/logo.jpg'),
                                  radius: 40,
                                ),
                                Text('Login Now',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 16,
                                ),
                                Text('Welcome to Aqaar app',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: 16,),
                                Divider(
                                  height: 3,
                                  thickness: 1,
                                  indent: 60,
                                  endIndent: 60,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Card(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(15.1),
                              child: Form(
                                key: formGlobalKeyLogin,
                                child: Column(
                                  children: [
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

                                              LoginUser();
                                            },
                                            child: Text("Login"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.lightBlue,
                                              onPrimary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 17)
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
                ),
            )
        );
  }
}