import 'package:dio/dio.dart';
import 'package:rahnegar/common/base_data_sources/base_remote_data_source.dart';

class UserRemoteDatasource extends BaseRemoteDataSourceImpl{
  updateUser({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }
  getUserInfo({required String url})async{
    try{
      Response response =await get(url: url);
      return response;
    }catch(e){
      rethrow;
    }
  }
}