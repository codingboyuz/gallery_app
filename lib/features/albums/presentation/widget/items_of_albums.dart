import 'package:flutter/material.dart';
import 'package:gallery_app/core/widget/media_entity_provider.dart';
import 'package:gallery_app/features/albums/presentation/ui/albums_item_screen.dart';
import 'package:photo_manager/photo_manager.dart';

Widget itemsOfAlbums(BuildContext context, AssetPathEntity album) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push((MaterialPageRoute(
          builder: (_) => AlbumsItemScreen(selectedAlbum: album))));
    },
    child: FutureBuilder<List<AssetEntity>>(
        future: album.getAssetListRange(start: 0, end: 1),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: MediaEntityProvider(
                        entity: snapshot.data!.first,
                      )),
                ),
                SizedBox(height: 4),
                Text(
                  album.name,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
              ],
            );
          }
          return Text("No Data");
        }),
  );
}
