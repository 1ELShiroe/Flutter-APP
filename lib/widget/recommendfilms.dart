import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movies.dart';
import 'package:flutter_application_1/utils/http_service.dart';

class RecommendWidget extends StatefulWidget {
  const RecommendWidget({Key? key}) : super(key: key);

  @override
  State<RecommendWidget> createState() => _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {
  List<MoviesHtpp> movies = [];
  var backdropPath = [];
  @override
  void initState() {
    loadMoviesOk();
    super.initState();
  }

  loadMoviesOk() async {
    List<MoviesHtpp> moviesApi = await HttpService().getMovies();

    setState(() {
      movies = moviesApi;
      for (var i = 0; i < movies.length; i++) {
        backdropPath.add(movies[i].backdropPath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Recomendados",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Ver tudo",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < backdropPath.length; i++)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${backdropPath[i]}',
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
