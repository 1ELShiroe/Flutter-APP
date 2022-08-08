import 'package:flutter_application_1/models/movies.dart';
import 'package:flutter_application_1/utils/http_service.dart';
import 'package:flutter_application_1/utils/text.dart';
import 'package:flutter_application_1/widget/popularityfilms.dart';
import 'package:flutter_application_1/widget/nextfilms.dart';
import 'package:flutter_application_1/widget/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MoviesHtpp> movies = [];

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
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Searchs(),
                ),
              );
            },
          )
        ],
        title: const Center(
          child: PersonText(
            text: "Evo Films ❤️",
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade900,
        child: Column(
          children: const [
            NextFilms(),
            SizedBox(
              height: 24,
            ),
            PopularityFilms()
          ],
        ),
      ),
    );
  }
}
