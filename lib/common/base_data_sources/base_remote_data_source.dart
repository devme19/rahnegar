
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../client/client.dart';
import '../client/exception.dart';



abstract class BaseRemoteDataSource {
  Future<Response> get({String url, Map<String, dynamic> queryParameters});
  Future<Response> post({String url, Map<String, dynamic> body});
  Future<bool> delete({String url});
  Future<bool> requestMultiPart(
      {String url, FormData formData, ValueChanged<double> uploadedAmount});
}

class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  @override
  Future<bool> delete({String? url}) async {
    try {
      Response response = await Client().dio.delete(url!);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
            message: e.message);
      } else {
        throw ServerException(
            errorCode: e.response!.statusCode,
            error: e.response!.data);
      }
    }
  }

  @override
  Future<Response> get(
      {String? url, Map<String, dynamic>? queryParameters,Map<String,dynamic>? formData}) async {
    try {
        Response response = await Client().dio.request(url!,queryParameters:queryParameters??{},data: formData??{});
        return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException(
            message: e.message);
      } else
        if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: e.message);
      }
      else if (e.type == DioExceptionType.unknown){
          throw NetworkException(message: e.message);
        }
      else{
        throw ServerException(
            errorCode: e.response!.statusCode,
            error: e.response!.data);
      }
    }catch(e){
      print("errrrri:"+e.toString());
      throw NetworkException(
          message: e.toString());
    }
  }

  @override
  Future<Response> post({String? url, Map<String, dynamic>? body}) async {
    try {
      Response response = await Client().dio.post(url!, data: body!);
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException(
            message: e.error.toString());
      }
      if( e.type == DioExceptionType.unknown){
        throw ServerException(
            error: e.error.toString());
      }
      else {
        dynamic error = e.response!.data['error'];
        throw ServerException(
            errorCode: e.response!.statusCode,
            error: error);
      }
    }
  }

  @override
  Future<bool> requestMultiPart(
      {String? url,
        FormData? formData,
        ValueChanged<double>? uploadedAmount}) async {
    try {
      Response response = await Client().dio.post(url!, data: formData!,
          onSendProgress: (int sent, int total) {
            uploadedAmount!(sent / total);
            print("uploaded : ${sent / total}");
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
            message: e.message);
      } else {
        throw ServerException(
            errorCode: e.response!.statusCode,
            error: e.response!.data);
      }
    }
  }
}
