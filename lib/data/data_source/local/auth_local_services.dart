import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AuthLocalService {
 
 static Future<void> clearAll() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

}
