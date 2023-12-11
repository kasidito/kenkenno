import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kasidit_final_app/controllers/movies_Controller.dart';
import 'package:kasidit_final_app/models/movies_Model.dart';
import 'package:kasidit_final_app/pages/moviesDetail.dart';
import 'package:kasidit_final_app/pages/schedule.dart';

import 'package:provider/provider.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final movieController = MovieController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    movieController.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Center(
          child: Text('Movie Lists',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center),
        ),
        backgroundColor:
            Colors.deepPurple.shade200, // Customize the app bar color
      ),
      body: FutureBuilder<List<Movie>>(
        future: movieController.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found'));
          }
          var movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return Card(
                elevation: 5, // Add shadow to each card
                margin: EdgeInsets.all(8), // Add margin around each card
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MoviesDetailPage(movie: movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(movie.imagePath),
                            width: 80.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title: ${movie.title}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              Text('Genre: ${movie.genre}',
                                  style: TextStyle(fontSize: 16.0)),
                              Text('Length: ${movie.length}',
                                  style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.deepPurple.shade200,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          print(index);
          setState(() {
            _selectedIndex = index; // Update the selected index
            if (index == 0) {
              movieController.fetchMovies();
            } else if (index == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SchedulesListPage(),
                ),
              );
            }
          });
        },
        items: <Widget>[
          Icon(
            Icons.movie,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.schedule,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
