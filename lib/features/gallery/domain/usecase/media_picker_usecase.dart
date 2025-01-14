import 'package:dartz/dartz.dart';
import 'package:gallery_app/my_library.dart'
    show UseCase, Failure, MediaRepositoryImpl, NoParams;
import 'package:photo_manager/photo_manager.dart';


class MediaAssetsUseCase implements UseCase<List<AssetEntity>, NoParams> {
  final MediaRepositoryImpl repositoryImpl;

  MediaAssetsUseCase(this.repositoryImpl);

  @override
  Future<Either<Failure, List<AssetEntity>>> call(NoParams params) {
    return repositoryImpl.loadAssets();
  }
}



