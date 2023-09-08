import 'package:dio/dio.dart';

/// An exception class for handling Dio HTTP request errors.
class DioExceptions implements Exception {

  /// Constructs a [DioExceptions] instance from a Dio error [dioError].
  ///
  /// This constructor maps Dio error types to human-readable error messages.
  DioExceptions.fromDioError(DioExceptionType dioError) {
    switch (dioError) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        message = 'Unexpected error occurred';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioExceptionType.badCertificate:
        message = 'Unexpected error occurred';
        break;
      default:
        message = 'Something went wrong';
    }
  }
  /// The error message associated with the exception.
  late String message;

  @override
  String toString() => message;
}
