import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:realestateapp/screens/location.dart';

import '../model/poster.dart';
import '../utils/constants.dart';
import '../services/posterServices.dart';
import 'images.dart';

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  List<PosterInfo> posters = [];
  bool loading = true;
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    final post = await Poster().getPost("postId", uid);
    setState(() {
      posters = post;
      loading = false;
    });
  }

  Future<void> deleteData(PosterInfo deletedpost) async {
    try {
      setState(() {
        loading = true;
      });
      await Poster().deleteMyPost(deletedpost);
      final post = await Poster().getPost("postId", uid);
      setState(() {
        posters = post;
        loading = false;
      });
    } catch (e) {
      setState(() {
        
        loading = false;
      });
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/home");
            },
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: loading
          ? SpinKitFadingCircle(
              color: Colors.blue,
              size: 100,
            )
          : ListView(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                             crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                    IconButton(
                                        onPressed: () {
                                          deleteData(post);
                                        },
                                        icon: Icon(Icons.close_sharp, size: 30,)
                                        )
                              ],
                            ),
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
                                  CardHeading(Icon(Icons.house),post.type!,50),
                                  CardHeading(Icon(Icons.place),post.governorate!,50),
                                  CardHeading(Icon(Icons.money),post.price!+" OMR",50),
                                  CardHeading(Icon(Icons.money_off_csred_sharp),post.description!,50),
                             
                          
                                ],
                              ),
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => location(post: post,)),
                                          );
                                        },
                                        icon: Icon(Icons.location_pin,size: 30,))),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => DisplayImages(post: post,)),
                                          );
                                        },
                                        icon: Icon(Icons.image,size: 30,))),
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
    );
  }
}
