import 'flex.dart';

class HistoryFlex {

  /// setting constructor for the flex class
  HistoryFlex({
    this.flexDetails,
  });

  /// This variable holds the flex locationCoordinates
  Flexes? flexDetails;

  factory HistoryFlex.fromJson(Map<String, dynamic> json) => HistoryFlex(
    flexDetails: Flexes.fromJson(json["flexDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "flexDetails": flexDetails!.toJson(),
  };
}