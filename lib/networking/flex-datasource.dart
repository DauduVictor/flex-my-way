import '../bloc/future-values.dart';
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
  Future<dynamic> createFlex (Map<String, dynamic> body) async {
    String? userId;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = '1234';
    });
    print(CREATE_A_FLEX+'$userId');
    return _netUtil.post(CREATE_A_FLEX+'$userId', headers: {}, body: body).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['data'];
      return null;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }
}