import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letify/models/reserve.dart';
import 'package:letify/models/user.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/services/repository.dart';

class ReserveBloc {
  Repository _repository = Repository();
  UserBloc _userBloc = UserBloc();
  //create reserve doc
  createReserve(Reserve reserve) {
    return _repository.createReserve(reserve);
  }

  //rerrieve reserve docs
  Future<Stream<QuerySnapshot>> retrieveReserves() async {
    User user = await _userBloc.getCurrentUser();
    return _repository.retrieveReserves(user.uid);
  }

  //delete reserve docs
  deleteReserve(DocumentSnapshot documentSnapshot) {
    return _repository.deleteReserve(documentSnapshot);
  }

  //retrieve reserved apts for user
  Future<DocumentSnapshot> reservedApartments({String homeId}) {
    return _repository.reservedApartments(homeId: homeId);
  }

  //retrieve reserved houses for user
  Future<DocumentSnapshot> reservedHouses({String homeId}) {
    return _repository.reservedHouses(homeId: homeId);
  }
}
