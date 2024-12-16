

import '../client/failures.dart';
import 'either.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class Params {
  final String? stringValue;
  final bool? boolValue;
  final Map<String, dynamic>? body;
  Params({this.body,this.stringValue,this.boolValue});
}