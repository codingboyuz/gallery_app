import 'package:dartz/dartz.dart';
import 'package:gallery_app/my_library.dart'
    show UseCase, Failure, MediaRepositoryImpl, NoParams;
import 'package:photo_manager/photo_manager.dart';

class MediaAssetsUseCase implements UseCase<List<AssetEntity>, AssetPathEntity> {
  final MediaRepositoryImpl repositoryImpl;

  MediaAssetsUseCase(this.repositoryImpl);

  @override
  Future<Either<Failure, List<AssetEntity>>> call(AssetPathEntity params) {
    return repositoryImpl.loadAssets(params);
  }
}


class MediaAlbumsUseCase implements UseCase<List<AssetPathEntity>, NoParams> {
  final MediaRepositoryImpl repositoryImpl;

  MediaAlbumsUseCase(this.repositoryImpl);

  @override
  Future<Either<Failure, List<AssetPathEntity>>> call(NoParams params) {
    return repositoryImpl.loadAlbums();
  }
}
