import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/future-values.dart';
import '../model/flex-success.dart';
import '../model/flex.dart';
import '../model/user.dart';
import 'endpoints.dart';
import 'error-handler.dart';
import 'network-util.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class FlexDataSource {
  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  final _netUtil = NetworkHelper();

  /// Instantiating a class of the [FutureValues]
  final _futureValue = FutureValues();

  /// A function that sends request for sign in with [body] as details
  /// A post request to use the [CREATE_A_FLEX]
  /// It returns a [] model
  Future<FlexSuccess> createFlex (/*File uploads, Map<String, dynamic>*/ body) async {
    String? userId;
    List<http.MultipartFile> bannerImage = [];
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = '623c5f6bc8833e68854c9013';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    // bannerImage.add(
    //     await http.MultipartFile.fromPath('bannerImage', uploads.path),
    // );
    return _netUtil.post(CREATE_A_FLEX+'$userId', /*[bannerImage[0]]*/ headers: header, body: body).then((res) {
      if(res['status'] != 'success') throw res['message'];
      print (res['data']);
      return FlexSuccess.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for joining a flex
  /// A get request to use the [JOIN_FLEX]
  /// It returns a [] model
  Future<Flexes> joinFlex (String flexId) async {
    String? userId;
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = '627dbd766574da21c342819d';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
    });
    String JOIN_FLEX_URL = JOIN_FLEX+'$flexId/join';
    print(JOIN_FLEX_URL);
    print(header);
    return _netUtil.get(JOIN_FLEX_URL, headers: header).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['data'];
      return Flexes.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

}