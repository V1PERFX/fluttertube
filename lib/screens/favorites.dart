import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favoriteBloc.dart';
import 'package:fluttertube/models/video.dart';

class Favorites extends StatelessWidget {
  //BlocProvider.of<FavoriteBloc>(context)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: BlocProvider.of<FavoriteBloc>(context).outFav,
        initialData: {},
        builder: (contex, snapshot) {
          return ListView(
            children: snapshot.data.values.map((vid) {
              return InkWell(
                onTap: () {},
                onLongPress: () {
                  BlocProvider.of<FavoriteBloc>(context).toggleFavorite(vid);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(vid.thumb),
                    ),
                    Expanded(
                      child: Text(
                        vid.title,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
