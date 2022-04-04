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
      ),
      routes: {
        "/": (context) => Login(),
        "/home": (context) => Home(),
        "/signUp": (context) => SignUp(),
        "/profile": (context) => Profile(),
        "/post": (context) => Post(),
        "/create_post": (context) => CreatePost(),
      },
    );
  }
}
