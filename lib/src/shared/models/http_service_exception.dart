import 'failure.dart';

class HttpServiceException extends Failure {
  HttpServiceException({required this.isSuccess, required this.failureMessage})
      : super(failureMessage, success: isSuccess);

  final bool isSuccess;
  String failureMessage;

  factory HttpServiceException.fromJson(Map<String, dynamic> json) =>
      HttpServiceException(
        isSuccess: json["success"],
        failureMessage: json["message"],
      );
}
