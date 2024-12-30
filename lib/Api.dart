import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = " ##Informe aqui sua chave pessoal da API do Youtube## ";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3";

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {
    final url = "$URL_BASE/search?part=snippet&type=video&maxResults=20&order=date&key=$CHAVE_YOUTUBE_API&channelId=$ID_CANAL&q=$pesquisa";
    http.Response response = await http.get(Uri.parse(url));

    print("Status Code: ${response.statusCode}");
    print("Resposta: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      print("Dados JSON: $dadosJson");

      List<Video> videos = (dadosJson["items"] as List).map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      print("Número de vídeos: ${videos.length}");

      return videos;
    } else {
      throw Exception("Falha ao carregar os vídeos. Código: ${response.statusCode}");
    }
  }
}