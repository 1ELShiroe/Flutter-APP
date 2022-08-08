// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movies.dart';
import 'package:flutter_application_1/utils/http_service.dart';
import 'package:flutter_application_1/widget/description.dart';
import 'package:intl/intl.dart';

class PopularityFilms extends StatefulWidget {
  const PopularityFilms({Key? key}) : super(key: key);

  @override
  State<PopularityFilms> createState() => _PopularityFilmsState();
}

class _PopularityFilmsState extends State<PopularityFilms> {
  List<MoviesHtpp> movies = [];
  List<MoviesHtpp> genre = [];
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
                'Populares',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              Text(
                'Ver mais',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < movies.length; i++)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageDescriptions(
                          bannerUrl:
                              'https://image.tmdb.org/t/p/original${movies[i].backdropPath!}',
                          description: movies[i].overview!,
                          name: movies[i].title!,
                          vote: '${movies[i].voteAverage!}',
                          launch_on: movies[i].releaseDate!,
                          posterUrl:
                              'https://image.tmdb.org/t/p/original${movies[i].posterPath!}',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 190,
                    height: 280,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF292B37).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/original${movies[i].backdropPath}',
                            height: 140,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${movies[i].title}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${movies[i].voteAverage}',
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat("yyyy").format(
                                            DateTime.parse(movies[i]
                                                .releaseDate
                                                .toString())),
                                        style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 15),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
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
