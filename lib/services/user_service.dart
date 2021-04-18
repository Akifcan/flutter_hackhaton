import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_together/core/storage.dart';

const String _COLLECTION_NAME = 'users';

class UserService {
  UserService._privateConstructor();

  static final UserService _instance = UserService._privateConstructor();

  static UserService get instance => _instance;

  CollectionReference users =
      FirebaseFirestore.instance.collection(_COLLECTION_NAME);

  signIn(UserCredential user, String city) async {
    final exist = await users.where('email', isEqualTo: user.user.email).get();
    if (exist.docs.length > 0) {
      Storage.saveString('userid', exist.docs[0].id);
    } else {
      final result = await users.add({
        "username": user.user.displayName,
        "avatar": user.user.photoURL,
        "city": city,
        "email": user.user.email
      });
      Storage.saveString('userid', result.id);
    }
    Storage.saveString('location', city.toLowerCase());
    print(Storage.getString('userid'));
  }
}
