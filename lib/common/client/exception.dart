

class CacheException implements Exception {
  final String? message;

  CacheException({this.message});
}

class ServerException implements Exception {
  final int? errorCode;
  final dynamic error;

  ServerException({this.errorCode, this.error});
}
class NetworkException implements Exception{
  final String? message;

  NetworkException({this.message});
}
