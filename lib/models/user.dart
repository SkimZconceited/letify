import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name; //full name
  String phone;
  String email;
  String username;
  String password;
  String dp;
  Timestamp date;
  Map<String, bool> account;

  User({
    this.uid,
    this.name,
    this.phone,
    this.date,
    this.dp,
    this.email,
    this.username,
    this.password,
    this.account,
  });

  User.fromMap(Map<String, dynamic> userDocument)
      : uid = userDocument['uid'],
        name = userDocument['name'],
        phone = userDocument['phone'],
        dp = userDocument['dp'],
        date = userDocument['date'],
        email = userDocument['email'],
        username = userDocument['username'],
        password = userDocument['password'],
        account = userDocument['account'];
}
