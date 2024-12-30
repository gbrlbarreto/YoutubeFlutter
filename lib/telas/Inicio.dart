import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube/model/VideoPlayerPage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {
  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa).then((videos) {
      print("Videos recebidos: $videos");
      return videos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              List<Video> videos = snapshot.data ?? []; // Prevenir erro se data for nulo
              return ListView.separated(
                itemBuilder: (context, index) {
                  Video video = videos[index];
                  return GestureDetector(
                    onTap: () {
                      // Navegar para a tela de reprodução do vídeo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(videoId: video.id ?? ""),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(video.imagem ?? ''),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(video.titulo ?? "Título"),
                          subtitle: Text(video.canal ?? "Canal"),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: videos.length,
              );
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
        }
      },
    );
  }
}
