

import 'package:dartz/dartz.dart';
import 'package:gallery_app/core/usecase/usecase.dart';
import 'package:gallery_app/my_library.dart';

class GetMediaPicker implements UseCase<List,NoParams>{
  @override
  Future<Either<Failure, List>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
  
}   