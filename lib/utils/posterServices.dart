import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/poster.dart';

class Poster {
  Future<void> uploadPoster(PosterInfo post) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("posters");

    await users.doc().set({
      'postId': post.userId,
      'name': post.name,
      'type': post.type,
      'price': post.price,
      'description': post.description,
      'lat': post.lat,
      "long": post.long,
      "image0": post.img0,
      "image1": post.img1,
      "image2": post.img2,
      "image3": post.img3,
      "image4": post.img4,
      "image5": post.img5,
      "image6": post.img6,
      "image7": post.img7,
      "governorate":post.governorate
    });
  }

  Future<List<PosterInfo>> getPost(String field, String? searchField) async {
    List<PosterInfo> postList = [];

    await FirebaseFirestore.instance
        .collection("posters")
        .where(field, isEqualTo: searchField)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        PosterInfo post = PosterInfo(
          element.data()["name"],
          element.data()["type"],
          element.data()["price"],
          element.data()["description"],
          element.data()["lat"],
          element.data()["long"],
          element.data()["image0"],
          element.data()["image1"],
          element.data()["image2"],
          element.data()["image3"],
          element.data()["image4"],
          element.data()["image5"],
          element.data()["image6"],
          element.data()["image7"],
          element.id,
          element.data()["postId"],
          element.data()["governorate"]
        );
        postList.add(post);
      });
    })
    ;

    return postList;
  }

  Future<void> deleteMyPost(PosterInfo post) async {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);

    if (post.img0!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img0!).delete();
    }
    if (post.img1!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img1!).delete();
    }
    if (post.img2!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img2!).delete();
    }
    if (post.img3!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img3!).delete();
    }
    if (post.img4!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img4!).delete();
    }
    if (post.img5!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img5!).delete();
    }
    if (post.img6!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img6!).delete();
    }
    if (post.img7!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(post.img7!).delete();
    }

    await FirebaseFirestore.instance.collection("posters").doc(post.id).delete();
  }
}
