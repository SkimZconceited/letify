class Review {
  String documentId;
  String userId;
  String text;
  String rating;
  String category;
  String homeId;

  Review({this.userId, this.text, this.rating, this.category, this.homeId});

  Review.fromMap(Map<String, dynamic> reviewDocument)
      : userId = reviewDocument['userId'],
        text = reviewDocument['text'],
        rating = reviewDocument['rating'],
        category = reviewDocument['category'],
        homeId = reviewDocument['homeId'];
}
