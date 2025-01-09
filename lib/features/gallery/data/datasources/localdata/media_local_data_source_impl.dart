import 'package:gallery_app/my_library.dart' show MediaLocalDataSource;
import 'package:photo_manager/photo_manager.dart';

class MediaLocalDataSourceImpl implements MediaLocalDataSource {
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
  Future<List<AssetEntity>> loadAssets(AssetPathEntity selectedAlbum) async {
    // Bu yerda to'g'ri diapazonni kiritamiz
    int assetCount = await selectedAlbum.assetCountAsync;
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0,
      end: assetCount, // assetCount bilan to'liq ro'yxatni yuklaymiz
    );
    return assetList;
  }
}
