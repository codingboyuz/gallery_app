import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/services/service.dart';
import 'package:gallery_app/core/widget/media_items.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_event.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_state.dart';

// GalleryScreen widget - bu galereya ekranining UI qismini saqlovchi StatefulWidget
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    // BlocBuilder orqali GalleryBloc'ning holatini tinglab, UI'ni yangilash
    return BlocBuilder<GalleryBloc, GalleryState>(
      // Ekran yuklanganda media assets (rasmlar) olish uchun voqeani ishga tushiramiz
      bloc: context.read<GalleryBloc>()..add(GetMediaAssetsEvent()),

      // Holat o'zgarganda UI'ni qayta quradigan builder
      builder: (context, state) {

        // Agar holat GalleryInitial bo'lsa, bo'sh konteyner qaytariladi
        if (state is GalleryInitial) {
          return Container();
        }

        // Agar holat GalleryLoading bo'lsa, yuklanayotgan spinnerni ko'rsatish
        if (state is GalleryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Agar holat GallerySuccess bo'lsa, rasm va videolarni guruhlangan holda ko'rsatish
        if (state is GallerySuccess) {
          // AppServices yordamida rasmlarni sana bo'yicha guruhlash
          var data = AppServices.groupImagesByDate(state.data);

          // MediaItems widget'ini qaytarish, bunda guruhlangan rasmlar ko'rsatiladi
          return MediaItems(
            title: "Photo", // Title sifatida "Photo" qo'yiladi
            data: data, // Guruhlangan ma'lumotlar uzatiladi
            ungroupedImages: state.data, // Guruhlanmagan rasmlar ham uzatiladi
          );
        }

        // Agar holat GalleryError bo'lsa, xato xabarini ko'rsatish
        if (state is GalleryError) {
          return Center(
            child: Text(
              "Error", // Xato xabari
              style: TextStyle(fontSize: 50, color: Colors.red), // Xato xabarini qizil rangda va katta harfda ko'rsatish
            ),
          );
        }

        // Agar boshqa holatlar bo'lsa, umumiy xato xabarini ko'rsatish
        return Center(
          child: Text("Noqaniq hatolik"), // Umumiy xato xabari
        );
      },
    );
  }
}
