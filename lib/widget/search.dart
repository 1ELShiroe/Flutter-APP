import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movies.dart';
import 'package:flutter_application_1/utils/http_service.dart';
import 'package:flutter_application_1/widget/description.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/utils/text.dart';

class Searchs extends StatefulWidget {
  const Searchs({Key? key}) : super(key: key);

  @override
  State<Searchs> createState() => _SearchsState();
}

class _SearchsState extends State<Searchs> {
  List<MoviesHtpp> movies = [];
  List<MoviesHtpp> foundeMovies = [];
  @override
  void initState() {
    loadMoviesOk();

    super.initState();
  }

  loadMoviesOk() async {
    List<MoviesHtpp> moviesApi = await HttpService().getMovies();

    setState(() {
      movies = moviesApi;
      movies.sort((a, b) =>
          a.title!.compareTo(b.title!)); // Ordenação em ordem alfabética.
      movies.sort((a, b) => b.releaseDate!.compareTo(a.releaseDate!));
      foundeMovies = movies;
    });
  }

  onSearch(String search) {
    setState(() {
      foundeMovies = movies
          .where((x) => x.title!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey.shade500,
        backgroundColor: Colors.grey.shade900,
        elevation: 0.0,
        title: SizedBox(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              hintText: 'Buscar filme',
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: ListView.builder(
          itemCount: foundeMovies.length,
          itemBuilder: (context, index) {
            MoviesHtpp movie =
                foundeMovies[index]; // pra cada item da lista um novo filme
            var date = DateFormat("yyyy")
                .format(DateTime.parse(movie.releaseDate.toString()));
            //print(DateFormat.yMMMd().format('${movie.releaseDate));
            if (foundeMovies.isEmpty) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // caso a lista for vazia retornar um loading
            } else {
              return Container(
                width: 300,
                height: 80,
                margin: const EdgeInsets.all(5),
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
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageDescriptions(
                          bannerUrl:
                              'https://image.tmdb.org/t/p/original${movie.backdropPath!}',
                          description: movie.overview!,
                          name: movie.title!,
                          vote: '${movie.voteAverage!}',
                          launch_on: movie.releaseDate!,
                          posterUrl:
                              'https://image.tmdb.org/t/p/original${movie.posterPath!}',
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.all(5),
                  title: PersonText(
                    text: '${movie.title}',
                    color: Colors.white,
                    size: 15,
                  ),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/original${movie.posterPath}',
                  ),
                  subtitle: Row(
                    children: [
                      PersonText(
                        text: date,
                        color: Colors.grey[500],
                        size: 12,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                  trailing: PersonText(
                    text: '${movie.voteAverage}',
                    color: Colors.amberAccent,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
