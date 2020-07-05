

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/house.dart';
import 'package:letify/services/repository.dart';

class HouseBloc {
  final Repository _repository = Repository();
  //create house
  createHouse({House house}) {
    return _repository.createHouse();
  }
  //retrieave house
  Stream<QuerySnapshot> get houseStream => _repository.retrieveHouse();
  //update house

  //delete house
}
