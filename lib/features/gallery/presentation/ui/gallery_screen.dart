import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_event.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_state.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

// class MediaService {
//   static Future loadAlbums() async {}
//
//   static Future<List<AssetEntity>> loadAssets(
//       AssetPathEntity selectedAlbum) async {
//     // Bu yerda to'g'ri diapazonni kiritamiz
//     int assetCount = await selectedAlbum.assetCountAsync;
//     List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
//       start: 0,
//       end: assetCount, // assetCount bilan to'liq ro'yxatni yuklaymiz
//     );
//     return assetList;
//   }
// }  AssetPathEntity? selectAlbum;
//   List<AssetPathEntity> albumList = [];
//   List<AssetEntity> assetList = [];
//   List<AssetEntity> selectedAlbumList = [];
//
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //
//   //   MediaService.loadAlbums().then(
//   //     (value) {
//   //       setState(() {
//   //         albumList = value;
//   //         selectAlbum = value[0];
//   //       });
//   //       MediaService.loadAssets(selectAlbum!).then((value) {
//   //         setState(() {
//   //           assetList = value;
//   //         });
//   //       });
//   //     },
//   //   );
//   //
//   //   super.initState();
//   // }

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  AssetPathEntity? selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<GalleryBloc, GalleryState>(
          bloc: context.read<GalleryBloc>()..add(GetMediaAlbumsEvent()),
          builder: (context, state) {
            if (state is GalleryInitial) {
              return Center(
                child: Text(
                  "Initial",
                  style: TextStyle(fontSize: 50, color: Colors.red),
                ),
              );
            }
            if (state is GalleryLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GallerySuccess) {
              print("object");
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  var album = state.data[index];
                  print(album);
                  return ListTile(
                    title: Text(album.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumScreen(selectedAlbum: album),
                        ),
                      );
                    },
                  );
                },
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
            return Center(child: Text("data"),);
          },
        ),
      ),
    );
  }

  Widget assetWidget(AssetEntity assetEntry) => Stack(
        children: [
          Positioned.fill(
              child: Padding(
            padding: EdgeInsets.all(0.2),
            child: Image(
              image: AssetEntityImageProvider(assetEntry),
            ),
          ))
        ],
      );
}


class AlbumScreen extends StatefulWidget {
  final AssetPathEntity selectedAlbum;

  const AlbumScreen({Key? key, required this.selectedAlbum}) : super(key: key);

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    // Albomdagi birinchi rasmini olish uchun Blocni chaqiramiz
    context.read<GalleryBloc>().add(GetMediaAssetsEvent(widget.selectedAlbum));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.selectedAlbum.name)),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is GalleryLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GalleryAssetsSuccess) {
            var firstAsset = state.data.isNotEmpty ? state.data[0] : null;
            if (firstAsset != null) {
              return Center(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.data.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (ctx, index) {
                    AssetEntity assetEntity = state.data[index];
                    return  Image(
                      image: AssetEntityImageProvider(assetEntity),
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text("No assets found in this album"));
            }
          }
          if (state is GalleryError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return Container();
        },
      ),
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
