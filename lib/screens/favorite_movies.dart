// screens/favorite_movies.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/utils/favorite_service.dart';

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PopularModel> favorites = FavoriteService.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        backgroundColor: Colors.indigo,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No hay películas favoritas."))
          : ListView.builder(
              itemCount: favorites.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.network(movie.backdropPath, width: 100, fit: BoxFit.cover),
                    title: Text(movie.title),
                    subtitle: Text("Lanzamiento: ${movie.releaseDate}"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
                  ),
                );
              },
            ),
    );
  }
}

