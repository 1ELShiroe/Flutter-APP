// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_application_1/models/movies.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String url =
      "http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=_ADICIONE_SUA_API_AQUI_&language=pt-BR";
  Future<List<MoviesHtpp>> getMovies() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['results'];
      List<MoviesHtpp> httpmovies =
          body.map((dynamic item) => MoviesHtpp.fromJson(item)).toList();
      return httpmovies;
    } else {
      throw Exception('Erro ao conectar com a API! ');
    }
  }
}
