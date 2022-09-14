/// A class to hold [DashboardFLex] model

class DashboardFLex {

  /// setting constructor for the flex class
  DashboardFLex({
    this.flexName,
    this.flexImage,
    this.totalInvitees,
    this.confirmedInvitees,
    this.flexCode,
    this.flexCapacity
  });

  /// This variable holds the flex name
  String? flexName;

  /// This variable holds the flex image
  String? flexImage;

  /// This variable holds the flex total invites
  String? totalInvitees;

  /// This variable holds the flex confirmed invites
  String? confirmedInvitees;

  /// This variable holds the flex code
  String? flexCode;

  /// This variable holds the flex code
  String? flexCapacity;

  factory DashboardFLex.fromJson(Map<String, dynamic> json) => DashboardFLex(
    flexName: json["flexName"],
    flexImage: json["flexImage"][0],
    totalInvitees: json["totalInvitees"].toString(),
    confirmedInvitees: json["confirmedInvitees"].toString(),
    flexCode: json["flexCode"],
    flexCapacity: json["flexCapacity"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "flexName": flexName,
    "flexImage": flexImage,
    "totalInvitees": totalInvitees,
    "confirmedInvitees": confirmedInvitees,
    "flexCode": flexCode,
    "flexCapacity": flexCapacity,
  };
}