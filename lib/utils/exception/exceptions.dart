class ServerException implements Exception {
  static String get getServerErrorMessage => "Server error occurred";
}

class CacheException implements Exception {
  static String get getCacheErrorMessage => "Server error occurred";
}
