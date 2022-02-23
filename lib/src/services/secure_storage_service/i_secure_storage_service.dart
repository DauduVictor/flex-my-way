import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'flutter_secure_storage_impl.dart';

abstract class ISecureStorageService {
  Future<void> writeString(String key, String value);

  Future<String?> readString(String key);

  Future<void> deleteString(String key);
}

final secureStorageService = Provider<ISecureStorageService>(
  (ref) => FlutterSecureStorageImpl(),
);
