import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/house.dart';

class HouseDatabase {
  //collection reference
  static String _collectionName = 'houses';

  final _collectionReference = Firestore.instance.collection(_collectionName);
  //create house
  createHouse({House house}) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await _collectionReference.document().setData({
          'hostId': house.hostId,
          'name': house.name,
          'description': house.description,
          'bedrooms': house.bedrooms,
          'bathrooms': house.bathrooms,
          'customerId': house.customerId,
          'available': house.available,
          'terms': house.terms,
          'location': house.location,
          'images': house.images,
          'videos': house.videos,
          'reviews': house.reviews,
          'price': house.price,
          'status': house.status,
          'likes': house.likes,
          'amenities': house.amenities,
        });
      });
    } catch (e) {
      print(e.tosString);
      return null;
    }
  }

  //retrieve all houses
  Stream<QuerySnapshot> retrieveHouse() {
    return _collectionReference.snapshots();
  }

  //retrieve reserved houses for a user
  Future<DocumentSnapshot> reservedHouses({String homeId}) {
    return _collectionReference.document(homeId).get();
  }

  //retrieve trendy houses
  Stream<QuerySnapshot> trendyHouses() {
    return _collectionReference
        .where('reviews.ratings', isGreaterThanOrEqualTo: 4.0)
        .snapshots();
  }

  //retrieve beach houses
  Stream<QuerySnapshot> beachHouses() {
    return _collectionReference
        .where('category.beach', isEqualTo: true)
        .snapshots();
  }

  //retrieve city houses
  Stream<QuerySnapshot> cityHouses() {
    return _collectionReference
        .where('category.city', isEqualTo: true)
        .snapshots();
  }

  //retrieve more houses
  Stream<QuerySnapshot> moreHouses() {
    return _collectionReference
        .where('category.other', isEqualTo: true)
        .snapshots();
  }
  //update house

  //delete house

}
