
import 'package:dartz/dartz.dart';
import 'package:gallery_app/my_library.dart' show Failure;
import 'package:photo_manager/photo_manager.dart';

abstract class MediaRepository{
  Future<Either<Failure,List<AssetPathEntity>>> getAlbums();
  Future<Either<Failure,List<AssetEntity>>> getAssets();

}