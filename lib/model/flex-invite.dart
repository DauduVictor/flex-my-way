class FlexInvite {

  FlexInvite({
    this.attendeeId,
    this.flexCode,
    this.flexId,
    this.attendeeStatus,
    this.id,
  });

  String? attendeeId;
  String? flexCode;
  String? flexId;
  String? attendeeStatus;
  String? id;

  factory FlexInvite.fromJson(Map<String, dynamic> json) => FlexInvite(
    attendeeId: json["attendeeId"],
    flexCode: json["flexCode"],
    flexId: json["flexId"],
    attendeeStatus: json["attendeeStatus"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "attendeeId": attendeeId,
    "flexCode": flexCode,
    "flexId": flexId,
    "attendeeStatus": attendeeStatus,
    "_id": id,
  };
}