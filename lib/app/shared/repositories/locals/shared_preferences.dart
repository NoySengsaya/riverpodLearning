import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:talker/talker.dart';

import '../../../../dp.dart';
import '../../../../env_config.dart';
import '../../utils/encrypt.dart';
import 'const.dart';
import 'secure_storage.dart';

abstract class SharedPrefsRepository {
  // save access token
  Future<void> saveToken(String token);

  // get access token
  Future<String> getToken();

  // save access models
  Future<void> saveAccessModel(RecordModel model);

  // get accesss models
  Future<RecordModel?> getAccessModel();

  // save uid
  Future<void> saveUid(String uid);

  // get uid
  Future<String> getUid();

  // delete all
  // for logging out
  Future<void> deleteAll();
}

class SharedPrefsRepositoryImpl extends SharedPrefsRepository {
  SharedPrefsRepositoryImpl(this.secureRepo);

  // secure storage
  final SecureStorageRepository secureRepo;

  // hive preferences box
  final prefsBox = Hive.box('prefs-${Env.envName}');

  final t = dp.get<Talker>();

  @override
  Future<void> deleteAll() async {
    try {
      await prefsBox.clear();
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  @override
  Future<void> saveUid(String uid) async {
    try {
      await setEncrypted(PrefsKey.uid, uid);
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  @override
  Future<String> getUid() async {
    try {
      return await getEncrypted(PrefsKey.uid) ?? '';
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  Future<String?> getEncrypted(String key) async {
    try {
      final secret = await secureRepo.readEncryptionPhrase();
      if (secret == '') {
        return null;
      } else {
        final enc =
            Salsa20Encryptor(secret.split(':')[0], secret.split(':')[1]);
        final encData = await prefsBox.get(key) as String?;
        if (encData != null) {
          return enc.decrypt(encData);
        } else {
          return null;
        }
      }
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  Future<void> setEncrypted(String key, String value) async {
    try {
      var secret = await secureRepo.readEncryptionPhrase();
      if (secret == '') {
        secret =
            '${Salsa20Encryptor.generateEncryptionSecret(16)}:${Salsa20Encryptor.generateEncryptionSecret(8)}';
        await secureRepo.writeEncryptionPhrase(secret);
      } else {
        final enc =
            Salsa20Encryptor(secret.split(':')[0], secret.split(':')[1]);
        await prefsBox.put(key, enc.encrypt(value));
      }
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  @override
  Future<RecordModel?> getAccessModel() async {
    try {
      final jsonData = await prefsBox.get(PrefsKey.appAccessModels);
      if (jsonData != null) {
        final data = RecordModel.fromJson(json.decode(jsonData));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      t.error(e);
      return null;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      return await getEncrypted(PrefsKey.appAccessToken) ?? '';
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  @override
  Future<void> saveAccessModel(RecordModel model) async {
    try {
      await prefsBox.put(PrefsKey.appAccessModels, model.toString());
    } catch (e) {
      t.error(e);
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await setEncrypted(PrefsKey.appAccessToken, token);
    } catch (e) {
      rethrow;
    }
  }
}
