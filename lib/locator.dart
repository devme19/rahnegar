// import 'dart:async';
//
import 'package:get_it/get_it.dart';
import 'package:rahnegar/common/base_data_sources/base_local_data_source.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:rahnegar/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:rahnegar/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rahnegar/features/auth/domain/repository/auth_repository.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_otp_code_usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_commands_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_mileage_usecase.dart';
import 'package:rahnegar/features/intro/domain/usecase/get_user_info_usecase.dart' as intro_userinfo;
import 'package:rahnegar/features/auth/domain/usecase/otp_verification_usecase.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource_impl.dart';
import 'package:rahnegar/features/car/data/datasources/remote/car_remote_datasource.dart';
import 'package:rahnegar/features/car/data/repository/car_repository_impl.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';
import 'package:rahnegar/features/car/domain/usecase/add_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/delete_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_battery_status_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_brands_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_command_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/update_car_usecase.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/car/car_bloc.dart';
import 'package:rahnegar/features/car/presentation/manager/bloc/blocs/get_brands_cubit/get_brands_cubit.dart';
import 'package:rahnegar/features/intro/data/datasources/local/intro_local_datasource.dart';
import 'package:rahnegar/features/intro/data/datasources/remote/intro_remote_datasource.dart';
import 'package:rahnegar/features/intro/data/repository/intro_repository_impl.dart';
import 'package:rahnegar/features/intro/domain/repository/intro_repository.dart';
import 'package:rahnegar/features/intro/domain/usecase/is_authorized_usecase.dart';
import 'package:rahnegar/features/intro/presentation/manager/bloc/blocs/authorize/authorize_cubit.dart';
import 'package:rahnegar/features/map/data/data_sources/local/map_local_data_source.dart';
import 'package:rahnegar/features/map/data/data_sources/remote/map_remote_datasource.dart';
import 'package:rahnegar/features/map/data/data_sources/remote/web_socket_service.dart';
import 'package:rahnegar/features/map/data/repository/map_repository_impl.dart';
import 'package:rahnegar/features/map/domain/repository/map_repository.dart';
import 'package:rahnegar/features/map/domain/usecase/get_coordinates_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_routes_usecase.dart';
import 'package:rahnegar/features/map/presentation/manager/bloc/blocs/map/map_bloc.dart';
import 'package:rahnegar/features/setting/data/datasources/locale_data_source/setting_local_data_source.dart';
import 'package:rahnegar/features/setting/data/datasources/locale_data_source/setting_local_data_source_impl.dart';
import 'package:rahnegar/features/setting/data/repository/setting_repository_impl.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_theme_mode_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_theme_mode_usecase.dart';
import 'package:rahnegar/features/setting/presentation/manager/bloc/blocs/locale_cubit.dart';
import 'package:rahnegar/features/user/data/datasources/local/user_local_datatsource.dart';
import 'package:rahnegar/features/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:rahnegar/features/user/data/repository/user_repository_impl.dart';
import 'package:rahnegar/features/user/domain/repository/user_repository.dart';
import 'package:rahnegar/features/user/domain/usecase/update_user_info_usecase.dart';
import 'package:rahnegar/features/user/presentation/manager/bloc/blocs/user_bloc.dart';
import 'package:rahnegar/features/user/domain/usecase/get_user_info_usecase.dart' as user;
import 'package:rahnegar/native/native_bridge.dart';
import 'package:rahnegar/theme/bloc/theme_cubit.dart';

import 'features/auth/presentation/manager/bloc/bloc/blocs/otp_bloc.dart';
import 'features/setting/domain/repository/setting_repository.dart';
//
GetIt locator = GetIt.instance;

