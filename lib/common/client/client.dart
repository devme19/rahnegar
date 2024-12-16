import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/common/base_data_sources/base_local_data_source.dart';
import 'package:rahnegar/locator.dart';

import '../utils/constants.dart';
import 'interceptors/refresh_token_interceptors.dart';

class Client {
  static final Client _client = Client._internal();


  factory Client() {
    return _client;
  }
  Client._internal();
  Dio dio = Dio();
  init() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.headers['content-Type'] = 'application/json';
    // String token = getToken();
    // if(token.isNotEmpty) {
    //   dio.options.headers['Authorization']='Bearer $token';
    // }
    _initializeInterceptors();
  }

  _initializeInterceptors() {
    // dio.interceptors.add(RefreshTokenInterceptor(baseLocalDataSource: Get.find()));
    dio.interceptors.add(RefreshTokenInterceptor(baseLocalDataSource: locator<BaseLocalDataSource>()));
    // dio.interceptors.add(ConnectivityInterceptor(Connectivity()));
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    //     String token = box!.read("authToken");
    //     if (token != null) options.headers['token'] = '$token';
    //     return handler.next(options);
    //   },
    // ));
    // dio.interceptors.add(RefreshTokenInterceptor());
    // dio.interceptors.add(RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //         connectivity: Connectivity(),
    //         dio: dio
    //     )
    // ));
  }
}
