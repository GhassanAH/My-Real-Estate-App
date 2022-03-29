import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? profilePhoto;

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }

      final imageFile = File(image.path);
      setState(() {
        this.profilePhoto = imageFile;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
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
                    "Home",
                    style: TextStyle(
                      fontSize: 19.1,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/");
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
                    "create posters",
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
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/login");
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
          backgroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(12.2),
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          ClipOval(
                              child: profilePhoto == null
                                  ? Image.asset(
                                      "assets/profile.jpg",
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      profilePhoto!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )),
                          Positioned(
                              bottom: 15,
                              right:
                                  20, //give the values according to your requirement
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: const CircleBorder(),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  pickImage();
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
