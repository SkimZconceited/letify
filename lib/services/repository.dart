import 'package:letify/models/user.dart';
import 'package:letify/services/providers/userdb.dart';

class Repository {
  final UserDatabase userDatabase = UserDatabase();

  //create user
  Future<void>createUser(User user) async {
    try{
      await userDatabase.createUser(user);
    }catch(e) {
      print(e.toString());
    }
  }

  //get current user
  Future<Map<String,dynamic>> getCurrentUser(String uid) async{
    try {
      return await userDatabase.getCurrentUser(uid);
    }catch(e) {
      return null;
    } 
  }
}