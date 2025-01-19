import 'package:gallery_app/features/albums/data/datasources/localdata/albums_local_data_source.dart';
import 'package:photo_manager/photo_manager.dart';


class AlbumsLocalDataSourceImpl implements AlbumsLocalDataSource {
  /// Qurilmadagi mavjud albomlarni yuklaydi.
  /// Agar foydalanuvchi media fayllarga ruxsat bergan bo'lsa, albomlar ro'yxatini qaytaradi.
  /// Aks holda, foydalanuvchini sozlamalar sahifasiga yo'naltiradi.
  @override
  Future<List<AssetPathEntity>> loadAlbums() async {
    // Media fayilariga kirish uchin ruxsat so'raymiz.
    var permission = await PhotoManager.requestPermissionExtend(); //ruxsat olish uchin
    List<AssetPathEntity> albumList = [];

    if (permission.isAuth) {
      // Agar ruxsat berilgan bo'lsa, albomlarni yuklaymiz.
      albumList = await PhotoManager.getAssetPathList(
        // albumlarni olish
        type: RequestType.common,
      );
    } else {
      // Agar ruxsat berilmagan bo'lsa, foydalanuvchini sozlamalar oynasiga "Permission setting" o'tkazamiz.
      PhotoManager.openSetting();
    }
    // media fayilari olingandan so'ng ma'lumot list  ko'rinishida return qilinadi
    return albumList;
  }

  /// Berilgan albomning ichidagi media fayllarni yuklaydi.
  /// [selectedAlbum] - bu albom linki yani albom joylashgan joyi.
  /// Albom ichidagi barcha fayllarni qaytaradi.
  @override
  Future<List<AssetEntity>> loadAlbumsItem(
      AssetPathEntity selectedAlbum) async {
    // Albom ichidagi media fayllar sonini aniqlaymiz.
    int assetCount = await selectedAlbum.assetCountAsync;
    //  Media fayllarni yuklaymiz (0-dan boshlab to'liq ro'yxatni).
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0,// Boshlanish indeksi.
      end: assetCount, // Albomdagi fayllar soni.
    );
    // Media fayllar ro'yxatini qaytaramiz.
    return assetList;
  }
}
