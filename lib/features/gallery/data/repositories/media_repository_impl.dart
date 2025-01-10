import 'package:dartz/dartz.dart';
import 'package:gallery_app/features/gallery/data/datasources/localdata/media_local_data_source.dart';
import 'package:gallery_app/my_library.dart' show MediaRepository, Failure;
import 'package:photo_manager/photo_manager.dart';
import "package:photo_manager/src/types/entity.dart"
    show AssetEntity, AssetPathEntity;

class MediaRepositoryImpl implements MediaRepository {
  final MediaLocalDataSource mediaLocalDataSource;

  MediaRepositoryImpl(this.mediaLocalDataSource);

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
  Future<Either<Failure, List<AssetEntity>>> loadAssets(AssetPathEntity selectedAlbum) async{
    try {
      final result = await mediaLocalDataSource.loadAssets(selectedAlbum);
      if (result.isNotEmpty) {
        return Right(result);
      } else {
        return Left(Failure(message: "Image Null"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
