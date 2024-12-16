

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rahnegar/common/base_data_sources/base_remote_data_source.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CarRemoteDatasource extends BaseRemoteDataSourceImpl{
  addCar({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }
  getBrands({required String url,Map<String,dynamic>? formData})async{
    try{
      Response response = await get(url: url,formData: formData);
      return response;
    }catch(e){
      rethrow;
    }
  }
  getMyCars({required String url})async{
    try{
      Response response = await get(url: url);
      return response;
    }catch(e){
      rethrow;
    }
  }
  deleteCar({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }
  updateCar({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> sendCommand({required String url, required Map<String, dynamic> body}) async {
    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      String jsonBody = jsonEncode(body);
      channel.sink.add(jsonBody);
      List<String> responses = [];
      await for (var response in channel.stream) {
        if (response is String) {
          responses.add(response);
          var parsedResponse = jsonDecode(response);
          if (responses.length >= 2) {
            channel.sink.close();
            return parsedResponse;
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> sendFcmToken({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }
  Future<Response> getMileage({required String url,required Map<String,dynamic> queryParameters})async{
    try{
      Response response =await get(url: url,formData: queryParameters);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<Response> getCommands({required String url,required Map<String,dynamic> queryParameters})async{
    try{
      Response response = await get(url: url,formData: queryParameters);
      return response;
    }catch(e){
      rethrow;
    }
  }


}