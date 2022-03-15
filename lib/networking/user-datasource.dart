import '../bloc/future-values.dart';
import '../model/user.dart';
import 'endpoints.dart';
import 'error-handler.dart';
import 'network-util.dart';

class UserDataSource {

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  final _netUtil = NetworkHelper();

  /// Instantiating a class of the [FutureValues]
  final _futureValue = FutureValues();

  /// A function that sends request for sign in with [body] as details
  /// A post request to use the [LOGIN]
  /// It returns a [User] model
  Future<dynamic> signIn (Map<String, String> body) {
    return _netUtil.post(LOGIN, headers: {}, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return User.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for forgot password with [body] as details
  /// A post request to use the [FORGOT_PASSWORD]
  /// It returns a [String_Message] model
  Future<dynamic> forgotPassword (Map<String, String> body) {
    return _netUtil.post(FORGOT_PASSWORD, headers: {}, body: body).then((dynamic res) {
      if(res['error']) throw res['message'];
      print(res);
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

}