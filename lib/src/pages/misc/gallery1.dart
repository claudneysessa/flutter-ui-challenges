import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_ui_challenges/src/pages/animations/animation1/animation1.dart';

class GalleryPageOne extends StatelessWidget {
  static final String path = "lib/src/pages/misc/gallery1.dart";
  // flutter_staggered_grid_view 0.7 dropped StaggeredTile in favour of the
  // cell counts being given directly to StaggeredGridTile.
  static const List<List<int>> _tileCounts = <List<int>>[
    [2, 2],
    [1, 1],
    [1, 1],
    [1, 1],
    [1, 1],
    [1, 1],
    [1, 1],
    [1, 1],
    [1, 1],
    [1, 1],
    [2, 2],
    [1, 1],
    [1, 1],
    [2, 1],
    [1, 2],
    [1, 1],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Photos',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child: Text("Add New"),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: [
            for (var index = 0; index < _tileCounts.length; index++)
              StaggeredGridTile.count(
                crossAxisCellCount: _tileCounts[index][0],
                mainAxisCellCount: _tileCounts[index][1].toDouble(),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(images[index % images.length]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
