import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realestateapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/authentication.dart';
import 'package:realestateapp/widgets/profileWdiget.dart';
import '../model/poster.dart';
import '../screens/images.dart';
import '../screens/location.dart';
import '../screens/viewSellerInfo.dart';
import '../utils/constants.dart';
import '../services/posterServices.dart';
import '../utils/custom_clip.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool loading = false;
  bool isSearching = false;
  List<PosterInfo> posters = [];
  String? selected;
  List<String> choices = [
    "Sort Poster by high price",
    "Sort Poster by small price"
  ];
 

  Future<void> logoutUser() async {
    setState(() {
      loading = true;
    });
    Authentication().logout();
    Navigator.of(context).pushReplacementNamed("/");
  }

  Future<void> setData(String value) async {
    final post = await Poster().getPost("governorate", value);
    setState(() {
      posters = post;
      loading = false;
    });
  }

  void highPrice() {
    if (posters.isNotEmpty) {
      setState(() {
        posters.sort((a, b) => b.price!.compareTo(a.price!));
      });
    }
  }

  void smallPrice() {
    if (posters.isNotEmpty) {
      setState(() {
        posters.sort((a, b) => a.price!.compareTo(b.price!));
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(

      drawer: appDrawer(context, logoutUser, "Profile"),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(

          flexibleSpace: ClipPath(
            clipper: Custom_clipAppBar(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          title: isSearching
              ? TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search By Goveronate",
                    icon: Icon(Icons.place, color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  enableSuggestions: true,
                  onSubmitted: (value) {
                    setState(() {
                      loading = true;
                    });
                    setData(value);
                  },
                )
              : Text("Home"),
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
          actions: [
            isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                      });
                    },
                    icon: Icon(Icons.close))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: Icon(Icons.search))
          ],
          backgroundColor: Colors.grey[200],
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: loading
          ? SpinKitFadingCircle(
        color: Colors.blue,
        size: 60,
      )
          : Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/wallpaper.jpg'))),
        child: ListView(
          children: [
            Align(
                 alignment: Alignment.topRight,
                 child:  DropdownButton(
                    value: selected,
                    hint: Text("filter posters"),
                    onChanged: (newValue) {
                      if (newValue == "Sort Poster by high price") {
                        highPrice();
                      } else {
                        smallPrice();
                      }
                    },
                    items: choices.map((choice) {
                      return DropdownMenuItem(
                        child: Text(choice),
                        value: choice,
                      );
                    }).toList()
                    ),
               ),

            Column(
              children: posters.map((post) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Container(
                      height: 450,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 1,
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Container(
                                  height: 200,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(post.img0!)
                                      )
                                  ),
                                ),
                              )),
                          Positioned(
                            top: 20,
                            left: 50,
                            child: Container(
                              child: Text(post.name!, style: TextStyle(fontSize: 40),),
                            ),
                          ),

                          Positioned(
                              top: 260,
                              left: 60,
                              child: Column(
                                children:[
                                  ImageIcon( AssetImage('assets/icon1.png'),color: Colors.blue,size: 30,),
                                  Text(post.type!),
                                  Text('type',style: TextStyle(fontSize: 12,color: Colors.teal),)
                                ]
                              )),

                          Positioned(
                              top: 260,
                              left: 180,
                              child: Column(
                                children:[
                                  ImageIcon(AssetImage('assets/priceIcon.png'),color: Colors.blue,size: 30,),
                                  Text(post.price!),
                                  Text('OMR',style: TextStyle(fontSize: 12,color: Colors.teal),)
                                ]
                              )),

                          Positioned(
                              top: 260,
                              left: 300,
                              child: Column(
                                children:[
                                  ImageIcon(AssetImage('assets/locationIcon.png'),color: Colors.blue,size: 30,),
                                  Text(post.governorate!),
                                  Text('location',style: TextStyle(fontSize: 12,color: Colors.teal),)
                                ]
                              )),

                          Positioned(
                              top: 342,
                              left: 50,
                              child: Row(
                                
                                children:[
                                  ImageIcon(AssetImage('assets/editIcon.png'),color: Colors.blue,size: 30,),
                                  SizedBox(width: 10,),
                                  Text(post.description!),
                                ]
                              )),

                          Positioned(
                              top: 380,
                              left: 20,
                              child: Container(
                                child: Ink(
                                  decoration: ShapeDecoration(
                                      color: Colors.lightBlue,
                                      shape: CircleBorder()
                                  ),
                                  child: IconButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                location(
                                                  post: post,
                                                )),
                                      );
                                    },
                                    icon: ImageIcon(AssetImage('assets/searchIcon.png'),color: Colors.white,size: 30,),
                                    iconSize: 30,
                                    color: Colors.white,

                                  ),
                                ),
                              )),
                          Positioned(
                              top:380 ,
                              left: 340,
                              child: Container(
                                child: Ink(
                                    decoration: ShapeDecoration(
                                        color: Colors.lightBlue,
                                        shape: CircleBorder()
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewSellerScreen(
                                                      post: post
                                                  )),
                                        );

                                      },
                                      icon: ImageIcon(AssetImage('assets/profileIcon.png'),color: Colors.white,size: 30,),
                                      iconSize: 30,
                                      color: Colors.white,
                                    )


                                ),
                              )),
                          Positioned(
                              top:150 ,
                              left: 350,
                              child: Container(
                                child: Ink(
                                    decoration: ShapeDecoration(
                                        color: Colors.lightBlue,
                                        shape: CircleBorder()
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayImages(
                                                      post: post
                                                  )),
                                        );

                                      },
                                      icon: Icon(Icons.image),
                                      iconSize: 30,
                                      color: Colors.white,
                                    )


                                ),
                              ))
                        ],
                      ),
                    ),
                  ),

                );
          }).toList(),
            )
          ]

        ),
      )
    );
  }
}


