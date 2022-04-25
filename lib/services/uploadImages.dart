import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:realestateapp/services/authentication.dart';

import '../model/user.dart';

class UploadImage {
  UploadImage();

  Future<Userinfo?> pickProfileImage(Userinfo? userinfo) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    String url = userinfo!.imageUrl;
    if (image == null || userinfo == null) {
      return null;
    }

    if (url.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(url).delete();
    }

    String? path = image.path;
    File? imageFile = File(path);
    final pathName = basename(imageFile.path);
    String? userId = userinfo.id;
    final destination = 'profilePhotos/$userId/$pathName';
    final file = FirebaseStorage.instance.ref(destination).child('profile/');
    await file.putFile(imageFile);
    String imageUrl = await file.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'profileImageUrl': imageUrl});
    Authentication auths = Authentication();
    await auths.getUserInfo("");
    return auths.userinfo;
  }

  Future<String> uploadPostImages() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return "";
    }
    String? path = image.path;
    return path;
  }
}

Future<String> uploadUrlImage(String path, int id, String? userId) async {
  File? imageFile = File(path);
  final pathName = basename(imageFile.path);
  final destination = 'posters/$userId/$id/$pathName';
  final file = FirebaseStorage.instance.ref(destination).child('posterImages/');
  await file.putFile(imageFile);
  String imageUrl = await file.getDownloadURL();
  return imageUrl;
}
