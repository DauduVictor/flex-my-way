import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flex_my_way/src/services/base/api.dart';
import 'package:flex_my_way/src/services/network_service/http_service_impl.dart';

abstract class INetworkService {
  API get getAPI;

  Future<dynamic> get(Uri uri);

  Future<dynamic> post(
    Uri uri, {
    required Map<String, dynamic> inputJson,
    Map<String, String>? headers,
  });

  Future<dynamic> put(
    Uri uri, {
    required Map<String, dynamic> inputJson,
  });

  Future<dynamic> delete(Uri uri);
}

final networkService = Provider<INetworkService>(
  (ref) => HttpServiceImpl(),
);
