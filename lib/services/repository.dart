import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/models/reserve.dart';
import 'package:letify/models/user.dart';
import 'package:letify/services/providers/apartmentdb.dart';
import 'package:letify/services/providers/housedb.dart';
import 'package:letify/services/providers/reservedb.dart';
import 'package:letify/services/providers/reviewdb.dart';
import 'package:letify/services/providers/userdb.dart';

class Repository {
  final UserDatabase _userDatabase = UserDatabase();
  final ApartmentDatabase _apartmentDatabase = ApartmentDatabase();
  final HouseDatabase _houseDatabase = HouseDatabase();
  final ReserveDatabase _reserveDatabase = ReserveDatabase();
  final ReviewDatabase _reviewDatabase = ReviewDatabase();

  //create user
  Future<void> createUser(User user) async {
    try {
      await _userDatabase.createUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //get current user
  Future<Map<String, dynamic>> getCurrentUser(String uid) async {
    try {
      return await _userDatabase.getCurrentUser(uid);
    } catch (e) {
      return null;
    }
  }

  ////get user
  Future<Map<String, dynamic>> getUser(String uid) async {
    try {
      return await _userDatabase.getUser(uid);
    } catch (e) {
      return null;
    }
  }

  //create apartment
  createApartment({Apartment apartment}) {
    return _apartmentDatabase.createApartment(apartment: apartment);
  }

  //retrieve apartment
  Stream<QuerySnapshot> retrieveApartment() {
    return _apartmentDatabase.retrieveApartment();
  }

  //create house
  createHouse({House house}) {
    return _houseDatabase.createHouse(house: house);
  }

  //retrieve houses

  Stream<QuerySnapshot> retrieveHouse() {
    return _houseDatabase.retrieveHouse();
  }

  //trendy apartments
  Stream<QuerySnapshot> trendyApartments() {
    return _apartmentDatabase.trendyApartments();
  }

  //trendy houses
  Stream<QuerySnapshot> trendyHouses() {
    return _houseDatabase.trendyHouses();
  }

  //beach apartments
  Stream<QuerySnapshot> beachApartments() {
    return _apartmentDatabase.beachApartments();
  }

  //beach houses
  Stream<QuerySnapshot> beachHouses() {
    return _houseDatabase.beachHouses();
  }

  //city apartments
  Stream<QuerySnapshot> cityApartments() {
    return _apartmentDatabase.cityApartments();
  }

  //city houses
  Stream<QuerySnapshot> cityHouses() {
    return _houseDatabase.cityHouses();
  }

  //more apartments
  Stream<QuerySnapshot> moreApartments() {
    return _apartmentDatabase.moreApartments();
  }

  //more houses
  Stream<QuerySnapshot> moreHouses() {
    return _houseDatabase.moreHouses();
  }

  //create reserve
  createReserve(Reserve reserve) {
    return _reserveDatabase.createReserve(reserve: reserve);
  }

  //retrieve reserve
  Stream<QuerySnapshot> retrieveReserves(String uid) {
    return _reserveDatabase.retrieveReserves(uid);
  }

  //delete reserve
  Future<void> deleteReserve(DocumentSnapshot documentSnapshot) {
    return _reserveDatabase.deleteReserve(documentSnapshot);
  }

  //retrieve reserved apts for user
  Future<DocumentSnapshot> reservedApartments({String homeId}) {
    return _apartmentDatabase.reservedApartments(homeId: homeId);
  }

  //retriebe reserved houses for user
  Future<DocumentSnapshot> reservedHouses({String homeId}) {
    return _houseDatabase.reservedHouses(homeId: homeId);
  }

  //retrieve reviews for a homeId
  Stream<QuerySnapshot> retrieveReviews(String homeId) {
    return _reviewDatabase.retrieveReviews(homeId);
  }

  //first review
  Stream<QuerySnapshot> firstReview(String homeId) {
    return _reviewDatabase.firstReview(homeId);
  }
}
