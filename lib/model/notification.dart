class Notification {

  Notification({
    this.message,
    this.createdAt,
    this.id,
  });

  String? message;
  DateTime? createdAt;
  String? id;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}