/// A class to hold the [Flexes] model

class Flexes {

  /// setting constructor for the flex class
  Flexes({
    this.locationCoordinates,
    this.name,
    this.creator,
    this.fromDate,
    this.toDate,
    this.totalInvitees,
    this.capacity,
    this.ageRating,
    this.flexType,
    this.bannerImage,
    this.hashtag,
    this.payStatus,
    this.viewStatus,
    this.genderRestriction,
    this.showOnAccepted,
    this.consumablesPolicy,
    this.flexRules,
    this.joinCode,
    this.distance,
    this.id,
    this.videoLink,
  });

  /// This variable holds the flex coordinates
  FlexLocationCoordinates? locationCoordinates;

  /// This variable hold the flex name
  String? name;

  /// This variable holds the flex creator
  Creator? creator;

  /// This variable holds the flex from date
  DateTime? fromDate;

  /// This variable holds the flex to date
  DateTime? toDate;

  /// This variable holds the flex total invites
  int? totalInvitees;

  /// This variable holds the flex capacity
  int? capacity;

  /// This variable holds the flex ageRating
  String? ageRating;

  /// This variable holds the flexType
  String? flexType;

  /// This variable holds the bannerImage
  List<String>? bannerImage;

  /// This variable holds the flex hashtag
  String? hashtag;

  /// This variable holds the flex payStatus
  String? payStatus;

  /// This variable holds the flex viewStatus
  String? viewStatus;

  /// This variable holds the flex showOnAccepted
  bool? showOnAccepted;

  /// This variable holds the flex genderRestriction
  String? genderRestriction;

  /// This variable holds the flex consumablesPolicy
  String? consumablesPolicy;

  /// This variable holds the flex viewStatus
  String? flexRules;

  /// This variable holds the flex viewStatus
  String? joinCode;

  double? distance;

  /// This variable holds the flex id
  String? id;

  /// This variable holds the flex id
  String? videoLink;

  factory Flexes.fromJson(Map<String, dynamic> json) => Flexes(
    locationCoordinates: json['locationCoordinates'] != null ? FlexLocationCoordinates.fromJson(json["locationCoordinates"]) : null,
    name: json["name"] ?? '',
    // creator: json['creator'] != null ? Creator.fromJson(json["creator"]) : null,
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    totalInvitees: json["totalInvitees"] ?? 0,
    capacity: json["capacity"] ?? 1,
    ageRating: json["ageRating"] ?? '',
    flexType: json["flexType"] ?? '',
    bannerImage: List<String>.from(json['bannerImage'].map((x) => x)),
    hashtag: json["hashtag"] ?? '',
    payStatus: json["payStatus"] ?? '',
    viewStatus: json["viewStatus"] ?? '',
    showOnAccepted: json["showOnAccepted"] ?? false,
    genderRestriction: json["genderRestriction"] ?? '',
    consumablesPolicy: json["consumablesPolicy"] ?? '',
    flexRules: json["flexRules"] ?? '',
    joinCode: json["joinCode"] ?? '',
    distance: json['distance'] != null ? json["distance"].toDouble() : 0.0,
    id: json["id"] ?? '',
    videoLink: json["videoLink"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "locationCoordinates": locationCoordinates?.toJson(),
    "name": name,
    "creator": creator?.toJson(),
    "fromDate": fromDate?.toIso8601String(),
    "toDate": toDate?.toIso8601String(),
    "totalInvitees": totalInvitees,
    "capacity": capacity,
    "ageRating": ageRating,
    "flexType": flexType,
    "bannerImage": bannerImage,
    "hashtag": hashtag,
    "payStatus": payStatus,
    "viewStatus": viewStatus,
    "showOnAccepted": showOnAccepted,
    "genderRestriction": genderRestriction,
    "consumablesPolicy": consumablesPolicy,
    "flexRules": flexRules,
    "joinCode": joinCode,
    "distance": distance,
    "id": id,
    "videoLink": videoLink,
  };
}

class Creator {

  Creator({
    this.name,
    this.id,
    this.phone,
  });

  String? name;
  String? id;
  String? phone;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    name: json["name"] ?? '',
    id: json["id"] ?? '',
    phone: json["phone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "phone": phone,
  };
}

class FlexLocationCoordinates {

  FlexLocationCoordinates({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory FlexLocationCoordinates.fromJson(Map<String, dynamic> json) => FlexLocationCoordinates(
    lat: json['lat'] != null ? json["lat"].toDouble() : 0.0,
    lng: json['lng'] != null ? json["lng"].toDouble() : 0.0,
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
