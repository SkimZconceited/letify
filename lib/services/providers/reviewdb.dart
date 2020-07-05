import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewDatabase {
  //collection reference
  static String _collectionName = 'reviews';

  final _collectionReference = Firestore.instance.collection(_collectionName);

  //retrieve reviews by homeId
  Stream<QuerySnapshot> retrieveReviews(String homeId) {
    print(_collectionReference.path);
    return _collectionReference.where('homeId', isEqualTo: homeId).snapshots();
  }

  //retrieve one review
  Stream<QuerySnapshot> firstReview(String homeId) {
    return _collectionReference
        .where('homeId', isEqualTo: homeId)
        .limit(1)
        .snapshots();
  }
}
