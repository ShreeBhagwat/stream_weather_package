/// The base URL for the OpenWeatherMap API.
const String kBaseUrl = 'https://api.openweathermap.org';

/// A class representing options for the Dio HTTP client.
class DioClientOptions {
  /// Creates an instance of [DioClientOptions].
  ///
  /// [baseUrl] is the base URL for the API, [connectTimeout] is the maximum
  /// amount of time to wait for a connection to be established, [receiveTimeout]
  /// is the maximum amount of time to wait for data to be received, [queryParameters]
  /// is a map of query parameters to include in the request, and [headers] is
  /// a map of HTTP headers to include in the request.
  const DioClientOptions({
    String? baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.queryParameters = const {},
    this.headers = const {},
  }) : baseUrl = baseUrl ?? kBaseUrl;
  
  /// The base URL for the API.
  final String baseUrl;

  /// The maximum amount of time to wait for a connection to be established.
  final Duration connectTimeout;

  /// The maximum amount of time to wait for data to be received.
  final Duration receiveTimeout;

  /// A map of query parameters to include in the request.
  final Map<String, Object?> queryParameters;

  /// A map of HTTP headers to include in the request.
  final Map<String, Object?> headers;
}

