import 'package:dartz/dartz.dart';
import 'package:gallery_app/features/albums/data/datasources/localdata/albums_local_data_source.dart';
import 'package:gallery_app/features/albums/domain/repositories/albums_repository.dart';
import 'package:gallery_app/my_library.dart' show Failure;
import 'package:photo_manager/photo_manager.dart';
import "package:photo_manager/src/types/entity.dart"
    show AssetEntity, AssetPathEntity;

class AlbumsRepositoryImpl implements AlbumsRepository {
  final AlbumsLocalDataSource mediaLocalDataSource;

  AlbumsRepositoryImpl(this.mediaLocalDataSource);

  @override
  Future<Either<Failure, List<AssetPathEntity>>> loadAlbums() async {
    try {
      final result = await mediaLocalDataSource.loadAlbums();
      if (result.isNotEmpty) {
        return Right(result);
      } else {
        return Left(Failure(message: "Image Null"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }


  @override
  Future<Either<Failure, List<AssetEntity>>> loadAlbumsItem(AssetPathEntity entity) async{
    try {
      final result = await mediaLocalDataSource.loadAlbumsItem(entity);
      if (result.isNotEmpty) {
        return Right(result);
      } else {
        return Left(Failure(message: "Album Null"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
