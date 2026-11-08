import 'package:dio/dio.dart';
import 'package:jdonut/core/models/dio_error_response.dart';

import 'failure.dart';

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class DioExceptions {
  late String message;
  late Failure failure;

  DioExceptions.fromDioError(DioException dioError) {
    int? statusCode = dioError.response?.statusCode;

    switch (dioError.type) {
      case DioExceptionType.badResponse:
        if (dioError.response?.data == null) {
          message = dioError.response?.statusMessage ?? 'Unknown error';
          failure = ServerFailure('$statusCode', message);
          break;
        }
        try {
          final dioErrorResponse = DioErrorResponse.fromJson(dioError.response?.data);
          message = _handleError(statusCode, dioErrorResponse);
          if (statusCode == 401) {
            failure = UnauthorizedFailure('$statusCode', message);
          } else {
            failure = ServerFailure('$statusCode', message);
          }
        } catch (e) {
          message = dioError.response?.statusMessage ?? 'Unknown error';
          failure = ServerFailure('$statusCode', message);
        }
        break;

      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        failure = ConnectionFailure('Request Cancelled', message);
        break;

      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        failure = ConnectionFailure('Check network connections', message);
        break;

      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        failure = ConnectionFailure('Check network connections', message);
        break;

      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        failure = ConnectionFailure('Check network connections', message);
        break;

      case DioExceptionType.unknown:
        message = "Unknown! Internal Server Occur";
        failure = UnknownFailure('Unknown Error', message);
        break;

      case DioExceptionType.connectionError:
        message = "Unavailable! Unable to Locate Host";
        failure = UnknownFailure('Server Error', message);
        break;

      default:
        message = 'Oops something went wrong';
        failure = UnknownFailure("Error", message);
        break;
    }
  }
  String _handleError(int? statusCode, DioErrorResponse? response) {
    switch (statusCode) {
      // 4xx Client errors
      case 400:
        return response?.message ?? 'Bad request';
      case 401:
        return response?.message ?? 'Unauthorized User';
      case 403:
        return response?.message ?? 'Forbidden';
      case 404:
        return response?.message ?? 'Not Found';
      case 405:
        return 'Method not allowed';
      case 408:
        return 'Request timeout';
      case 409:
        return 'Conflict';
      case 410:
        return 'Gone';
      case 411:
        return 'Length required';
      case 413:
        return 'Payload too large';
      case 414:
        return 'URI too long';
      case 415:
        return 'Unsupported media type';
      case 419:
        return response?.message ?? 'Session expired';
      case 422:
        return response?.message ?? 'Validation error';
      case 429:
        return response?.message ?? 'Too many requests';

      // 5xx Server errors
      case 500:
        return 'Internal server error';
      case 501:
        return 'Not implemented';
      case 502:
        return 'Bad gateway';
      case 503:
        return response?.error?.message ?? 'Service unavailable';
      case 504:
        return 'Gateway timeout';
      case 507:
        return 'Insufficient storage';
      case 511:
        return 'Network authentication required';

      default:
        return 'Oops, something went wrong (${statusCode ?? 'unknown'})';
    }
  }

  @override
  String toString() => message;

  Failure toFailure() => failure;
}
