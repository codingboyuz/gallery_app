import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/albums/presentation/ui/album_screen.dart';
import 'package:gallery_app/features/gallery/presentation/ui/gallery_screen.dart';
import 'package:gallery_app/features/main/bloc/main_bloc.dart';
import 'package:gallery_app/features/main/bloc/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> items = [
    GalleryScreen(),
    AlbumsScreen(),
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   context.read<GalleryBloc>().add(GetMediaAlbumsEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MainBloc, NavigationState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: items,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.qr_code_scanner_sharp,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocBuilder<MainBloc, NavigationState>(
        builder: (context, state) {
          return AnimatedBottomNavigationBar(
            inactiveColor: Colors.grey,
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            blurEffect: true,
            splashRadius: 20.0,
            iconSize: 30,
            height: 75,
            icons: const [
              Icons.photo,
              Icons.photo_album_outlined,
            ],
            activeIndex: state.index,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (value) {
              context.read<MainBloc>().changeTab(value);
            },
          );
        },
      ),
    );
  }
}
