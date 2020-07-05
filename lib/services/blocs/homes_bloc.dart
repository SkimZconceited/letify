import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomesBloc {
  final Repository _repository = Repository();

  //trendy homes stream
  //combiner function
  List<QuerySnapshot> _combineTrendy(QuerySnapshot a, QuerySnapshot b) =>
      [a, b];

  //trendy stream
  Stream<List<QuerySnapshot>> get trendyStream => CombineLatestStream.combine2<
          QuerySnapshot, QuerySnapshot, List<QuerySnapshot>>(
      _repository.trendyApartments(),
      _repository.trendyHouses(),
      _combineTrendy);

  //city homes stream
  //combiner function
  List<QuerySnapshot> _combineCity(QuerySnapshot a, QuerySnapshot b) => [a, b];

  //city stream
  Stream<List<QuerySnapshot>> get cityStream => CombineLatestStream.combine2<
          QuerySnapshot, QuerySnapshot, List<QuerySnapshot>>(
      _repository.cityApartments(), _repository.cityHouses(), _combineCity);

  //beachy stream
  //combiner function
  List<QuerySnapshot> _combineBeach(QuerySnapshot a, QuerySnapshot b) => [a, b];
  //beach stream
  Stream<List<QuerySnapshot>> get beachStream => CombineLatestStream.combine2<
          QuerySnapshot, QuerySnapshot, List<QuerySnapshot>>(
      _repository.beachApartments(), _repository.beachHouses(), _combineBeach);

  //more stream
  //combiner function
  List<QuerySnapshot> _combineMore(QuerySnapshot a, QuerySnapshot b) => [a, b];
  //more stream

  Stream<List<QuerySnapshot>> get moreStream => CombineLatestStream.combine2<
          QuerySnapshot, QuerySnapshot, List<QuerySnapshot>>(
      _repository.moreHouses(), _repository.moreApartments(), _combineMore);

  //reviews
  Stream<QuerySnapshot> retrieveReviews(String homeId) {
    return _repository.retrieveReviews(homeId);
  }

  //first review
  Stream<QuerySnapshot> firstReview(String homeId) {
    return _repository.firstReview(homeId);
  }
}
