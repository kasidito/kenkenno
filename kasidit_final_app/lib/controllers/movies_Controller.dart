import 'dart:async';

import 'package:kasidit_final_app/models/movies_Model.dart';
import 'package:kasidit_final_app/services/movies_Service.dart';

class MovieController {
  final MovieService _movieService = MovieService();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Movie>> fetchMovies() async {
    print('fetchMovies is called');

    onSyncController.add(true);
    await Future.delayed(Duration(seconds: 2)); // 2-second delay

    try {
      List<Movie> movies = await _movieService.fetchMovies();
      print(movies);
      onSyncController.add(false);
      return movies;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<Movie?> addMovie(Map<String, dynamic> newMovieData) async {
    print('addMovie is called');
    onSyncController.add(true);
    try {
      Movie addedMovie = await _movieService.addMovie(newMovieData);
      print(addedMovie);
      onSyncController.add(false);
      return addedMovie;
    } catch (e) {
      print("Error adding movie: $e");
      onSyncController.add(false);
      return null;
    }
  }

  Future<Movie?> updateMovie(
      String movieId, Map<String, dynamic> updatedMovieData) async {
    print('updateMovie is called');
    onSyncController.add(true);
    try {
      Movie updatedMovie =
          await _movieService.updateMovie(movieId, updatedMovieData);
      print(updatedMovie);
      onSyncController.add(false);
      return updatedMovie;
    } catch (e) {
      print("Error updating movie: $e");
      onSyncController.add(false);
      return null;
    }
  }

  Future<void> deleteMovie(String movieId) async {
    print('deleteMovie is called');
    onSyncController.add(true);
    try {
      await _movieService.deleteMovie(movieId);
      onSyncController.add(false);
    } catch (e) {
      print("Error deleting movie: $e");
      onSyncController.add(false);
      throw e;
    }
  }
}
