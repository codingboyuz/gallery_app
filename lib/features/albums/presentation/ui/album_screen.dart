import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/widget/custom_sliver_app_bar.dart';
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
        // loading holati
        if (state is AlbumsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Success holati
        if (state is AlbumsSuccess) {
          // agar state yani holat AlbumsSuccess bo'lsa
          // state.data qilb malumot olinadi bu malumot AlbumsBloc dan keladi
          return CustomSliverAppBar(
              title: "Album",
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                        (context, index) {
                  return GridView.builder(
                      itemCount: state.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: .8,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        // kelganm ma'lumotlarni list ning index ni itemsOfAlbums ga beramiz va itemlar chiziladi
                        AssetPathEntity album = state.data[index];
                        return ItemsOfAlbumsWidget(
                          album: album,
                        );
                      });
                }),
              ));
        }
        if (state is AlbumsError) {
          Center(
            child: Text(
              "Error",
              style: TextStyle(fontSize: 50, color: Colors.red),
            ),
          );
        }
        return Center(
          child: Text("Album"),
        );
      },
    );
  }
}
