/// A class to hold [FlexSuccess] model

class FlexSuccess {

  /// setting constructor for the flex class
  FlexSuccess({
    this.creator,
    this.payStatus,
    this.viewStatus,
    this.showOnAccepted,
    this.joinCode,
    this.locationCoordinates,
    this.id,
  });

  /// This variable holds the flexCreator
  String? creator;

  /// This variable holds the flex payStatus
  String? payStatus;

  /// This variable holds the flex viewStatus
  String? viewStatus;

  /// This variable holds the public or private status of the flex
  bool? showOnAccepted;

  /// This variable holds the flex joinCode
  String? joinCode;

  /// This variable holds the flex locationCoordinates
  LocationCoordinates? locationCoordinates;

  /// This variable holds the flexId
  String? id;

  factory FlexSuccess.fromJson(Map<String, dynamic> json) => FlexSuccess(
    creator: json["creator"],
    payStatus: json["payStatus"],
    viewStatus: json["viewStatus"],
    showOnAccepted: json["showOnAccepted"],
    joinCode: json["joinCode"],
    // locationCoordinates: LocationCoordinates.fromJson(json["locationCoordinates"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator,
    "payStatus": payStatus,
    "viewStatus": viewStatus,
    "showOnAccepted": showOnAccepted,
    "joinCode": joinCode,
    // "locationCoordinates": locationCoordinates!.toJson(),
    "_id": id,
  };
}

class LocationCoordinates {

  /// setting constructor for the locationCoardinates class
  LocationCoordinates({
    this.lat,
    this.lon,
  });

  /// Variable to hold flex lat
  String? lat;

  /// Variable to hold flex lon
  String? lon;

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) => LocationCoordinates(
    lat: json["lat"],
    lon: json["lon"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}