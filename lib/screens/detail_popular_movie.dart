import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_actors.dart';
import 'package:flutter_application_1/network/api_trailer.dart';
import 'package:flutter_application_1/utils/favorite_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  late PopularModel movie;
  late Future<List<Actor>> futureActors;
  late Future<Trailer?> futureTrailer;
  YoutubePlayerController? _youtubeController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;
    futureActors = ApiActors().fetchActors(movie.id);
    futureTrailer = ApiTrailer().getTrailer(movie.id);
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoriteService.isFavorite(movie);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.transparent, // Hacemos la AppBar transparente
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true, // Permite que el fondo se extienda detrás de la AppBar
      body: Stack(
        children: [
          // Fondo difuminado con la imagen del poster
          Positioned.fill(
            child: Image.network(
              movie.posterPath.isNotEmpty 
                  ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
                  : 'https://toppng.com/uploads/preview/404-error-error-404-transparent-11563210406bsmsusbbzi.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade800,
              ),
            ),
          ),
          // Efecto de difuminado
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),
          // Contenido principal
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 60), // Espacio para la AppBar
                  // Imagen principal
                  Container(
                    height: 230,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        movie.backdropPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(Icons.error, color: Colors.white, size: 50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Resto del contenido (mantén el mismo código que ya tienes)
                  FutureBuilder<Trailer?>(
                    future: futureTrailer,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Tráiler no disponible.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      final trailer = snapshot.data!;
                      final videoId = trailer.key;

                      _youtubeController ??= YoutubePlayerController(
                        initialVideoId: videoId,
                        flags: const YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                        ),
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tráiler oficial',
                              style: TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            YoutubePlayer(
                              controller: _youtubeController!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                              progressColors: const ProgressBarColors(
                                playedColor: Colors.red,
                                handleColor: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Detalles de la película
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: movie.voteAverage / 2,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 24.0,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${movie.voteAverage.toStringAsFixed(1)}',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Text(
                          "Lanzamiento: ${movie.releaseDate}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          movie.overview,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),

                        const SizedBox(height: 25),
                        const Text(
                          "Actores",
                          style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),

                        FutureBuilder<List<Actor>>(
                          future: futureActors,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError || !snapshot.hasData) {
                              return const Text(
                                "No se pudieron cargar los actores.",
                                style: TextStyle(color: Colors.white),
                              );
                            }

                            final actors = snapshot.data!;
                            return SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: actors.length,
                                itemBuilder: (context, index) {
                                  final actor = actors[index];
                                  return Container(
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: actor.profilePath.isNotEmpty
                                              ? NetworkImage(actor.profilePath)
                                              : null,
                                          child: actor.profilePath.isEmpty
                                              ? const Icon(Icons.person, size: 40, color: Colors.white)
                                              : null,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          actor.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          actor.character,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 12, 
                                              color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}