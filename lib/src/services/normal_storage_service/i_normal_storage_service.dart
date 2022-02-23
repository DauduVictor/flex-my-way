import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'get_storage_service_impl.dart';

abstract class INormalStorageService {
  Future<void> write({required String key, required dynamic value});

  T? read<T>({required String key});

  Future<void> delete({required String key});
}

final keyValueStorageService = Provider<INormalStorageService>(
  (ref) => GetStorageServiceImpl(),
);
