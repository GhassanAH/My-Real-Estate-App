import 'package:flutter/material.dart';
import '../screens/custom_clip.dart';
import '../model/poster.dart';

class DisplayImages extends StatefulWidget {
  PosterInfo post;

  DisplayImages({Key? key, required this.post}) : super(key: key);
  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  List<String> checkImage() {
    List<String> images = [];
    if (widget.post.img1!.isNotEmpty) {
      images.add(widget.post.img1!);
    }
    if (widget.post.img2!.isNotEmpty) {
      images.add(widget.post.img2!);
    }
    if (widget.post.img3!.isNotEmpty) {
      images.add(widget.post.img3!);
    }
    if (widget.post.img4!.isNotEmpty) {
      images.add(widget.post.img4!);
    }
    if (widget.post.img5!.isNotEmpty) {
      images.add(widget.post.img5!);
    }
    if (widget.post.img6!.isNotEmpty) {
      images.add(widget.post.img6!);
    }
    if (widget.post.img7!.isNotEmpty) {
      images.add(widget.post.img7!);
    }
    return images;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
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
            title: Text("Post Images"),
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
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.2),
          child: Column(
              children: checkImage().map((url) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(url, frameBuilder:
                    (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                }, loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                )
              );
          }).toList()),
        )));
  }
}
