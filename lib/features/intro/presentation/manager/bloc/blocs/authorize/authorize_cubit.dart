import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/intro/domain/usecase/get_user_info_usecase.dart';

import '../../../../../domain/usecase/is_authorized_usecase.dart';


part 'authorize_state.dart';

class AuthorizeCubit extends Cubit<AuthorizeState> {
  AuthorizeCubit({required this.isAuthorizedUseCase,required this.getUserInfoUseCase}) : super(AuthorizeInitial());
  final IsAuthorizedUseCase isAuthorizedUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;

  Future<void> checkAuthorization()async{
    final response = await isAuthorizedUseCase.call(NoParams());
    if(response.isRight){
      if(response.right){
        getUserInfoUseCase.call(NoParams()).then((response){
          if(response.isRight){
            final user = response.right.data;
            if(user!=null){
              if(user.firstName!=null && user.lastName != null){
                if(user.firstName!.isNotEmpty && user.lastName!.isNotEmpty){

                  emit(Authorized());
                }else{
                  emit(UnAuthorized());
                }
              }else{
                emit(UnAuthorized());
              }
            }else{
              emit(UnAuthorized());
            }
          }else if(response.isLeft){
            emit(UnAuthorized());
          }
        });

      }
      else{
        emit(UnAuthorized());
      }
    }else if(response.isLeft){
      emit(UnAuthorized());
    }
  }

}
