import 'package:dio/dio.dart';
import 'package:stream_weather/src/core/dio/dio_client_options.dart';
import 'package:stream_weather/src/core/dio/dio_exceptions.dart';
/// A class representing an HTTP client wrapper using Dio.
class DioClient {
  /// Creates an instance of [DioClient].
  ///
  /// [dio] is an optional Dio instance that can be provided, and [options] is
  /// an optional set of client options. If not provided, default options from
  /// [DioClientOptions] will be used.
  DioClient({Dio? dio, DioClientOptions? options})
      : _options = options ?? const DioClientOptions(),
        dioClient = dio ?? Dio() {
    dioClient
      ..options.baseUrl = _options.baseUrl
      ..options.connectTimeout = _options.connectTimeout
      ..options.receiveTimeout = _options.receiveTimeout
      ..options.queryParameters = _options.queryParameters
      ..options.headers = _options.headers
      ..interceptors.add(LogInterceptor(responseBody: true));
  }

  /// The Dio instance used for making HTTP requests.
  final Dio dioClient;

  /// The client options for configuring the Dio client.
  final DioClientOptions _options;

  /// Performs an HTTP GET request.
  ///
  /// [path] is the URL path to the resource, and [queryParameters] is an
  /// optional map of query parameters to include in the request.
  ///
  /// Returns a Future with the HTTP response.
  Future<Response<T>> get<T>(String path,
      {Map<String, Object?>? queryParameters}) async {
    try {
      return await dioClient.get<T>(path, queryParameters: queryParameters);
    } on DioExceptionType catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}

