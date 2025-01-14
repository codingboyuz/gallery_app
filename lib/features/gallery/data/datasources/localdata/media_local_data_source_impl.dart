import 'package:gallery_app/my_library.dart' show MediaLocalDataSource;
import 'package:photo_manager/photo_manager.dart';

class MediaLocalDataSourceImpl implements MediaLocalDataSource {
  @override
  Future<List<AssetEntity>> loadAssets() async {
    // Ruxsatni so'raymiz
    // var permission = await PhotoManager.requestPermissionExtend();
    // if (!permission.isAuth) {
    //   PhotoManager.openSetting();
    //   return [];
    // }

    // "Recent" yoki "All Photos" albomini topamiz
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
    );

    // Barcha rasmlarni yuklash uchun Recent albomini olamiz
    AssetPathEntity recentAlbum = albums.firstWhere(
      (album) => album.isAll,
      orElse: () => albums.first,
    );

    // Rasmlarni yuklaymiz
    int assetCount = await recentAlbum.assetCountAsync;
    List<AssetEntity> assetList = await recentAlbum.getAssetListRange(
      start: 0,
      end: assetCount,
    );

    return assetList;
  }
}
