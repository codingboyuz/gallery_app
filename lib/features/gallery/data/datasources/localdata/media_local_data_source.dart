 import 'package:photo_manager/photo_manager.dart';

 abstract class MediaLocalDataSource{
  Future<List<AssetPathEntity>> loadAlbums();
  Future<List<AssetEntity>> loadAssets(AssetPathEntity selectedAlbum);
}