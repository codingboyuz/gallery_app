


import 'package:dartz/dartz.dart';
import 'package:gallery_app/core/errors/failure.dart';
import 'package:gallery_app/my_library.dart' show MediaRepository;
import 'package:photo_manager/src/types/entity.dart' show AssetEntity, AssetPathEntity;

class MediaRepositoryImpl implements MediaRepository{
  @override
  Future<Either<Failure, List<AssetPathEntity>>> getAlbums() {
    // TODO: implement getAlbums
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AssetEntity>>> getAssets() {
    // TODO: implement getAssets
    throw UnimplementedError();
  }
}