import 'package:rahnegar/common/base_data_sources/base_local_data_source.dart';

class UserLocalDatasource extends BaseLocalDataSourceImpl{
  @override
  bool saveUserInfo(String usrInfo) {
    try{
      saveUserInfo(usrInfo);
      return true;
    }catch(e){
      rethrow;
    }
  }
}