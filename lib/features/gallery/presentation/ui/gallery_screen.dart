import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/services/service.dart';
import 'package:gallery_app/core/widget/media_items.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_event.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_state.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      bloc: context.read<GalleryBloc>()..add(GetMediaAssetsEvent()),
      builder: (context, state) {
        if (state is GalleryInitial) {
          return Container();
        }
        if (state is GalleryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GallerySuccess) {
          var data = AppServices.groupImagesByDate(state.data);
          return MediaItems(
            data: data,
            ungroupedImages: state.data,
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
          child: Text("Noqaniq hatolik"),
        );
      },
    );
  }
}
