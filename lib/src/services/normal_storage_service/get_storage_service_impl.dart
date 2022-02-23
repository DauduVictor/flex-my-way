import 'package:get_storage/get_storage.dart';
import 'package:flex_my_way/src/services/normal_storage_service/i_normal_storage_service.dart';

class GetStorageServiceImpl implements INormalStorageService {
  final _getStorage = GetStorage();
  @override
  Future<void> write({required String key, required dynamic value}) async {
    await _getStorage.write(key, value);
  }

  @override
  T? read<T>({required String key}) {
    return _getStorage.read(key);
  }

  @override
  Future<void> delete({required String key}) async {
    return await _getStorage.remove(key);
  }
}
