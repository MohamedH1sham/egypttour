import 'package:egypttour/views/home_screen/data/place_model.dart';

class FavoritePlace {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String rate;
  final List<TimeSlot> time;
  final String location; // New field for location

  FavoritePlace({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rate,
    required this.time,
    required this.location, // Include location in the constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rate': rate,
      'time': time.map((t) => t.toJson()).toList(),
      'location': location, // Add location to JSON serialization
    };
  }

  factory FavoritePlace.fromJson(Map<String, dynamic> json) {
    return FavoritePlace(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rate: json['rate'],
      time: (json['time'] as List)
          .map((t) => TimeSlot.fromJson(t as Map<String, dynamic>))
          .toList(),
      location: json['location'], // Parse location from JSON
    );
  }
}
