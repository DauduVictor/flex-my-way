import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/future-values.dart';
import 'networking.dart';
import 'package:flex_my_way/model/model.dart';

/// Class to hold all function for [UserDataSource]
class UserDataSource {

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  final _netUtil = NetworkHelper();

  /// Instantiating a class of the [FutureValues]
  final _futureValue = FutureValues();

  Map<String, String> header = {
    'Content-Type' : 'application/json'
  };

  /// A function that sends request for sign in with [body] as details
  /// A post request to use the [LOGIN]
  /// It returns a [User] model
  Future<User> signIn (Map<String, String> body) {
    return _netUtil.post(LOGIN, headers: header, body: body).then((res) {
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
    header['Accept'] = '*/*';
    return _netUtil.post(NEW_USER_SIGNUP, headers: header, body: body).then((res) {
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
    return _netUtil.post(FORGOT_PASSWORD, headers: header, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['message'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for reset password with [body] as details
  /// A post request to use the [RESET_PASSWORD]
  /// It returns a [String_Message]
  Future<dynamic> resetPassword (Map<String, String> body) async {
    return _netUtil.post(RESET_PASSWORD, headers: header, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for reset password with [body] as details
  /// A post request to use the [RESET_PASSWORD_WITH_ID]
  /// It returns a [String_Message]
  Future<dynamic> editPassword (Map<String, String> body) async  {
    Map<String, String> header = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
    header['Content-Type'] = 'application/json';
    header['Accept'] = '*/*';
    return _netUtil.post(EDIT_PASSWORD, headers: header, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['message'];
      return (res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for update user details with [body] as details
  /// A post request to use the [UPDATE_USER_INFO]
  /// It returns a [String_Message]
  Future<User> updateUserInfo (Map<String, dynamic> body) async {
    Map<String, String> header = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
    header['Content-Type'] = 'text/plain';
    header['Accept'] = '*/*';
    return _netUtil.put(UPDATE_USER_INFO, headers: header, body: body).then((dynamic res) {
      if(res['status'] != 'success') throw res['data'];
      return User.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for update user details with [body] as details
  /// A post request to use the [UPDATE_USER_INFO]
  /// It returns a [String_Message]
  Future<dynamic> deleteNotification (String id) async {
    String? userId;
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
    });
    print(header);
    String DELETE_NOTIFICATION_URL = DELETE_NOTIFICATION + '$id/delete';
    return _netUtil.delete(DELETE_NOTIFICATION_URL, headers: header).then((res) {
      log(':::deleteNotification: $res');
      if(res['status'] != 'success') throw res['message'];
      return res['data'];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

}