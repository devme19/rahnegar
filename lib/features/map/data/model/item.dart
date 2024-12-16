class Item {
  String title;
  String address;
  String neighbourhood;
  String region;
  String type;
  String category;
  Location location;

  Item({
    required this.title,
    required this.address,
    required this.neighbourhood,
    required this.region,
    required this.type,
    required this.category,
    required this.location,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title']??'',
      address: json['address']??'',
      neighbourhood: json['neighbourhood']??'',
      region: json['region']??'',
      type: json['type']??'',
      category: json['category']??'',
      location: Location.fromJson(json['location']),
    );
  }
}

// Location class in Dart
class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['y'],
      longitude: json['x'],
    );
  }
}