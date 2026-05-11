class TokenCache {
  static String? accessToken;
  static String? refreshToken;

  // optional helper
  static void clear() {
    accessToken = null;
    refreshToken = null;
  }
}