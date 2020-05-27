import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/user.dart';

class UserDatabase {
  //user collection
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  //create user
  Future<void> createUser(User user) async {
    try {
      return await userCollection.document(user.uid).setData({
        'uid': user.uid,
        'name': user.name,
        'phone': user.phone,
        'email': user.email,
        'username': user.username,
        'password': user.password
      });
    } catch (e) {
      return null;
    }
  }

  //get current user
  Future<Map<String, dynamic>> getCurrentUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await userCollection.document(uid).get();
      return documentSnapshot != null ? documentSnapshot.data : null;
    } catch (e) {
      return null;
    }
  }
}
