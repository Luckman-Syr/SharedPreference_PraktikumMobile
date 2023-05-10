import 'package:shared_preferences/shared_preferences.dart';

import '../controller/films_data_source.dart';
import '../model/details.dart';
import 'package:flutter/material.dart';

class PageDetailFilm extends StatefulWidget {
  final String text;
  const PageDetailFilm({Key? key, required this.text}) : super(key: key);
  @override
  State<PageDetailFilm> createState() => _PageDetailFilmState();
}

class _PageDetailFilmState extends State<PageDetailFilm> {
  @override
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Film"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: FilmsDataSource.instance.loadDetailFilm(widget.text),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            FilmDetails filmsModel = FilmDetails.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(FilmDetails data) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            //bisa di slide
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Image.network(data.poster!),
            ),
          ),
          Container(
            child: Text(
              data.title!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date Released"),
                      Text("Genre"),
                      Text("Director"),
                      Text("Actor"),
                      Text("Plot"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " : " + data.released!,
                        maxLines: 1,
                      ),
                      Text(
                        " : " + data.genre!,
                        maxLines: 1,
                      ),
                      Text(
                        " : " + data.director!,
                        maxLines: 1,
                      ),
                      Text(
                        " : " + data.actors!,
                        maxLines: 1,
                      ),
                      Text(
                        " : " + data.plot!,
                        maxLines: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          _favButton(data)
        ],
      ),
    );
  }

  _favoriteAction(FilmDetails value) async {
    setState(() {
      fav = !fav;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("favorite",
        [value.imdbID!, value.title!, value.poster!, fav.toString()]);
    prefs.commit();
  }

  _checkFavorite(FilmDetails data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorite = prefs.getStringList("favorite");
    if (favorite != null) {
      if (favorite[3] == "true" && data.imdbID == favorite[0]) {
        setState(() {
          fav = true;
        });
      }
    }
  }

  _favButton(FilmDetails data) {
    _checkFavorite(data);
    return IconButton(
      onPressed: () {
        _favoriteAction(data);
      },
      icon: Icon(
        fav ? Icons.favorite : Icons.favorite_border,
        color: fav ? Colors.red : Colors.white,
      ),
    );
  }
}
