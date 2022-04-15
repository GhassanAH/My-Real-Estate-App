import 'package:flutter/material.dart';

import '../model/poster.dart';
import '../widgets/profileWdiget.dart';

class ViewSellerScreen extends StatefulWidget {
  PosterInfo post;

  ViewSellerScreen({Key? key, required this.post}) : super(key: key);
  @override
  State<ViewSellerScreen> createState() => _ViewSellerScreenState();
}

class _ViewSellerScreenState extends State<ViewSellerScreen> {
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seller Info"),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        body:  ProfileWidget(userId: widget.post.userId!)
        );
  }
}