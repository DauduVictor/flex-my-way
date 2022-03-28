/// A class to hold the [Flexes] model

class Flexes {

  /// setting constructor for the flex class
  Flexes({
    this.name,
    this.creator,
    this.date,
    this.capacity,
    this.ageRating,
    this.flexType,
    this.hashtag,
    this.payStatus,
    this.viewStatus,
    this.showOnAccepted,
    this.consumablesPolicy,
    this.joinCode,
    this.id,
    this.participants,
  });

  /// This variable hold the flex name
  String? name;

  /// This variable holds the flex creator
  String? creator;

  /// This variable holds the flex date
  DateTime? date;

  /// This variable holds the flex capacity
  int? capacity;

  /// This variable holds the flex ageRating
  String? ageRating;

  /// This variable holds the flexType
  String? flexType;

  /// This variable holds the flex hashtag
  String? hashtag;

  /// This variable holds the flex payStatus
  String? payStatus;

  /// This variable holds the flex viewStatus
  String? viewStatus;

  /// This variable holds the flex showOnAccepted
  bool? showOnAccepted;

  /// This variable holds the flex consumablesPolicy
  String? consumablesPolicy;

  /// This variable holds the flex viewStatus
  String? joinCode;

  /// This variable holds the flex id
  String? id;

  /// This variable holds the list of flex participant
  List<dynamic>? participants;

  factory Flexes.fromJson(Map<String, dynamic> json) => Flexes(
    name: json["name"],
    creator: json["creator"],
    date: DateTime.parse(json["date"]),
    capacity: json["capacity"],
    ageRating: json["ageRating"],
    flexType: json["flexType"],
    hashtag: json["hashtag"],
    payStatus: json["payStatus"],
    viewStatus: json["viewStatus"],
    showOnAccepted: json["showOnAccepted"],
    consumablesPolicy: json["consumablesPolicy"],
    joinCode: json["joinCode"],
    id: json["_id"],
    participants: List<dynamic>.from(json["participants"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "creator": creator,
    "date": date!.toIso8601String(),
    "capacity": capacity,
    "ageRating": ageRating,
    "flexType": flexType,
    "hashtag": hashtag,
    "payStatus": payStatus,
    "viewStatus": viewStatus,
    "showOnAccepted": showOnAccepted,
    "consumablesPolicy": consumablesPolicy,
    "joinCode": joinCode,
    "_id": id,
    "participants": List<dynamic>.from(participants!.map((x) => x)),
  };
}
