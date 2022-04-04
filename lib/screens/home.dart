import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realestateapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var loading = false;

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                ListTile(
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ListTile(
                  tileColor: Colors.black38,
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    "profile",
                    style: TextStyle(
                      fontSize: 19.1,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/profile");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Colors.black26,
                  leading: Icon(
                    Icons.create,
                    color: Colors.white,
                  ),
                  title: Text(
                    "My Posters",
                    style: TextStyle(
                      fontSize: 19.1,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Colors.black38,
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Log out",
                    style: TextStyle(fontSize: 19.1, color: Colors.white),
                  ),
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                ),
                SizedBox(
                  height: 300,
                ),
                Container(
                  child: Center(
                    child: Text("My Real Estate App",
                        style: TextStyle(fontSize: 20, color: Colors.black38)),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Home"),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          backgroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        body: loading
            ? SpinKitRotatingCircle(
                color: Colors.black,
                size: 50.0,
              )
            : Container());
  }
}
