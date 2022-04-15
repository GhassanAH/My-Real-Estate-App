import 'package:flutter/material.dart';
import '../widgets/loginWidget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


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
                    Navigator.of(context).pushReplacementNamed("/signUp");
                  },
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                ),
              )
            ]),
        body: LoginWidget()
        
        );
  }
}
