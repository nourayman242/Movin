import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SettingsLocalService {
  static const _languageKey = 'language';
  static const _pushKey = 'push_notifications';
  static const _emailKey = 'email_notifications';
  static const _alertsKey = 'property_alerts';

  Future<void> saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, value);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  Future<void> savePush(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_pushKey, value);
  }

  Future<bool> getPush() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_pushKey) ?? true;
  }

  Future<void> saveEmail(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_emailKey, value);
  }

  Future<bool> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_emailKey) ?? false;
  }

  Future<void> saveAlerts(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_alertsKey, value);
  }

  Future<bool> getAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_alertsKey) ?? true;
  }
}
