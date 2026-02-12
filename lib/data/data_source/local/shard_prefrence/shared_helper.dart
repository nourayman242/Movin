import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static const String _onboardingKey = 'onboarding_seen';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userRoleKey = 'user_role';

  //ONBOARDING

  //set wheter the user has already seen the onboarding screens or not
  static Future<void> setOnboardingSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, value);
  }

  //get the onboarding seen status
  static Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }
  //AUTHENTICATION

  // Set login state.
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Get login state   edf false
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  //USER ROLE

  // buter or seller ?
  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  //return buyer or seller
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  // clear role because of switching roles
  static Future<void> clearUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRoleKey);
  }

  //LOGGEING OUT
  //clear all because of the logging out
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    //may remove onboarding
    await prefs.remove(_onboardingKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userRoleKey);
  }
  // saved token after login
  static Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
static Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}


}
