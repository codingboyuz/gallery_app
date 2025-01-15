import 'package:dartz/dartz.dart';
import 'package:gallery_app/my_library.dart' show Failure;
import 'package:photo_manager/photo_manager.dart';

abstract interface class AlbumsRepository {
  Future<Either<Failure, List<AssetPathEntity>>> loadAlbums();

  Future<Either<Failure, List<AssetEntity>>> loadAlbumsItem(
      AssetPathEntity entity);
}
