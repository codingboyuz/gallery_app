import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class MediaService {

  static Future loadAlbums() async {
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

  static Future<List<AssetEntity>> loadAssets(
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

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  AssetPathEntity? selectAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAlbumList = [];

  @override
  void initState() {
    // TODO: implement initState

    MediaService.loadAlbums().then(
      (value) {
        setState(() {
          albumList = value;
          selectAlbum = value[0];
        });
        MediaService.loadAssets(selectAlbum!).then((value) {
          setState(() {
            assetList = value;
          });
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: DropdownButton<AssetPathEntity>(
          value: selectAlbum,
          onChanged: (AssetPathEntity? value) {
            setState(() {
              print("================================value");

              selectAlbum = value;
            });
            MediaService.loadAssets(selectAlbum!).then((value) {
              setState(() {
                print("================================");
                print("================================");
                assetList = value;
                print(assetList);
              });
            });
          },
          items: albumList
              .toSet() // Convert to Set to remove duplicates
              .map<DropdownMenuItem<AssetPathEntity>>((AssetPathEntity album) {
            return DropdownMenuItem<AssetPathEntity>(
              value: album,
              child: Text(album.name),
            );
          }).toList(),
        )),
        body: assetList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: assetList.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (ctx, index) {
                  AssetEntity assetEntity = assetList[index];
                  return FutureBuilder<Uint8List?>(
                    future: assetEntity.thumbnailData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError || snapshot.data == null) {
                        return Center(child: Icon(Icons.error));
                      }
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    },
                  );
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
