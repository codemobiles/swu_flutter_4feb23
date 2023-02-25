import 'package:dio/dio.dart';

import '../constants/network_api.dart';

class NetworkService {
  int count = 0;

  // Singleton
  NetworkService._internal(); // SomeService();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = NetworkAPI.baseURL;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // await Future.delayed(Duration(seconds: 10));
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          switch (e.response?.statusCode) {
            case 301:
              break;
            case 401:
              break;
            default:
          }
          return handler.next(e);
        },
      ),
    );

  method1() {
    count++;
    print("Count: $count");
  }
}
