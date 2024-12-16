import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rahnegar/common/client/failures.dart';

import '../../../../../../../common/utils/usecase.dart';
import '../../../../../domain/entity/brand_data_entity.dart';
import '../../../../../domain/usecase/get_brands_usecase.dart';

part 'get_brands_state.dart';

class GetBrandsCubit extends Cubit<GetBrandsState> {
  GetBrandsUseCase getBrandsUseCase;
  GetBrandsCubit({required this.getBrandsUseCase}) : super(GetBrandsInitial());

  getBrands({String id=''})async{
    Map<String,dynamic> body={};
    if(id.isNotEmpty){
      body={
        'parent_id':id
      };
    }
    emit(GetBrandsLoading());
    final response  = await getBrandsUseCase.call(Params(body: body));
    if(response.isRight){
      emit(GetBrandsSuccess(brands: response.right.data!));
    }else if(response.isLeft){
      emit(GetBrandsFailure(failure: response.left));
    }
  }
}
