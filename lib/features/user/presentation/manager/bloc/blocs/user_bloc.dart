import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/user/domain/entity/user_entity.dart';
import 'package:rahnegar/features/user/domain/usecase/get_user_info_usecase.dart';
import 'package:rahnegar/features/user/domain/usecase/update_user_info_usecase.dart';
import '../../../../../../common/client/failures.dart';
import '../../../../../../common/utils/failure_action.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UpdateUserInfoUseCase? updateUserInfoUseCase;
  final GetUserInfoUseCase? getUserInfoUseCase;
  UserBloc({this.updateUserInfoUseCase,this.getUserInfoUseCase}) : super(UserInitial()) {
    on<UpdateUserInfoEvent>(_updateUserInfoEvent);
    on<GetUserInfoEvent>(_getUserInfoEvent);
  }
  _updateUserInfoEvent(UpdateUserInfoEvent event,Emitter emit)async{
    final response = await updateUserInfoUseCase!.call(Params(body: event.body));
    if(response.isRight){
      emit(SuccessState());
    }else if(response.isLeft){
      emit(FailureState(failure: response.left));
    }
  }
  _getUserInfoEvent(GetUserInfoEvent event,Emitter emit)async{
    final response = await getUserInfoUseCase!.call(NoParams());
    if(response.isRight){
      emit(GetUserInfoSuccess(userEntity: response.right));
    }else if(response.isLeft){
      emit(FailureState(failure: response.left));
    }
  }
}
