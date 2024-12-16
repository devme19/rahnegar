import 'package:rahnegar/common/base_data_sources/base_local_data_source.dart';

class AuthLocalDatasource extends BaseLocalDataSourceImpl{
    @override
  bool saveToken(String token) {
    try{
      return super.saveToken(token);
    }catch(e){
      rethrow;
    }

  }
 @override
  bool saveUserInfo(String usrInfo) {
   try{
     return super.saveUserInfo(usrInfo);
   }catch(e){
     rethrow;
   }

  }
  @override
  bool saveRefreshToken(String refreshToken) {
    // TODO: implement saveRefreshToken
    try{
      return super.saveRefreshToken(refreshToken);
    }catch(e){
      rethrow;
    }
  }
}