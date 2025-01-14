 import 'package:photo_manager/photo_manager.dart';

 abstract class MediaLocalDataSource{
  Future<List<AssetEntity>> loadAssets();
}