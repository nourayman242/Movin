// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../api_services/user_response.dart';

// class SharedHelper {
//   static const String _onboardingKey = 'onboarding_seen';
//   static const String _isLoggedInKey = 'is_logged_in';
//   static const String _userRoleKey = 'user_role';

//   static const String _tokenKey = 'token';
//   static const String _userIdKey = 'user_id';

//   static const String _userKey = 'user';
//   static const String _refreshTokenKey = 'refresh_token';
//   // ONBOARDING

//   static Future<void> setOnboardingSeen(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_onboardingKey, value);
//   }

//   static Future<bool> isOnboardingSeen() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_onboardingKey) ?? false;
//   }

//   // AUTHENTICATION

//   static Future<void> setLoggedIn(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isLoggedInKey, value);
//   }

//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_isLoggedInKey) ?? false;
//   }
//   // USER ROLE

//   static Future<void> setUserRole(String role) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userRoleKey, role);
//   }

//   static Future<String?> getUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userRoleKey);
//   }

//   static Future<void> clearUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_userRoleKey);
//   }

//   // TOKEN

//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }

//   // USER ID

//   static Future<void> saveUserId(String userId) async { // ✅ added
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userIdKey, userId);
//   }

//   static Future<String?> getUserId() async { // ✅ added
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userIdKey);
//   }

//   //USER

//   static Future<void> saveUser(UserResponse? user) async {
//     if (user == null) return;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userKey, jsonEncode(user.toJson()));
//   }

//   static Future<UserResponse?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(_userKey);

//     if (jsonString == null) return null;

//     return UserResponse.fromJson(jsonDecode(jsonString));
//   }
//   static Future<String?> getEmail() async {
//   final user = await getUser();
//   return user?.email;
// }
//   //REFRESH TOKEN
//   static Future<void> saveRefreshToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_refreshTokenKey, token);
//   }

//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_refreshTokenKey);
//   }



//   // LOGOUT

//   static Future<void> clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     //may remove onboarding
//     await prefs.remove(_onboardingKey);
//     await prefs.remove(_tokenKey);
//     await prefs.remove(_refreshTokenKey);
//     await prefs.remove(_userKey);
//     await prefs.remove(_userIdKey);
//     await prefs.setBool(_isLoggedInKey, false);
//   }



// }

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_services/user_response.dart';

class SharedHelper {
  // ==============================
  // Keys
  // ==============================

  static const String _onboardingKey = 'onboarding_seen';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userRoleKey = 'user_role';

  // ✅ renamed for clarity
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  static const String _userIdKey = 'user_id';
  static const String _userKey = 'user';

  // ==============================
  // ONBOARDING
  // ==============================

  static Future<void> setOnboardingSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, value);
  }

  static Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  // ==============================
  // AUTH STATE
  // ==============================

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // ==============================
  // USER ROLE
  // ==============================

  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<void> clearUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRoleKey);
  }

  // ==============================
  // ACCESS TOKEN
  // ==============================

  // ✅ renamed from saveToken -> saveAccessToken
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  // ✅ renamed from getToken -> getAccessToken
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // ==============================
  // REFRESH TOKEN
  // ==============================

  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // ==============================
  // USER ID
  // ==============================

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // ==============================
  // USER OBJECT
  // ==============================

  static Future<void> saveUser(UserResponse? user) async {
    if (user == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<UserResponse?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);

    if (jsonString == null) return null;

    return UserResponse.fromJson(jsonDecode(jsonString));
  }

  static Future<String?> getEmail() async {
    final user = await getUser();
    return user?.email;
  }

  // ==============================
  // ✅ NEW: Save all auth data in one call
  // ==============================

  static Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required UserResponse user,
    required String userId,
    required String role,
  }) async {
    await saveToken(accessToken);
    await saveRefreshToken(refreshToken);
    await saveUser(user);
    await saveUserId(userId);
    await setUserRole(role);
    await setLoggedIn(true);
  }

  // ==============================
  // LOGOUT / CLEAR
  // ==============================

  // ✅ clears only auth-related data (recommended for logout)
  static Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userRoleKey);

    await prefs.setBool(_isLoggedInKey, false);
  }

  // ⚠️ clears EVERYTHING including onboarding
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}



