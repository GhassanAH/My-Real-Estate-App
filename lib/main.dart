import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realestateapp/screens/createPost.dart';
import 'package:realestateapp/screens/home.dart';
import 'package:realestateapp/screens/login.dart';
import 'package:realestateapp/screens/post.dart';
import 'package:realestateapp/screens/profile.dart';
import 'package:realestateapp/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import './model/user.dart';




Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Real Estate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "SecularOne-Regular",
        textTheme: const TextTheme(

            headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 18.0),
    ),
      ),
      
      routes: {
        "/": (context) => FirebaseAuth.instance.currentUser == null ?Login():Home() ,
        "/home": (context) => Home(),
        "/signUp": (context) => SignUp(),
        "/profile": (context) => Profile(),
        "/poster": (context) => Post(),
        "/create_post": (context) => CreatePost(),
      },
    );
  }
}
