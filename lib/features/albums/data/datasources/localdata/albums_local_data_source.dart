 import 'package:photo_manager/photo_manager.dart';

 abstract class AlbumsLocalDataSource{
  Future<List<AssetPathEntity>> loadAlbums();

  Future<List<AssetEntity>> loadAlbumsItem(AssetPathEntity selectedAlbum);
}