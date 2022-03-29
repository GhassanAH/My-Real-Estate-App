import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text("Login"),
          backgroundColor: Colors.black87,
          elevation: 0,
          actions: [
            
              Padding(
                padding:EdgeInsets.all(12.2),
                child:         
                ElevatedButton(
                  onPressed: (){
                     Navigator.of(context).pushReplacementNamed("/signUp");
                  }, 
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    ),
                  ), 
                )
            ]
        ),
        body: Center(
            child: Container(
            padding: EdgeInsets.all(12.2),
            child: ListView(
              
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Email"
                  ),
                ),

                SizedBox(height: 30,),

                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Password"
                  ),
                ),

                
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[ ElevatedButton(
                      onPressed: (){}, 
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        ),
                    ),
                  ]
                )

              ],

            ),
          ),
        )
      );
  }
}
