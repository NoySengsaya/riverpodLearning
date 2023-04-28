import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'const.dart';

abstract class SecureStorageRepository {
  // write
  Future<String> write(String key, String value);

  // read
  Future<String> read(String key);

  // write encryption phrase
  Future<String> writeEncryptionPhrase(String secret);

  // read encryption phrase
  Future<String> readEncryptionPhrase();

  // delete all
  Future<void> deleteAll();
}

class SecureStorageRepositoryImpl extends SecureStorageRepository {
  SecureStorageRepositoryImpl({required this.storage});

  final FlutterSecureStorage storage;

  @override
  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }

  @override
  Future<String> read(String key) async {
    return await storage.read(key: key) ?? '';
  }

  @override
  Future<String> readEncryptionPhrase() async {
    return await read(VaultKeys.encPhrase);
  }

  @override
  Future<String> write(String key, String value) async {
    await storage.write(key: key, value: value);
    return value;
  }

  @override
  Future<String> writeEncryptionPhrase(String secret) async {
    return await write(VaultKeys.encPhrase, secret);
  }
}
