import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/future-values.dart';
import '../model/flex.dart';
import '../model/user.dart';
import 'endpoints.dart';
import 'error-handler.dart';
import 'network-util.dart';

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
  Future<Flexes> createFlex (Map<String, dynamic> body) async {
    String? userId;
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = '61ab5ab0386a493342509fd2';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = '${prefs.getString('bearerToken')}';
    });
    print(header);
    return _netUtil.post(CREATE_A_FLEX+'$userId', headers: header, body: body).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['message'];
      return Flexes.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }
}