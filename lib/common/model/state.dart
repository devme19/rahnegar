
import '../client/failures.dart';

class MyState{
  bool isLoading;
  bool isFailure;
  bool isSuccess;
  bool initial;
  Failure? failure;
  MyState({this.initial=true,this.isLoading=false, this.isFailure=false, this.isSuccess=false,this.failure});
}