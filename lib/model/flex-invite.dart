class FlexInvite {

  FlexInvite({
    this.attendeeId,
    this.flexCode,
    this.flexId,
    this.attendeeStatus,
    this.flexName,
    this.id,
  });

  String? attendeeId;
  String? flexCode;
  String? flexId;
  String? attendeeStatus;
  String? flexName;
  String? id;

  factory FlexInvite.fromJson(Map<String, dynamic> json) => FlexInvite(
    attendeeId: json["attendeeId"],
    flexCode: json["flexCode"],
    flexId: json["flexId"],
    attendeeStatus: json["attendeeStatus"],
    flexName: json["flexName"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "attendeeId": attendeeId,
    "flexCode": flexCode,
    "flexId": flexId,
    "attendeeStatus": attendeeStatus,
    "flexName": flexName,
    "_id": id,
  };
}