import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // GET y SET del género
  Future<int> get genero async {
    String? generoStr = await _storage.read(key: 'genero');
    return generoStr != null ? int.parse(generoStr) : 1;
  }

  Future<void> setGenero(int value) async {
    await _storage.write(key: 'genero', value: value.toString());
  }

  // GET y SET del color secundario
  Future<bool> get colorSecundario async {
    String? colorStr = await _storage.read(key: 'colorSecundario');
    return colorStr != null ? colorStr == 'true' : false;
  }

  Future<void> setColorSecundario(bool value) async {
    await _storage.write(key: 'colorSecundario', value: value.toString());
  }

  // GET y SET del nombre de usuario
  Future<String> get nombreUsuario async {
    return await _storage.read(key: 'nombreUsuario') ?? '';
  }

  Future<void> setNombreUsuario(String value) async {
    await _storage.write(key: 'nombreUsuario', value: value);
  }

  // GET y SET de la última página
  Future<String> get ultimaPagina async {
    return await _storage.read(key: 'ultimaPagina') ?? 'home';
  }

  Future<void> setUltimaPagina(String value) async {
    await _storage.write(key: 'ultimaPagina', value: value);
  }
}
