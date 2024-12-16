import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../../../../../common/client/failures.dart';





abstract class MapLocalDataSource{
  bool saveBreeds(List<String> breeds);
}

class MapLocalDataSourceImpl implements MapLocalDataSource{
  GetStorage? box;
  MapLocalDataSourceImpl({this.box});
  @override
  bool saveBreeds(List<String> breeds) {
    try{
      box!.write("Breeds", json.encode(breeds));
      return true;
    }catch(e){
      throw CacheFailure(message: e.toString());
    }
  }

}