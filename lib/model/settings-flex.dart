import 'flex.dart';

class SettingsFlex {

  /// setting constructor for the flex class
  SettingsFlex({
    this.flexDetails,
  });

  /// This variable holds the flex locationCoordinates
  Flexes? flexDetails;

  factory SettingsFlex.fromJson(Map<String, dynamic> json) => SettingsFlex(
    flexDetails: Flexes.fromJson(json["flexDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "flexDetails": flexDetails!.toJson(),
  };
}