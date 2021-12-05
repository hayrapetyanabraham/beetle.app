class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://api.dev.beetle.am:8002";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getUser = baseUrl + "/posts";

  static const String postGetToken = baseUrl + "/authority/passenger/token";
}