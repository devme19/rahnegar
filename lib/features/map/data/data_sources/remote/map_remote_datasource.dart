import 'package:dio/dio.dart';
import 'package:rahnegar/common/base_data_sources/base_remote_data_source.dart';

class MapRemoteDataSource extends BaseRemoteDataSourceImpl{


  markLocation({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }

  getAllMarkedLocation({required String url})async{
    try{
      Response response = await get(url: url,);
      return response;
    }catch (e){
      rethrow;
    }
  }

  deleteMarkedLocation({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await post(url: url,body: body);
      return response;
    }catch(e){
      rethrow;
    }
  }

  getRoutesHistory({required String url,required Map<String,dynamic> body})async{
    try{
      Response response = await get(url: url,formData: body);
      return response;
    }catch(e){
      rethrow;
    }
  }

}