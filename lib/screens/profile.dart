import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../model/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? profilePhoto;
  Userinfo? userinfo;
  User? user;
  var loading = false;

  initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference document = firestore.collection("users").doc(user?.uid);
      DocumentSnapshot? data;
      String? email =  user?.email;
      await document.get().then((value) => {data = value});
      setState(() {
        userinfo = Userinfo(data!['full_name'],email!,
            data!['phoneNumber'], data!['userType'], data!['userName']);
      });
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null || userinfo == null) {
        return;
      }
      String ? path = image.path;
      File? imageFile = File(path);
      final pathName = basename(imageFile.path);
      String ? userId = user?.uid;
      final destination = 'profilePhotos/$userId/$pathName';
      try{
          final file  = FirebaseStorage
                              .instance
                              .ref(destination)
                              .child('profile/');
          await file.putFile(imageFile);
      }catch(e){
          print(e);
      }
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
                  Navigator.of(context).pushReplacementNamed("/home");
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
      body: loading
          ? SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.2),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.2),
                          child: Column(
                            children: [
                              Stack(
                                children: <Widget>[
                                  ClipOval(
                                      child: profilePhoto == null
                                          ? Image.asset(
                                              "assets/profile.jpg",
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              profilePhoto!,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )),
                                  Positioned(
                                      bottom: 10,
                                      right:
                                          10, //give the values according to your requirement
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
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      userinfo == null
                                          ? "loading..."
                                          : "Name: " + userinfo!.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        userinfo == null
                                            ? "loading..."
                                            : "Email: " + userinfo!.email,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        userinfo == null
                                            ? "loading..."
                                            : "Phone Number: " +
                                                userinfo!.phoneNumber,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        userinfo == null
                                            ? "loading..."
                                            : "User Type: " + userinfo!.type,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        userinfo == null
                                            ? "loading..."
                                            : "User username: " +
                                                userinfo!.username,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (() {}),
        child: Icon(Icons.add),
      ),
    );
  }
}
