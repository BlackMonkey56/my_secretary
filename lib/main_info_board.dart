import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainInfoBoard extends StatefulWidget {
  @override
  _MainInfoBoardState createState() => new _MainInfoBoardState();
}

class _MainInfoBoardState extends State<MainInfoBoard> {

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: <Widget>[
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Weather', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                    Icon(Icons.wb_sunny),
                  ],//<Widget>[]
                ),//Column
              ],//<Widget>[]
            ),//Row
          ),//Padding
        ),//_buildTile
        _buildTile(
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Weather', style: new TextStyle(color: Colors.black),),
                    new Icon(Icons.wb_sunny),
                  ],//<Widget>[]
                ),//Column
              ],//<Widget>[]
            ),//Row
          ),//Padding
        ),//_buildTile
      ],//<Widget>[]
      staggeredTiles: [
        StaggeredTile.extent(2, 200.0),
        StaggeredTile.extent(2, 100.0),
      ],
    );//StaggerdGridView.count
  }

  Widget _buildTile(Widget child){
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
    );//Material
  }
}
