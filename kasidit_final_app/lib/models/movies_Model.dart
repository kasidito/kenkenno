import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Movie {
  String Id;
  String title;
  String genre;
  String imagePath;
  String length;
  String source;

  Movie(
    this.Id,
    this.title,
    this.genre,
    this.imagePath,
    this.length,
    this.source,
  );

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['Id'] as String,
      json['title'] as String,
      json['genre'] as String,
      json['imagePath'] as String,
      json['length'] as String,
      json['source'] as String,
    );
  }

  factory Movie.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return Movie(
      snapshot.id,
      json['title'] as String,
      json['genre'] as String,
      json['imagePath'] as String,
      json['length'] as String,
      json['source'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'title': title,
      'genre': genre,
      'imagePath': imagePath,
      'length': length,
      'source': source,
    };
  }

  String toString() {
    return 'Movie{Id: $Id, title: $title, genre: $genre, imagePath: $imagePath, length: $length, source: $source}';
  }
}

class AllMovies {
  final List<Movie> movies;

  AllMovies(this.movies);

  factory AllMovies.fromJson(List<dynamic> json) {
    List<Movie> movies = json.map((item) => Movie.fromJson(item)).toList();
    return AllMovies(movies);
  }

  factory AllMovies.fromSnapshot(QuerySnapshot qs) {
    List<Movie> movies = qs.docs.map((DocumentSnapshot ds) {
      Map<String, dynamic> dataWithId = ds.data() as Map<String, dynamic>;
      dataWithId['Id'] = ds.id;
      return Movie.fromJson(dataWithId);
    }).toList();
    return AllMovies(movies);
  }

  Map<String, dynamic> toJson() {
    return {
      'movies': movies.map((movie) => movie.toJson()).toList(),
    };
  }
}

class MoviesProvider extends ChangeNotifier {
  List<Movie>? _allMovies = [];

  List<Movie>? get allMovies => _allMovies;

  void setMovies(List<Movie>? movies) {
    _allMovies = movies;
    notifyListeners();
  }

  void addMovie(Movie movie) {
    print("addMovie @ provider is called");
    _allMovies!.add(movie);
    notifyListeners();
  }

  void updateMovie(Movie updatedMovie) {
    print("updateMovie @ provider is called");
    int index = _allMovies!.indexWhere((movie) => movie.Id == updatedMovie.Id);
    if (index != -1) {
      _allMovies![index] = updatedMovie;
      notifyListeners();
    }
  }
}
