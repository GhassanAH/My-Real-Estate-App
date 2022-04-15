import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../model/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/createPost.dart';
import '../utils/authentication.dart';
import '../utils/constants.dart';
import '../utils/uploadImages.dart';

class ProfileWidget extends StatefulWidget {
  String? userId;

  ProfileWidget({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File? profilePhoto;
  Userinfo? userinfo;
  User? user;
  var loading = true;

  initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      Authentication auths = Authentication();
      await auths.getUserInfo(widget.userId!);

      setState(() {
       
        userinfo = auths.userinfo;
        print(userinfo);
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      createSnackBar(_scaffoldKey, "something went wrong");
    }
  }

  Future<void> pickImage() async {
    try {
      setState(() {
        loading = true;
      });
      UploadImage imageUploader = UploadImage();
      Userinfo? userWitheImage = await imageUploader.pickProfileImage(userinfo);
      setState(() {
        if (userWitheImage != null) {
          userinfo = userWitheImage;
          loading = false;
        }
      });
    } on PlatformException catch (e) {
      setState(() {
        loading = false;
      });
      createSnackBar(_scaffoldKey, "something went wrong");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            )
          : ListView(
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
                              SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.black,
                                    child: Center(
                                      child: widget.userId!.isEmpty? Text("My Information",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white)
                                              ):
                                              Text("Seller Information",
                                                style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white
                                                )
                                              )
                                              
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  ClipOval(
                                      child: userinfo!.imageUrl.isEmpty
                                          ? Image.asset(
                                              "assets/profile.jpg",
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              userinfo!.imageUrl,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )),
                                  
                                  widget.userId!.isEmpty? Positioned(
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
                                      )
                                    ): SizedBox()
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(12.2),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: double.infinity,
                                      child: Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                userinfo!.name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: double.infinity,
                                      child: Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.email,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                userinfo!.email,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: double.infinity,
                                      child: Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.phone,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                userinfo!.phoneNumber,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: double.infinity,
                                      child: Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.work,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                userinfo!.type,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: double.infinity,
                                      child: Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.verified_user,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                userinfo!.username,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          )),
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
      floatingActionButton: widget.userId!.isEmpty? FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (() {
          print(userinfo?.id);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              //new
              settings: const RouteSettings(name: '/create_post'), //new
              builder: (context) => CreatePost(
                    uid: userinfo?.id,
                  ) //new
              ));
        }),
        child: Icon(Icons.add),
      ):null
    );
  }
}
