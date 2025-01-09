import 'package:dartz/dartz.dart';
import 'package:gallery_app/my_library.dart' show Failure;

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}