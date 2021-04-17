import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_together/core/storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

const String _COLLECTION_NAME = 'posts';
const String _COMMENTS_COLLECTION_NAME = 'comments';

class PostService {
  PostService._privateConstructor();
  static final PostService _instance = PostService._privateConstructor();
  static PostService get instance => _instance;

  CollectionReference posts =
      FirebaseFirestore.instance.collection(_COLLECTION_NAME);
  CollectionReference comments =
      FirebaseFirestore.instance.collection(_COMMENTS_COLLECTION_NAME);

  createPost(List<Asset> images, Map content, String type) async {
    List imageBytes = [];
    List<String> downloadUrls = [];

    for (var i in images) {
      var file = await i.getByteData();
      List<int> imageData = file.buffer.asUint8List();
      imageBytes.add(imageData);
    }

    for (var d in imageBytes) {
      Random random = Random();
      String filename = '${random.nextInt(9999999)}.png';
      await firebase_storage.FirebaseStorage.instance
          .ref('images/$filename')
          .putData(d);
      downloadUrls.add(await firebase_storage.FirebaseStorage.instance
          .ref('images/$filename')
          .getDownloadURL());
    }

    await posts.add({
      "type": type,
      "images": downloadUrls,
      "content": content,
      "province": Storage.getString('location'),
      "userId": Storage.getString('userid'),
      "time": DateTime.now()
    });
  }

  createComment(String comment, String id, images) async {
    List<String> paths = await uploadImages(images);
    await comments.add({
      "comment": comment,
      "id": id,
      "images": paths,
      "user": Storage.getString('userid')
    });
  }

  uploadImages(List<Asset> images) async {
    List imageBytes = [];
    List<String> downloadUrls = [];

    for (var i in images) {
      var file = await i.getByteData();
      List<int> imageData = file.buffer.asUint8List();
      imageBytes.add(imageData);
    }

    for (var d in imageBytes) {
      Random random = Random();
      String filename = '${random.nextInt(9999999)}.png';
      await firebase_storage.FirebaseStorage.instance
          .ref('images/$filename')
          .putData(d);
      downloadUrls.add(await firebase_storage.FirebaseStorage.instance
          .ref('images/$filename')
          .getDownloadURL());
    }
    return downloadUrls;
  }
}
