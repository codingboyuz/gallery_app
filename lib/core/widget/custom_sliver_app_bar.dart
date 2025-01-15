import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomSliverAppBar(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 90,
          floating: false,
          expandedHeight: 160.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Container(
              color: Colors.black,
            ),
            title: Text(title,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        child,
        SliverToBoxAdapter(child: SizedBox(height: 50,))
      ],
    );
  }
}
