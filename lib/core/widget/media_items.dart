import 'package:flutter/material.dart';
import 'package:gallery_app/core/services/service.dart';
import 'package:gallery_app/core/widget/media_entity_provider.dart';
import 'package:gallery_app/core/widget/media_viewer.dart';
import 'package:gallery_app/core/widget/custom_sliver_app_bar.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItems extends StatelessWidget {
  final Map<String, List<AssetEntity>> data;
  final List<AssetEntity> ungroupedImages;
  final String title;

  const MediaItems({
    super.key,
    required this.data,
    required this.ungroupedImages, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return title.isNotEmpty ?
      CustomSliverAppBar(
      title: title,
      child: SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: data.length,
              (context, index) {
        String date = data.keys.elementAt(index);
        String formattedDate = AppServices.dateFormat(date);
        List<AssetEntity> imagesForDate = data[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            

            _buildDateHeader(formattedDate),
            _buildImageGrid(context, imagesForDate),
          ],
        );
      })),
    ):
    ListView.builder(
      shrinkWrap: true,
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

  // media sanas
  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.only(left: 25),
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

  //
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
              _openMediaItems(context, entity);
            },
            child: MediaEntityProvider(
              entity: entity,
            ),
          );
        });
  }

  void _openMediaItems(BuildContext context, AssetEntity entity) {
    // buyerda biz guruhlangan yani sanalar bilan guruhlangan rasimni bosmoqdamiz
    // guruhlangan va guruhlanmagan list larning items indexsi harhil bo'ladi shu sababli
    // guruhlangan rasim index ni olish uchun ushbu ko'dni yozdik
    int ungroupedIndex = ungroupedImages.indexOf(entity);
    // birinchi pagedan ikkinchi pagega ma'lumot olib o'tish
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MediaViewer(
          entityItems: ungroupedImages,
          initialIndex:
              ungroupedIndex, // Yuborilayotgan indexni guruhlanmagan ro'yxatdagi mos indexga moslashtirildi
        ),
      ),
    );
  }
}
