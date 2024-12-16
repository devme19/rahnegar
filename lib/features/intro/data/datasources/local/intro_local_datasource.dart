import 'package:rahnegar/common/base_data_sources/base_local_data_source.dart';

class IntroLocalDatasource extends BaseLocalDataSourceImpl{

  bool isAuthorized(){
    try{
      String token = getToken();
      return token.isNotEmpty;
    }catch(e){
      rethrow;
    }
  }
  bool saveUsrInfo(String usrInfo){
    try{
      bool result = saveUserInfo(usrInfo);
      return result;
    }catch(e){
      rethrow;
    }
  }
}