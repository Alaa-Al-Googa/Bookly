import 'dart:io';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure("Connection timeout with API server");

      case DioErrorType.sendTimeout:
        return ServerFailure("Send timeout with API server");

      case DioErrorType.receiveTimeout:
        return ServerFailure("Receive timeout with API server");

      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioErrorType.cancel:
        return ServerFailure("Request to API server was cancelled");

      case DioErrorType.unknown:
        if (dioError.message?.contains("SocketException") ?? false) {
          return ServerFailure("No Internet Connection");
        }
        return ServerFailure("Unexpected error, please try again!");

      default:
        return ServerFailure("Oops! There was an error, please try again.");
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerFailure("Your request not found, please try later!");
    } else if (statusCode == 500) {
      return ServerFailure("Internal Server error, please try later!");
    } else {
      return ServerFailure("Oops! There was an error, please try again.");
    }
  }
}
