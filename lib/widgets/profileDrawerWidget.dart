import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/authentication.dart';
import '../utils/constants.dart';
import './profileWdiget.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  bool loading = false;

  Future<void> logoutUser() async {
    setState(() {
      loading = true;
    });
    Authentication().logout();
    Navigator.of(context).pushReplacementNamed("/");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(context, logoutUser, "Home"),
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text("Profile"),
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
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ProfileWidget(userId:""),
    );
  }
}
