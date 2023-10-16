class RouteNotFoundException implements Exception {
  final String message;
  const RouteNotFoundException(this.message);

  @override
  String toString() => message;
}