import 'dart:io';

import 'package:dio/dio.dart';

extension DioErrorX on DioError { // Therefore isNoConnectionError method adds to DioError because DioError has not isNoConnectionError method by default 
  bool get isNoConnectionError {
    return type == DioErrorType.other && error is SocketException;
  }
}