Future<void> initLocator()async{
  mainInjection();
  mapInjection();
  settingInjection();
  introInjection();
  authInjection();
  userInjection();
  carInjection();
}
mainInjection(){
  locator.registerLazySingleton<BaseLocalDataSource>(()=>BaseLocalDataSourceImpl());

}
mapInjection(){
  locator.registerLazySingleton<NativeBridge>(()=>NativeBridge());
  locator.registerLazySingleton<MapRemoteDataSource>(()=>MapRemoteDataSource());
  locator.registerLazySingleton<WebSocketService>(()=>WebSocketService(url: webSocketUrl));
  locator.registerLazySingleton<MapRepository>(()=>MapRepositoryImpl(remoteDataSource: locator(), webSocketService: locator()));
  locator.registerLazySingleton<GetRoutesUseCase>(()=>GetRoutesUseCase(repository: locator()));
  locator.registerLazySingleton<GetCoordinatesUseCase>(()=>GetCoordinatesUseCase(repository: locator()));
  locator.registerLazySingleton<MapBloc>(()=>MapBloc(nativeBridge: locator(),getCoordinatesUseCase: locator(),getRoutesUseCase: locator()));
}
settingInjection(){
  locator.registerLazySingleton<SettingLocalDataSource>(()=>SettingLocalDataSourceImpl());
  locator.registerLazySingleton<SettingRepository>(()=>SettingRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<SaveThemeModeUseCase>(()=>SaveThemeModeUseCase(repository: locator()));
  locator.registerLazySingleton<GetThemeModeUseCase>(()=>GetThemeModeUseCase(repository: locator()));
  locator.registerLazySingleton<GetLocaleUseCase>(()=>GetLocaleUseCase(repository: locator()));
  locator.registerLazySingleton<ThemeCubit>(()=>ThemeCubit(saveThemeModeUseCase: locator(), getThemeModeUseCase: locator(),getLocaleUseCase: locator()));
  locator.registerLazySingleton<SaveLocaleUseCase>(()=>SaveLocaleUseCase(repository: locator()));
  locator.registerLazySingleton<LocaleCubit>(()=>LocaleCubit(saveLocaleUseCase: locator(), getLocaleUseCase: locator()));
}
introInjection(){
  locator.registerLazySingleton<IntroLocalDatasource>(()=>IntroLocalDatasource());
  locator.registerLazySingleton<IntroRemoteDatasource>(()=>IntroRemoteDatasource());
  locator.registerLazySingleton<IntroRepository>(()=>IntroRepositoryImpl(localDatasource: locator(),remoteDatasource: locator()));
  locator.registerLazySingleton<IsAuthorizedUseCase>(()=>IsAuthorizedUseCase(repository: locator()));
  locator.registerLazySingleton<intro_userinfo.GetUserInfoUseCase>(()=>intro_userinfo.GetUserInfoUseCase(repository: locator()));
  locator.registerLazySingleton<AuthorizeCubit>(()=>AuthorizeCubit(isAuthorizedUseCase: locator(),getUserInfoUseCase: locator()));
}
authInjection(){
  locator.registerLazySingleton<AuthRemoteDatasource>(()=>AuthRemoteDatasource());
  locator.registerLazySingleton<AuthLocalDatasource>(()=>AuthLocalDatasource());
  locator.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(remoteDatasource: locator(), localDatasource: locator()));
  locator.registerLazySingleton<GetOtpCodeUseCase>(()=>GetOtpCodeUseCase(repository: locator()));
  locator.registerLazySingleton<OtpVerificationUseCase>(()=>OtpVerificationUseCase(repository: locator()));
  locator.registerLazySingleton<GetUserInfoUseCase>(()=>GetUserInfoUseCase(repository: locator()));
  locator.registerLazySingleton<OtpBloc>(()=>OtpBloc(getOtpCodeUseCase: locator(),otpVerificationUseCase: locator(),getUserInfoUseCase: locator()));
}
userInjection(){
  locator.registerLazySingleton<UserRemoteDatasource>(()=>UserRemoteDatasource());
  locator.registerLazySingleton<UserLocalDatasource>(()=>UserLocalDatasource());
  locator.registerLazySingleton<UserRepository>(()=>UserRepositoryImpl(localDatasource: locator(), remoteDatasource: locator()));
  locator.registerLazySingleton<UpdateUserInfoUseCase>(()=>UpdateUserInfoUseCase(repository: locator()));
  locator.registerLazySingleton<user.GetUserInfoUseCase>(()=>user.GetUserInfoUseCase(repository: locator()));
  locator.registerLazySingleton<UserBloc>(()=>UserBloc(updateUserInfoUseCase: locator(),getUserInfoUseCase: locator()));
}
carInjection(){
  locator.registerLazySingleton<CarRemoteDatasource>(()=>CarRemoteDatasource());
  locator.registerLazySingleton<CarLocalDatasource>(()=>CarLocalDatasourceImpl());
  locator.registerLazySingleton<CarRepository>(()=>CarRepositoryImpl(remoteDatasource: locator(),localDataSource: locator()));
  locator.registerLazySingleton<AddCarUseCase>(()=>AddCarUseCase(repository: locator()));
  locator.registerLazySingleton<GetMileageUseCase>(()=>GetMileageUseCase(repository: locator()));
  locator.registerLazySingleton<GetBrandsUseCase>(()=>GetBrandsUseCase(repository: locator()));
  locator.registerLazySingleton<GetBrandsCubit>(()=>GetBrandsCubit(getBrandsUseCase: locator()));
  locator.registerLazySingleton<GetMyCarsUseCase>(()=>GetMyCarsUseCase(repository: locator()));
  locator.registerLazySingleton<DeleteCarUseCase>(()=>DeleteCarUseCase(repository: locator()));
  locator.registerLazySingleton<SaveDefaultCarUseCase>(()=>SaveDefaultCarUseCase(repository: locator()));
  locator.registerLazySingleton<LoadDefaultCarUseCase>(()=>LoadDefaultCarUseCase(repository: locator()));
  locator.registerLazySingleton<SendFcmTokenUseCase>(()=>SendFcmTokenUseCase(repository: locator()));
  locator.registerLazySingleton<GetFcmTokenUseCase>(()=>GetFcmTokenUseCase(repository: locator()));
  locator.registerLazySingleton<UpdateCarUseCase>(()=>UpdateCarUseCase(repository: locator()));
  locator.registerLazySingleton<SendCommandUseCase>(()=>SendCommandUseCase(repository: locator()));
  locator.registerLazySingleton<GetCommandsUseCase>(()=>GetCommandsUseCase(repository: locator()));
  locator.registerLazySingleton<GetBatteryStatusUseCase>(()=>GetBatteryStatusUseCase(repository: locator()));
  locator.registerSingleton<CarBloc>(CarBloc(
    addCarUseCase: locator(),
    deleteCarUseCase: locator(),
    getFcmTokenUseCase: locator(),
    getMyCarsUseCase: locator(),
    loadDefaultCarUseCase: locator(),
    saveDefaultCarUseCase: locator(),
    sendFcmTokenUseCase: locator(),
    updateCarUseCase: locator(),
    sendCommandUseCase: locator(),
    getBatteryStatusUseCase: locator(),
    getMileageUseCase: locator(),
    getCommandsUseCase: locator()
  ));
  // locator.registerLazySingleton<AddRemoveCarBloc>(()=>AddRemoveCarBloc(addCarUseCase: locator()));
  // locator.registerLazySingleton<GetBrandsUseCase>(()=>GetBrandsUseCase(repository: locator()));
  // locator.registerLazySingleton<GetBrandsCubit>(()=>GetBrandsCubit(getBrandsUseCase: locator()));
}