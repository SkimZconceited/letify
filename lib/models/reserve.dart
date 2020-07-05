class Reserve {
  //instance variables
  String uid; //user id...connects user to reserves
  String category;
  String homeId;
  String id; //uniquely id's documents

  Reserve({this.uid, this.category, this.homeId, this.id});

  Reserve.fromMap(Map<String, dynamic> reserveDocument)
      : uid = reserveDocument['uid'],
        category = reserveDocument['category'],
        homeId = reserveDocument['homeId'];
}
