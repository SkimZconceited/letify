class User {
  String uid;
  String name; //full name
  String phone;
  String email;
  String username;
  String password;

  User({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.username,
    this.password,
  });

  User.fromMap(Map<String, dynamic> userDocument)
      : uid = userDocument['uid'],
        name = userDocument['name'],
        phone = userDocument['phone'],
        email = userDocument['email'],
        username = userDocument['username'],
        password = userDocument['password'];
}
