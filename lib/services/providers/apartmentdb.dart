import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/apartment.dart';

class ApartmentDatabase {
  //collection reference
  static String _collectionName = 'apartments';

  final _collectionReference = Firestore.instance.collection(_collectionName);

  //create collection

  createApartment({Apartment apartment}) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await _collectionReference.document().setData({
          'hostId': apartment.hostId,
          'name': apartment.name,
          'description': apartment.description,
          'bedrooms': apartment.bedrooms,
          'bathrooms': apartment.bathrooms,
          'building': apartment.building,
          'location': apartment.location,
          'images': apartment.images,
          'available': apartment.available,
          'terms': apartment.terms,
          'videos': apartment.videos,
          'reviews': apartment.reviews,
          'price': apartment.price,
          'status': apartment.status,
          'customerId': apartment.customerId,
          'likes': apartment.likes,
          'amenities': apartment.amenities,
        });
      });
    } catch (e) {
      print(e.tosString);
      return null;
    }
  }

  //retrieve all apartments
  Stream<QuerySnapshot> retrieveApartment() {
    return _collectionReference.snapshots();
  }

  //retrieve reserved apts for a user
  Future<DocumentSnapshot> reservedApartments({String homeId}) {
    return _collectionReference.document(homeId).get();
  }

  //retrieve trendy apartments
  Stream<QuerySnapshot> trendyApartments() {
    return _collectionReference
        .where('reviews.ratings', isGreaterThanOrEqualTo: 4.0)
        .snapshots();
  }

  //retrieve beach apartments
  Stream<QuerySnapshot> beachApartments() {
    return _collectionReference
        .where('category.beach', isEqualTo: true)
        .snapshots();
  }

  //retrieve city apartments
  Stream<QuerySnapshot> cityApartments() {
    return _collectionReference
        .where('category.city', isEqualTo: true)
        .snapshots();
  }

  //retrieve more apartments
  Stream<QuerySnapshot> moreApartments() {
    return _collectionReference
        .where('category.other', isEqualTo: true)
        .snapshots();
  }
  //update collection

  //delete collection
}
