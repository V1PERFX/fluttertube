import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/blocs/favoriteBloc.dart';
import 'package:fluttertube/models/video.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
      ),
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: StreamBuilder<Map<String, Video>>(
          stream: BlocProvider.of<FavoriteBloc>(context).outFav,
          initialData: {},
          builder: (contex, snapshot) {
            return ListView(
              children: snapshot.data.values.map((vid) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY,
                      videoId: vid.id,
                      autoPlay: true,
                    );
                  },
                  onLongPress: () {
                    BlocProvider.of<FavoriteBloc>(context).toggleFavorite(vid);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          vid.thumb,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: Text(
                                    vid.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.account_circle,
                                        color: Colors.grey,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        vid.channel,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
