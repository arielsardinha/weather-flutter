final class Request {
  final String path;
  final Map<String, String>? query;

  Request({required this.path, this.query});
}
