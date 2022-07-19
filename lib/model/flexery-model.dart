/// A class to hold [DashboardFLex] model

class FlexeryModel {

  /// setting constructor for the flex class
  FlexeryModel({
    this.url,
    this.hashtag,
    this.createdAt,
    this.id,
  });

  /// This variable holds the flex name
  String? url;

  /// This variable holds the flex image
  String? hashtag;

  /// This variable holds the flex total invites
  String? createdAt;

  /// This variable holds the flex code
  String? id;

  factory FlexeryModel.fromJson(Map<String, dynamic> json) => FlexeryModel(
    url: json["url"],
    hashtag: json["hashtag"],
    createdAt: json["createdAt"].toString(),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "hashtag": hashtag,
    "createdAt": createdAt,
    "id": id,
  };
}