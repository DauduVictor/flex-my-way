/// A class to hold [User] model

class User {

  /// setting constructor for user class
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.preferredFlex,
    this.infoSource,
    this.occupation,
    this.flexCreated,
    this.flexAttended,
    this.bearer_token,
  });

  /// This variable holds the user id
  String? id;

  /// This variable holds the user name
  String? name;

  /// This variable holds the user email
  String? email;

  /// This variable holds the user phone
  String? phone;

  /// This variable holds the user gender
  String? gender;

  /// This variable holds the user preferredFlex
  String? preferredFlex;

  /// This variable holds the user infoSource
  String? infoSource;

  /// This variable holds the user occupation
  String? occupation;

  /// This variable holds the list of user flexCreated
  List<String>? flexCreated;

  /// This variable holds the list of user flexAttended
  List<FlexAttended>? flexAttended;

  /// This variable holds the user token
  String? bearer_token;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    preferredFlex: json["preferredFlex"],
    infoSource: json["infoSource"],
    occupation: json["occupation"],
    // flexCreated: List<String>.from(json["flexCreated"].map((x) => x)),
    // flexAttended: List<FlexAttended>.from(json["flexAttended"].map((x) => FlexAttended.fromJson(x))),
    bearer_token: json["bearer_token"],
  );

  factory User.fromSql(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    preferredFlex: json["preferredFlex"],
    infoSource: json["infoSource"],
    occupation: json["occupation"],
    // flexCreated: List<String>.from(json["flexCreated"].map((x) => x)),
    // flexAttended: List<FlexAttended>.from(json["flexAttended"].map((x) => FlexAttended.fromJson(x))),
    bearer_token: json["bearer_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "preferredFlex": preferredFlex,
    "infoSource": infoSource,
    "occupation": occupation,
    // "flexCreated": List<dynamic>.from(flexCreated!.map((x) => x)),
    // "flexAttended": List<dynamic>.from(flexAttended!.map((x) => x.toJson())),
    "bearer_token": bearer_token,
  };

  Map<String, dynamic> toSql() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "preferredFlex": preferredFlex,
    "infoSource": infoSource,
    "occupation": occupation,
    // "flexCreated": List<dynamic>.from(flexCreated!.map((x) => x)),
    // "flexAttended": List<dynamic>.from(flexAttended!.map((x) => x.toJson())),
    "bearer_token": bearer_token,
  };
}



class FlexAttended {

  FlexAttended({
    this.attendeeId,
    this.flexCode,
    this.canAttend,
    this.id,
  });

  String? attendeeId;
  String? flexCode;
  bool? canAttend;
  String? id;

  factory FlexAttended.fromJson(Map<String, dynamic> json) => FlexAttended(
    attendeeId: json["attendeeId"],
    flexCode: json["flexCode"],
    canAttend: json["canAttend"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "attendeeId": attendeeId,
    "flexCode": flexCode,
    "canAttend": canAttend,
    "_id": id,
  };
}
