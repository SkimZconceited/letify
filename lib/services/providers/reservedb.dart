import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/reserve.dart';

class ReserveDatabase {
  //collection reference
  static String _collectionName = 'reserves';

  final _collectionReference = Firestore.instance.collection(_collectionName);

  //create reserve doc
  createReserve({Reserve reserve}) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await _collectionReference.document().setData({
          'uid': reserve.uid,
          'category': reserve.category,
          'homeId': reserve.homeId,
        });
      });
    } catch (e) {
      print(e.tosString);
      return null;
    }
  }

  //retrieve reserve doc for a user
  Stream<QuerySnapshot> retrieveReserves(String uid) {
    return _collectionReference.where('uid', isEqualTo: uid).snapshots();
  }

  //update reserve doc
  //delete resreve doc
  Future<void> deleteReserve(DocumentSnapshot documentSnapshot) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        return await transaction.delete(documentSnapshot.reference);
      });
      return null;
    } catch (e) {
      return null;
    }
  }
}
