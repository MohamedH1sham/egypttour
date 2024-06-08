class TimeSlot {
  final String day;
  final String timeSlot;

  TimeSlot({required this.day, required this.timeSlot});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    final day = json.keys.first;
    final timeSlot = json.values.first ??
        "No time slot"; 
    return TimeSlot(
      day: day,
      timeSlot: timeSlot.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        day: timeSlot,
      };

  String getFormattedTimeSlot() {
    return '$day:$timeSlot';
  }
}

class Place {
  final String? id;
  final String? name;
  final bool? isFavorite;
  final String? number;
  final String? rate;
  final String? link;
  final String? img;
  final List<TimeSlot> time;
  final String? description;
  final String? location;

  Place({
    this.id,
    this.name,
    this.isFavorite,
    this.number,
    this.rate,
    this.link,
    this.img,
    required this.time,
    this.description,
    this.location,
  });

  factory Place.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Place(time: []);
    }

    final String nameKey = json.keys.firstWhere(
      (key) => key.endsWith('name'),
      orElse: () => 'name',
    );
    final String? nameValue = json[nameKey] as String?;

    return Place(
      id: json['_id'] as String?,
      name: nameValue,
      isFavorite: json['isFavorite'] as bool?,
      number: json['number'] as String?,
      rate: json['rate'] as String?,
      link: json['link'] as String?,
      img: json['img'] as String?,
      time: List<TimeSlot>.from(
          (json['time'] ?? []).map((x) => TimeSlot.fromJson(x))),
      description: json['description'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'isFavorite': isFavorite,
        'number': number,
        'rate': rate,
        'link': link,
        'img': img,
        'time': List<dynamic>.from(time.map((x) => x.toJson())),
        'description': description,
        'location': location,
      };
}

class Governorate {
  final String? id;
  final String? name;
  final List<Place> hotels;
  final List<Place> restaurants;
  final List<Place> museums;
  final List<Place> historicalSites;

  Governorate({
    this.id,
    this.name,
    required this.hotels,
    required this.restaurants,
    required this.museums,
    required this.historicalSites,
  });

  factory Governorate.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Governorate(
        hotels: [],
        restaurants: [],
        museums: [],
        historicalSites: [],
      );
    }

    return Governorate(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      hotels: List<Place>.from(json['hotels'].map((x) => Place.fromJson(x))),
      restaurants: List<Place>.from(json['Restaurants'].map((x) {
        final modifiedJson = Map<String, dynamic>.from(x);
        modifiedJson['name'] = modifiedJson['Restaurantsname'];
        return Place.fromJson(modifiedJson);
      })),
      museums: List<Place>.from(json['museums'].map((x) {
        final modifiedJson = Map<String, dynamic>.from(x);
        modifiedJson['name'] = modifiedJson['museumsname'];
        return Place.fromJson(modifiedJson);
      })),
      historicalSites: List<Place>.from(json['historicalsites'].map((x) {
        final modifiedJson = Map<String, dynamic>.from(x);
        modifiedJson['name'] = modifiedJson['historicalname'];
        return Place.fromJson(modifiedJson);
      })),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'hotels': List<dynamic>.from(hotels.map((x) => x.toJson())),
        'Restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
        'museums': List<dynamic>.from(museums.map((x) => x.toJson())),
        'historicalsites':
            List<dynamic>.from(historicalSites.map((x) => x.toJson())),
      };
}

class ApiResponse {
  final String? status;
  final Governorate? data;

  ApiResponse({this.status, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ApiResponse();
    }

    return ApiResponse(
      status: json['status'] as String?,
      data: Governorate.fromJson(json['data']?['gove']),
    );
  }
  Map<String, dynamic> toJson() => {
        'status': status,
        'data': {'gove': data?.toJson()},
      };
}
