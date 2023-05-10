import 'package:datafilm_omdb/view/page_detail_film.dart';

import '../controller/films_data_source.dart';
import '../model/films.dart';
import 'package:flutter/material.dart';

class PageListFilm extends StatefulWidget {
  final String text;
  const PageListFilm({Key? key, required this.text}) : super(key: key);
  @override
  State<PageListFilm> createState() => _PageListFilmState();
}

class _PageListFilmState extends State<PageListFilm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Film"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: FilmsDataSource.instance.loadFilms(widget.text),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          } else if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            FilmList filmsModel = FilmList.fromJson(snapshot.data);
            if (filmsModel.response == "False") {
              return kosong();
            } else {
              return _buildSuccessSection(filmsModel);
            }
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget kosong() {
    return Center(
      child: Text("Data Kosong"),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(FilmList data) {
    return ListView.builder(
      itemCount: data.search!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(data.search![index]);
      },
    );
  }

  Widget _buildItemUsers(Search filmData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageDetailFilm(text: filmData.imdbID!))),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(filmData.poster!),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(filmData.title!, maxLines: 1),
                  Text(filmData.year!)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
