import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

const String _COLLECTION_NAME = 'posts';

class PostService {
  PostService._privateConstructor();
  static final PostService _instance = PostService._privateConstructor();
  static PostService get instance => _instance;

  CollectionReference posts =
      FirebaseFirestore.instance.collection(_COLLECTION_NAME);

  createPost(List<Asset> images, Map content, String type) async {
    List imageBytes = [];

    for (var i in images) {
      var file = await i.getByteData();
      List<int> imageData = file.buffer.asUint8List();
      imageBytes.add(imageData);
    }
    print(imageBytes);
    print(content);
    print(type);
  }
}
