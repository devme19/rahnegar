import 'package:dio/dio.dart';
import 'package:rahnegar/common/base_data_sources/base_remote_data_source.dart';

class IntroRemoteDatasource extends BaseRemoteDataSourceImpl{
  getUserInfo({required String url})async{
    try{
      Response response =await get(url: url);
      return response;
    }catch(e){
      rethrow;
    }
  }

}