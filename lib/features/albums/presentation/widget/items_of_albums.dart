import 'package:flutter/material.dart';
import 'package:gallery_app/core/widget/media_entity_provider.dart';
import 'package:gallery_app/features/albums/presentation/ui/albums_item_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class ItemsOfAlbumsWidget extends StatelessWidget {
  final AssetPathEntity album;

  const ItemsOfAlbumsWidget({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AlbumsItemScreen(selectedAlbum: album),
        ));
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
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  album.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
              ],
            );
          }
          return const Text("No Data");
        },
      ),
    );
  }
}
