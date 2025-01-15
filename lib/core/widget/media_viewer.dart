import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MediaViewer extends StatefulWidget {
  final List<AssetEntity> entityItems;
  final int initialIndex;

  const MediaViewer({
    super.key,
    required this.entityItems,
    this.initialIndex = 0,
  });

  @override
  _MediaViewerState createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.entityItems.length,
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (context, index) {
          final entity = widget.entityItems[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: _loadImage(entity),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(
              tag: entity.id,
              transitionOnUserGestures: true,
            ),
            // Animatsiya tezligi va rasimni zoom qilish
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 4,
          );
        },
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            /*
             1. event.cumulativeBytesLoaded:
                Bu yuklanayotgan ma'lumotning hozirgi vaqtdagi jami hajmi (yuklangan baytlar).
                Masalan, fayl yuklanayotgan bo'lsa, bu qiymat yuklangan baytlar miqdorini ifodalaydi.
              2. event.expectedTotalBytes:
                Bu yuklanishi kerak bo'lgan jami ma'lumotning hajmi (yuklanadigan faylning umumiy baytlari).
                Agar ma'lumotning umumiy hajmi aniq bo'lsa, bu qiymat uni ko'rsatadi.

              */

            value: event == null
                ? null
                : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
          ),
        ),
      ),
    );
  }

  ImageProvider _loadImage(AssetEntity entity) {
    return AssetEntityImageProvider(
      entity,
      isOriginal: true, // Asli rasmni yuklaydi
    );
  }
}
