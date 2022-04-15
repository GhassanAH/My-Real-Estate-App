import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realestateapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:realestateapp/utils/authentication.dart';
import 'package:realestateapp/widgets/profileWdiget.dart';
import '../model/poster.dart';
import '../screens/images.dart';
import '../screens/location.dart';
import '../screens/viewSellerInfo.dart';
import '../utils/constants.dart';
import '../utils/posterServices.dart';
import '../screens/custom_clip.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool loading = false;
  bool isSearching = false;
  List<PosterInfo> posters = [];

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

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(context, logoutUser, "Profile"),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: loading
          ? SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/wallpaper.jpg'))),
              child: ListView(
                children: posters.map((post) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                post.name!,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(height: 20),
                              Image.network(post.img0!),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    CardHeading(
                                        Icon(Icons.house), post.type!, 50),
                                    CardHeading(Icon(Icons.place),
                                        post.governorate!, 50),
                                    CardHeading(
                                        Icon(Icons.money), post.price!, 50),
                                    CardHeading(
                                        Icon(Icons.money_off_csred_sharp),
                                        post.description!,
                                        50),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      location(
                                                        post: post,
                                                      )),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.location_pin,
                                            size: 30,
                                          ))),
                                  Align(
                                      alignment: Alignment.center,
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
                                            print(post.userId);
                                          },
                                          icon: Icon(
                                            Icons.person,
                                            size: 30,
                                          ))),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisplayImages(
                                                        post: post,
                                                      )),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.image,
                                            size: 30,
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
