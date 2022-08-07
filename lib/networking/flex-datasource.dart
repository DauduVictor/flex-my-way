import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/future-values.dart';
import 'networking.dart';
import 'package:flex_my_way/model/model.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class FlexDataSource {
  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  final _netUtil = NetworkHelper();

  /// Instantiating a class of the [FutureValues]
  final _futureValue = FutureValues();



  /// A function that gets the dashboard flexes
  /// A get request to use the [GET_DASHBOARD_FLEX]
  /// It returns a [List<Flexes>] model
  Future<List<DashboardFLex>> getDashboardFlex(String filter) async {
    String? userId;
    Map<String, String> header = {};
    List<DashboardFLex> flexes;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    return _netUtil.get(GET_DASHBOARD_FLEX+'?filter=$filter', headers: header).then((res) {
      print(':::getDashboardFlex: $res');
      if(res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      flexes = rest.map<DashboardFLex>((json) => DashboardFLex.fromJson(json)).toList();
      return flexes;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that gets the history flexes
  /// A get request to use the [GET_FLEX_HISTORY]
  /// It returns a [List<Flexes>] model
  Future<List<HistoryFlex>> getFlexHistory(String filter) async {
    String? userId;
    Map<String, String> header = {};
    List<HistoryFlex> flexes;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    print(header);
    print(GET_FLEX_HISTORY);
    return _netUtil.get(GET_FLEX_HISTORY+'?filter=$filter', headers: header).then((res) {
      print(':::getFlexHistory: $res');
      if(res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      flexes = rest.map<HistoryFlex>((json) => HistoryFlex.fromJson(json)).toList();
      return flexes;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that gets the notifications
  /// A get request to use the [GET_NOTIFICATION]
  /// It returns a [List<Notification>] model
  Future<List<Notification>> getNotifications(String filter) async {
    String? userId;
    Map<String, String> header = {};
    List<Notification> notifications;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    return _netUtil.get(GET_NOTIFICATION, headers: header).then((res) {
      log(':::getNotification: $res');
      if(res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      notifications = rest.map<Notification>((json) => Notification.fromJson(json)).toList();
      return notifications;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that gets the notifications
  /// A get request to use the [GET_FLEX_INVITEES]
  /// It returns a [List<Notification>] model
  Future<List<FlexInvite>> getFlexInvites() async {
    String? userId;
    Map<String, String> header = {};
    List<FlexInvite> flexInvites;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    return _netUtil.get(GET_FLEX_INVITEES, headers: header).then((res) {
      log(':::getFlexInvites: $res');
      if(res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      flexInvites = rest.map<FlexInvite>((json) => FlexInvite.fromJson(json)).toList();
      return flexInvites;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that created flex with [body] as details
  /// A post request to use the [CREATE_A_FLEX]
  /// It returns a [FlexSuccess] model
  Future<FlexSuccess> createFlex(File uploads, Map<String, String> body) async {
    String? userId;
    List<http.MultipartFile> bannerImage = [];
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    bannerImage.add(
        await http.MultipartFile.fromPath('bannerImage', uploads.path),
    );
    return _netUtil.postForm(CREATE_A_FLEX+'$userId', [bannerImage[0]], header: header, body: body).then((res) {
      if(res['status'] != 'success') throw res['message'];
      print (res['data']);
      return FlexSuccess.fromJson(res['data']);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that edit flex with [body] as details
  /// A post request to use the [UPDATE_A_FLEX]
  /// It returns a [] model
  Future<dynamic> editFlex(File? uploads, Map<String, String> body, String code ) async {
    String? userId;
    List<http.MultipartFile> bannerImage = [];
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    print(uploads?.length());
    if (uploads != null) {
      bannerImage.add(
        await http.MultipartFile.fromPath('bannerImage', uploads.path),
      );
      return _netUtil.putForm(UPDATE_A_FLEX+'$code/update', [bannerImage[0]], header: header, body: body).then((res) {
        if(res['status'] != 'success') throw res['message'];
        print (res['data']);
        return 'done';
      }).catchError((e){
        errorHandler.handleError(e);
      });
    }
    else {
      return _netUtil.putForm(UPDATE_A_FLEX+'$code/update', [], header: header, body: body).then((res) {
        if(res['status'] != 'success') throw res['message'];
        print (res['data']);
        return 'done';
      }).catchError((e){
        errorHandler.handleError(e);
      });
    }
  }

  /// A function that sends request for joining a flex
  /// A get request to use the [GET_FLEX_DETAILS]
  /// It returns a [List<Flexes>] model
  Future<Flexes> getFlexDetails(String flexCode) async {
    Map<String, String> header = {};
    Flexes flexes;
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
    });
    String GET_FLEX_DETAILS_URL = GET_FLEX_DETAILS + '$flexCode/get';
    return _netUtil.get(GET_FLEX_DETAILS_URL, headers: header).then((res) {
      print(':::getFlexDetails: $res');
      if(res['status'] != 'success') throw res['data'];
      flexes = Flexes.fromJson(res['data']);
      return flexes;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for joining a flex
  /// A get request to use the [JOIN_FLEX]
  /// It returns a [] model
  Future<dynamic> joinFlex(String flexId) async {
    String? userId;
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
    });
    String JOIN_FLEX_URL = JOIN_FLEX+'$flexId/join';
    return _netUtil.get(JOIN_FLEX_URL, headers: header).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['data'];
      return res['data'];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for joining a flex
  /// A get request to use the [GET_FLEX_BY_LOCATION]
  /// It returns a [List<Flexes>] model
  Future<List<Flexes>> getFlexByLocation(double lat, double long, {String? ageStatus, String? payStatus}) async {
    Map<String, String> header = {};
    List<Flexes> flexes;
    String? payParam;
    String? ageParam;
    // Future<User> user = _futureValue.getCurrentUser();
    // await user.then((value) async {
    //   // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
    //   header['Content-Type'] = 'text/plain';
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
    header['Content-Type'] = 'text/plain';
   switch(payStatus) {
     case "free":
       payParam = '&payStatus=Free';
       break;
     case "paid":
       payParam = '&payStatus=Paid';
       break;
   }
    switch(ageStatus) {
      case "18+":
        ageParam = '&ageRating=18+';
        break;
      case "18-":
        ageParam = '&ageRating=18%2B';
        break;
    }
    String GET_FLEX_BY_LOCATION_URL = GET_FLEX_BY_LOCATION + 'lat=$lat&lng=$long$payParam$ageParam';
    print(GET_FLEX_BY_LOCATION_URL);
    print(header);
    return _netUtil.get(GET_FLEX_BY_LOCATION_URL, headers: header).then((res) {
      print(':::getFlexByLocation: $res');
      if(res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      flexes = rest.map<Flexes>((json) => Flexes.fromJson(json)).toList();
      return flexes;
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for joining a flex
  /// A post request to use the [APPROVE_ATTENDEE]
  /// It returns a dynamic response
  Future<dynamic> acceptAttendee(Map<String, dynamic> body) async {
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
    });
    String APPROVE_ATTENDEE_URL = APPROVE_ATTENDEE + 'approve';
    return _netUtil.post(APPROVE_ATTENDEE_URL, headers: header, body: [body]).then((res) {
      print(res);
      if(res['status'] != 'success') throw res['message'];
      return res['data'];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for joining a flex
  /// A post request to use the [APPROVE_ATTENDEE]
  /// It returns a dynamic response
  Future<dynamic> rejectAttendee(Map<String, dynamic> body) async {
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
    });
    String REJECT_ATTENDEE_URL = REJECT_ATTENDEE + 'reject';
    return _netUtil.post(REJECT_ATTENDEE_URL, headers: header, body: [body]).then((res) {
      log(':::rejectAttendee: $res');
      if(res['status'] != 'success') throw res['message'];
      return res['data'];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function to get flexery images
  /// A post request to use the [GET_FLEXERY]
  /// It returns a dynamic response
  Future<List<FlexeryModel>> getFlexeryByHashTag(String hashTag) async {
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    List<FlexeryModel> flexery= [];
    await user.then((value) async {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
    });
    if (hashTag.startsWith('#')) {
      hashTag = hashTag.replaceFirst('#', '');
    }
    String GET_FLEXERY_URL = GET_FLEXERY + '?search=$hashTag';
    log(GET_FLEXERY_URL);
    print(header);
    return _netUtil.get(GET_FLEXERY_URL, headers: header).then((res) {
      log(':::flexery: $res');
      if (res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      flexery = rest.map<FlexeryModel>((json) => FlexeryModel.fromJson(json)).toList();
      return flexery;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function to get flexery images
  /// A post request to use the [GET_FLEXERY]
  /// It returns a dynamic response
  Future<List<FlexeryModel>> getFlexery(String filter) async {
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    List<FlexeryModel> flexery= [];
    await user.then((value) async {
      // if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'application/json';
    });
    String GET_FLEXERY_URL = GET_FLEXERY + '?filter=$filter';
    log(GET_FLEXERY_URL);
    print(header);
    return _netUtil.get(GET_FLEXERY_URL, headers: header).then((res) {
      log(':::flexery: $res');
      if (res['status'] != 'success') throw res['data'];
      var rest = res['data'] as List;
      flexery = rest.map<FlexeryModel>((json) => FlexeryModel.fromJson(json)).toList();
      return flexery;
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that sends request for uploading flex [body] as details
  /// A post request to use the [ADD_FLEXERY]
  /// It returns a [] model
  Future<dynamic> addFlexery(List<http.MultipartFile> uploads, Map<String, String> body) async {
    String? userId;
    Map<String, String> header = {};
    Future<User> user = _futureValue.getCurrentUser();
    await user.then((value) async {
      if(value.id == null) throw ('No user currently logged in. Kindly logout and login again');
      userId = value.id;
      log(':::userId: $userId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      header['Authorization'] = 'Bearer ${prefs.getString('bearerToken')}';
      header['Content-Type'] = 'text/plain';
      header['Accept'] = '*/*';
    });
    return _netUtil.postForm(ADD_FLEXERY, uploads, header: header, body: body).then((res) {
      if(res['status'] != 'success') throw res['message'];
      print (res['data']);
      return res['data'];
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

}