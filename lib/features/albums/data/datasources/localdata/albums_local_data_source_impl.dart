// import 'package:gallery_app/my_library.dart' show MediaLocalDataSource;
import 'package:gallery_app/features/albums/data/datasources/localdata/albums_local_data_source.dart';
import 'package:photo_manager/photo_manager.dart';

/*
    class ochamiz nomi [AlbumsLocalDataSourceImpl]
    Abstract class dan meros olamiz [AlbumsLocalDataSource]
 */

class AlbumsLocalDataSourceImpl implements AlbumsLocalDataSource {
  @override
  Future<List<AssetPathEntity>> loadAlbums() async {
    // dastur o'rnatilishi bilan birinchi media fayillariga ruxsat olish lozim bo'ladi bu uchun

    var permission =
        await PhotoManager.requestPermissionExtend(); //ruxsat olish uchin
    List<AssetPathEntity> albumList = [];

    if (permission.isAuth) {
      // permission.isAuth bo'lsa yani media fayillarga ruxsat berilgan bo'lsa media fayillarini olamiz
      albumList = await PhotoManager.getAssetPathList(
        // albumlarni olish
        type: RequestType.common,
      );
    } else {
      //  "Foydalanuvchi ruxsat bermasa, media fayllar yuklanmaydi"
      PhotoManager.openSetting();
    }
    // media fayilari olingandan so'ng ma'lumot list  ko'rinishida return qilinadi
    return albumList;
  }

  // bu funksiya albumlarni item ni olib keladi yani buyerga album path yani linki beriladi shu albumga tegishli media fayilarni qaytaradi
  @override
  Future<List<AssetEntity>> loadAlbumsItem(
      AssetPathEntity selectedAlbum) async {
    // albumlarni soni
    int assetCount = await selectedAlbum.assetCountAsync;
    // rasimlarni olamiz
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0,
      end: assetCount, // assetCount bilan to'liq ro'yxatni yuklaymiz
    );
    return assetList;
  }
}
