import 'package:dio/dio.dart';

abstract class Failure {
  final String? message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request to API server was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(
            message: 'Error occurred while connecting to the server');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'Unexpected error occurred');
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic Response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: Response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          message: 'Your request is not found , Please try later');
    } else if (statusCode == 500) {
      return ServerFailure(
          message: 'there is problem with server , Please try later');
    } else {
      return ServerFailure(message: 'There was an erorr , Please try again');
    }
  }
}
