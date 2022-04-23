import '../bloc/future-values.dart';
import '../model/user.dart';
import 'endpoints.dart';
import 'error-handler.dart';
import 'network-util.dart';

/// Class to hold all function for [UserDataSource]
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
  Future<User> signIn (Map<String, String> body) {
    return _netUtil.post(LOGIN, headers: {}, body: body).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['data'];
      return User.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for sign in with [body] as details
  /// A post request to use the [NEW_USER_SIGNUP]
  /// It returns a string message
  Future<dynamic> signUp (Map<String, String> body) {
    return _netUtil.post(NEW_USER_SIGNUP, headers: {}, body: body).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['message'];
      return res['message'];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for forgot password with [body] as details
  /// A post request to use the [FORGOT_PASSWORD]
  /// It returns a [String_Message]
  Future<dynamic> forgotPassword (Map<String, String> body) {
    return _netUtil.post(FORGOT_PASSWORD, headers: {}, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for reset password with [body] as details
  /// A post request to use the [RESET_PASSWORD]
  /// It returns a [String_Message]
  Future<dynamic> resetPassword (Map<String, String> body) async {
    return _netUtil.post(RESET_PASSWORD, headers: {}, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for reset password with [body] as details
  /// A post request to use the [RESET_PASSWORD_WITH_ID]
  /// It returns a [String_Message]
  Future<dynamic> resetPasswordWithId (Map<String, String> body) {
    return _netUtil.post(RESET_PASSWORD_WITH_ID, headers: {}, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for update user details with [body] as details
  /// A post request to use the [UPDATE_USER_INFO]
  /// It returns a [String_Message]
  Future<dynamic> updateUserInfo (Map<String, dynamic> body) async {
    String? userId;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = '1234';
    });
    print(body);
    String UPDATE_USERS_INFO = BASE_URL+'users/$userId'+UPDATE_USER_INFO;
    print(UPDATE_USERS_INFO);
    return _netUtil.put(UPDATE_USERS_INFO, headers: {}, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

}