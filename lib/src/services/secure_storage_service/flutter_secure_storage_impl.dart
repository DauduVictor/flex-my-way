import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flex_my_way/src/services/secure_storage_service/i_secure_storage_service.dart';

class FlutterSecureStorageImpl implements ISecureStorageService {
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> writeString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> readString(String key) async {
    await _secureStorage.read(key: key);
  }

  @override
  Future<void> deleteString(String key) async {
    await _secureStorage.delete(key: key);
  }
}
