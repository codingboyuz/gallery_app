import 'package:dartz/dartz.dart';
import 'package:gallery_app/features/albums/data/repositories/albums_repository_impl.dart';
import 'package:gallery_app/my_library.dart'
    show UseCase, Failure, NoParams;
import 'package:photo_manager/photo_manager.dart';




class AlbumsItemUseCase implements UseCase<List<AssetEntity>, AssetPathEntity> {
  final AlbumsRepositoryImpl repositoryImpl;

  AlbumsItemUseCase(this.repositoryImpl);

  @override
  Future<Either<Failure, List<AssetEntity>>> call(AssetPathEntity entity) {
    return repositoryImpl.loadAlbumsItem(entity);
  }
}


class AlbumsUseCase implements UseCase<List<AssetPathEntity>, NoParams> {
  final AlbumsRepositoryImpl repositoryImpl;

  AlbumsUseCase(this.repositoryImpl);

  @override
  Future<Either<Failure, List<AssetPathEntity>>> call(NoParams params) {
    return repositoryImpl.loadAlbums();
  }

}
