import 'package:flutter/material.dart';
import '../widgets/signupWidget.dart';

enum UserType { seller, buyer }

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          leading: Icon(Icons.account_circle_outlined,size: 40,),
          backgroundColor: Colors.lightBlue[400],
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.all(12.2),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/");
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
              ),
            )
          ]),
      body: SignUpWidget()
    );
  }
}
