import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_bloc.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_event.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_state.dart';
import 'package:gallery_app/features/albums/presentation/widget/items_of_albums.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_state.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  AssetPathEntity? selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      bloc: context.read<AlbumsBloc>()..add(GetAlbumsEvent()),
      builder: (context, state) {
        if (state is GalleryInitial) {
          return Center(
            child: Text(
              "Initial",
              style: TextStyle(fontSize: 50, color: Colors.red),
            ),
          );
        }
        if (state is AlbumsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AlbumsSuccess) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: GridView.builder(
              // padding: EdgeInsets.symmetric(horizontal: 5),
                itemCount: state.data.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: .8,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  AssetPathEntity album = state.data[index];
                  return itemsOfAlbums(context,album);
                }),
          );
        }
        if (state is GalleryError) {
          Center(
            child: Text(
              "Error",
              style: TextStyle(fontSize: 50, color: Colors.red),
            ),
          );
        }
        return Center(
          child: Text("data"),
        );
      },
    );
  }
}











// GridView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: assetList.length,
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                 ),
//                 itemBuilder: (ctx, index) {
//                   AssetEntity assetEntity = assetList[index];
//                   return FutureBuilder<Uint8List?>(
//                     future: assetEntity.thumbnailData,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       if (snapshot.hasError || snapshot.data == null) {
//                         return Center(child: Icon(Icons.error));
//                       }
//                       return Image.memory(
//                         snapshot.data!,
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   );
//                 },
//               ),

// Widget assetWidget(AssetEntity assetEntry) => Stack(
//   children: [
//     Positioned.fill(
//         child: Padding(
//           padding: EdgeInsets.all(0.2),
//           child: Image(
//             image: AssetEntityImageProvider(assetEntry),
//           ),
//         ))
//   ],
// );
//

