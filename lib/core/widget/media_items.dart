import 'package:flutter/material.dart';
import 'package:gallery_app/core/services/service.dart';
import 'package:gallery_app/core/widget/media_entity_provider.dart';
import 'package:gallery_app/core/widget/media_viewer.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItems extends StatelessWidget {
  final Map<String, List<AssetEntity>> data;
  final List<AssetEntity> ungroupedImages;
  final ClickStatus status;

  const MediaItems(
      {super.key,
      required this.data,
      required this.ungroupedImages,
      this.status = ClickStatus.none});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          String date = data.keys.elementAt(index);
          String formattedDate = AppServices.dateFormat(date);
          List<AssetEntity> imagesForDate = data[date]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(formattedDate),
              SizedBox(height: 15),
              _buildImageGrid(context, imagesForDate),
              SizedBox(height: 15),
            ],
          );
        });
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        date,
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w900),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImageGrid(
      BuildContext context, List<AssetEntity> imagesForDate) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: imagesForDate.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (context, index) {
          AssetEntity entity = imagesForDate[index];
          return InkWell(
            onTap: () {
              _openMediaItems(context,entity);
            },
            child: MediaEntityProvider(
              entity: entity,
            ),
          );
        });
  }
  // void _getClickStatus(BuildContext context, AssetEntity entity,List<AssetEntity> imagesForDate){
  //   switch (status){
  //     case ClickStatus.albums:
  //       return _openMediaItems( context, entity,imagesForDate);
  //     case ClickStatus.gallery:
  //       return _openMediaItems( context, entity,ungroupedImages);
  //     case ClickStatus.none:
  //       // TODO: Handle this case.
  //       throw UnimplementedError();
  //   }
  // }

  void _openMediaItems(BuildContext context, AssetEntity entity) {
    // buyerda biz guruhlangan yani sanalar bilan guruhlangan rasimni bosmoqdamiz
    // guruhlangan va guruhlanmagan list larning items indexsi harhil bo'ladi shu sababli
    // guruhlangan rasim index ni olish uchun ushbu ko'dni yozdik
    int ungroupedIndex = ungroupedImages.indexOf(entity);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MediaViewer(
              entityItems: ungroupedImages,
              initialIndex:
                  ungroupedIndex, // Yuborilayotgan indexni guruhlanmagan ro'yxatdagi mos indexga moslashtirildi
            )));
  }
}

enum ClickStatus { albums, gallery, none }
