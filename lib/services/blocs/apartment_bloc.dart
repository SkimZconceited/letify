import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/services/repository.dart';

class ApartmentBloc {
  final Repository _repository = Repository();
  //create document
  createApartment({Apartment apartment}) {
    return _repository.createApartment(apartment: apartment);
  }

  //retrieve document
  Stream<QuerySnapshot> get apartmentStream => _repository.retrieveApartment();
  //update document

  //delete document
}
