
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/utils/favorite_service.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_application_1/screens/detail_popular_movie.dart';

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PopularModel> favorites = FavoriteService.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Favoritas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 41, 223, 247),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 14, 14, 14)),
        centerTitle: true,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? _buildEmptyState(context)
          : _buildMoviesList(context, favorites),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/empty.json',
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            'No tienes películas favoritas',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Agrega películas a favoritos para verlas aquí',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/api');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Explorar Películas',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesList(BuildContext context, List<PopularModel> favorites) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _navigateToDetail(context, movie),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget Hero para la transición animada del póster
                  Hero(
                    tag: 'movie-poster-${movie.id}',
                    child: Material(
                      type: MaterialType.transparency,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 80,
                            height: 120,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.movie, size: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Detalles de la película
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Widget Hero para la transición animada del título
                        Hero(
                          tag: 'movie-title-${movie.id}',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber.shade600,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.voteAverage.toStringAsFixed(1)}/10',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          movie.releaseDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          movie.overview.length > 100
                              ? '${movie.overview.substring(0, 100)}...'
                              : movie.overview,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Botón de favoritos
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      FavoriteService.toggleFavorite(movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Película removida de favoritos'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      // Forzar rebuild del widget padre
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteMovies(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, PopularModel movie) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DetailPopularMovie(),
          );
        },
        settings: RouteSettings(arguments: movie),
      ),
    );
  }
}

