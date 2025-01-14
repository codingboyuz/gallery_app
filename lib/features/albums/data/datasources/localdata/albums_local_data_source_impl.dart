// import 'package:gallery_app/my_library.dart' show MediaLocalDataSource;
import 'package:gallery_app/features/albums/data/datasources/localdata/albums_local_data_source.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumsLocalDataSourceImpl implements AlbumsLocalDataSource {


  @override
  Future<List<AssetPathEntity>> loadAlbums() async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];
    if (permission.isAuth) {
      albumList = await PhotoManager.getAssetPathList(
        type: RequestType.common,
      );
    } else {
      PhotoManager.openSetting();
    }
    return albumList;
  }



  @override
  Future<List<AssetEntity>> loadAlbumsItem(
      AssetPathEntity selectedAlbum) async {
    // Bu yerda to'g'ri diapazonni kiritamiz
    int assetCount = await selectedAlbum.assetCountAsync;
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0,
      end: assetCount, // assetCount bilan to'liq ro'yxatni yuklaymiz
    );
    return assetList;
  }
}
