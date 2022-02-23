import 'dart:convert';
import 'dart:io';

import 'package:flex_my_way/src/services/base/api.dart';
import 'package:flex_my_way/src/services/network_service/i_network_service.dart';
import 'package:http/http.dart' as http;
import 'package:flex_my_way/src/shared/models/failure.dart';
import 'package:flex_my_way/src/shared/models/http_service_exception.dart';

class HttpServiceImpl implements INetworkService {
  @override
  API get getAPI => API();

  void _throwOnFail(http.Response res) {
    if (res.statusCode != HttpStatus.ok &&
        res.statusCode != HttpStatus.created) {
      final errorString = res.body;

      final exception = HttpServiceException.fromJson(json.decode(errorString));

      throw exception;
    }
  }

  @override
  Future<dynamic> get(Uri uri) async {
    try {
      final response = await http.get(uri);
      _throwOnFail(response);
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('Please check your internet connection');
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<dynamic> post(
    Uri uri, {
    required Map<String, dynamic> inputJson,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(uri, body: inputJson, headers: headers);
      _throwOnFail(response);
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('Please check your internet connection');
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<dynamic> put(
    Uri uri, {
    required Map<String, dynamic> inputJson,
  }) async {
    try {
      final response = await http.put(uri, body: inputJson);

      _throwOnFail(response);
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('Please check your internet connection');
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<dynamic> delete(Uri uri) async {
    try {
      final response = await http.delete(uri);
      _throwOnFail(response);
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('Please check your internet connection');
    } on FormatException {
      throw Failure('Bad response format');
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
