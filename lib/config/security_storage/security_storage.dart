import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecurityStorage {
  final FlutterSecureStorage _secureStorage;

  SecurityStorage(this._secureStorage);

  Future<void> setSecuredString(String key, String value) async {
    log("FlutterSecureStorage : setSecuredString with key : $key");
    await _secureStorage.write(key: key, value: value);
  }

  Future<String> getSecuredString(String key) async {
    log('FlutterSecureStorage : getSecuredString with key : $key');
    return await _secureStorage.read(key: key) ?? '';
  }

  Future<void> setSecuredBool(String key, bool value) async {
    log("FlutterSecureStorage: setSecuredBool key: $key value: $value");
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<bool> getSecuredBool(String key) async {
    log("FlutterSecureStorage: getSecuredBool key: $key");
    String? value = await _secureStorage.read(key: key);
    return value == 'true';
  }

  Future<void> deleteSecuredString(String key) async {
    log('FlutterSecureStorage : deleteSecuredString with key : $key');
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAllSecuredData() async {
    log('FlutterSecureStorage : all data has been cleared');
    await _secureStorage.deleteAll();
  }
}
