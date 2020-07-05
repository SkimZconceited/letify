class Apartment {
  //instance variables
  String uid;
  String hostId;
  String name;
  String description;
  int bedrooms;
  int bathrooms;
  Map<dynamic, dynamic> building;
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

  Apartment(
      {this.name,
      this.description,
      this.bedrooms,
      this.bathrooms,
      this.images,
      this.videos,
      this.available,
      this.terms,
      this.category,
      this.location,
      this.reviews,
      this.building,
      this.customerId,
      this.price,
      this.status,
      this.likes,
      this.hostId,
      this.amenities});

  Apartment.fromMap(Map<String, dynamic> apartmentDocument)
      : name = apartmentDocument['name'],
        description = apartmentDocument['description'],
        bedrooms = apartmentDocument['bedrooms'],
        bathrooms = apartmentDocument['bathrooms'],
        category = apartmentDocument['category'],
        building = apartmentDocument['building'],
        price = apartmentDocument['price'],
        terms = apartmentDocument['terms'],
        available = apartmentDocument['available'],
        status = apartmentDocument['status'],
        customerId = apartmentDocument['customerId'],
        likes = apartmentDocument['likes'],
        location = apartmentDocument['location'],
        reviews = apartmentDocument['reviews'],
        images = apartmentDocument['images'],
        videos = apartmentDocument['videos'],
        hostId = apartmentDocument['hostId'],
        amenities = apartmentDocument['amenities'];
}
