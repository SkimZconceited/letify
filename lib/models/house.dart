class House {
  //instance variables
  String uid;
  String hostId;
  String name;
  String description;
  int bedrooms;
  int bathrooms;
  String price;
  String status;
  String customerId;
  bool available;
  String terms;
  int likes;
  Map<dynamic, dynamic> category;
  Map<dynamic, dynamic> location;
  Map<dynamic, dynamic> reviews;
  List<dynamic> images;
  List<dynamic> videos;
  List<dynamic> amenities;

  House(
      {this.name,
      this.description,
      this.bedrooms,
      this.bathrooms,
      this.images,
      this.category,
      this.available,
      this.terms,
      this.videos,
      this.location,
      this.reviews,
      this.customerId,
      this.price,
      this.status,
      this.likes,
      this.hostId,
      this.amenities});

  House.fromMap(Map<String, dynamic> houseDocument)
      : name = houseDocument['name'],
        description = houseDocument['description'],
        bedrooms = houseDocument['bedrooms'],
        bathrooms = houseDocument['bathrooms'],
        category = houseDocument['category'],
        price = houseDocument['price'],
        status = houseDocument['status'],
        customerId = houseDocument['customerId'],
        terms = houseDocument['terms'],
        available = houseDocument['available'],
        likes = houseDocument['likes'],
        location = houseDocument['location'],
        reviews = houseDocument['reviews'],
        images = houseDocument['images'],
        videos = houseDocument['videos'],
        hostId = houseDocument['hostId'],
        amenities = houseDocument['amenities'];
}
