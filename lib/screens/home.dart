import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favoriteBloc.dart';
import 'package:fluttertube/blocs/videosBloc.dart';
import 'package:fluttertube/delegates/dataSearch.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/screens/favorites.dart';
import 'package:fluttertube/widgets/videoTile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/ft_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data.length}");
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        initialData: [],
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
                    ),
                  );
                } else {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: Text(
                            "Clique aqui para procurar vídeos",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 1),
                          child: Icon(
                            Icons.arrow_upward,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
