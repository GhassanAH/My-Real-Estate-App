import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../model/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/createPost.dart';
import '../services/authentication.dart';
import '../utils/constants.dart';
import '../services/uploadImages.dart';
import '../utils/curve_containe.dart';
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
  Authentication auths = Authentication();
  var loading = true;

  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      setState(() {
          loading = true;
      });
      await auths.getUserInfo(widget.userId!);

      setState(() {
        userinfo = auths.userinfo;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      createSnackBar(_scaffoldKey, "something went wrong");
    }
  }

  Future<void> updateType(String? id) async {

    String statement = await auths.updateUser(id);

    await getUserInfo();
  }

  Future<void> pickImage() async {
    try {
      UploadImage imageUploader = UploadImage();
      Userinfo? userWitheImage = await imageUploader.pickProfileImage(userinfo);
      setState(() {
        if (userWitheImage != null) {
          userinfo = userWitheImage;
          loading = false;
        }else{
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
            ? SpinKitFadingCircle(
          color: Colors.blue,
          size: 100,
        )
            : 
           ListView(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              CustomPaint(
                  child: Column(
                    children: [
                      Padding(
                    padding: EdgeInsets.all(20),
                    child: widget.userId!.isEmpty
                        ? Text("Profile details",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight:
                            FontWeight.w900,
                            color: Colors.white))
                        : Text("Seller Information",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight:
                            FontWeight.w900,
                            color: Colors.white)),
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
                    widget.userId!.isEmpty
                        ? Positioned(
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
                        ))
                        : SizedBox()
                  ],
                ),
                    ],
                  ),
                  painter: HeaderCurveLinee(),
                ),
                
                Container(
                  height: 434,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: ListView(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal[50],

                          ),
                          child: Row(
                            children: [
                                Icon(Icons.person,size: 30,),
                              SizedBox(width: 50,),
                          Text(
                            userinfo!.name,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight:
                                FontWeight.w700),
                          ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal[50],

                          ),
                          child: Row(
                            children: [
                              Icon(Icons.alternate_email,size: 30,),
                              SizedBox(width: 50,),
                              Text(
                                userinfo!.email,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal[50],

                          ),
                          child: Row(
                            children: [
                              Icon(Icons.phone,size: 30,),
                              SizedBox(width: 50,),
                              Text(
                                userinfo!.phoneNumber,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal[50],

                          ),
                          child: Row(
                            children: [
                              Icon(Icons.work_outlined,size: 30,),
                              SizedBox(width: 50,),
                              Text(
                                userinfo!.type,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal[50],

                          ),
                          child: Row(
                            children: [
                              Icon(Icons.verified,size: 30,),
                              SizedBox(width: 50,),
                              Text(
                                userinfo!.username,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight.w700),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        )
            
        ,floatingActionButton: widget.userId!.isEmpty &&
                userinfo?.type == "seller"
            ? FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: (() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //new
                      settings: const RouteSettings(name: '/create_post'), //new
                      builder: (context) => CreatePost(
                            uid: userinfo?.id,
                          ) //new
                      ));
                }),
                child: Icon(Icons.add),
              )
            : widget.userId!.isEmpty &&
                userinfo?.type == "buyer"? RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  updateType(userinfo?.id);
                },
                child: Text("Become Seller")):null
                
            ); 
                
  }
}
