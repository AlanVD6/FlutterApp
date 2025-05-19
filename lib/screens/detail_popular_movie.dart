
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';

class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  late PopularModel popular;
  late YoutubePlayerController _youtubeController;
  String videoKey = '';
  List<dynamic> castList = [];
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
    _loadTrailerAndCast();
  }

  Future<void> _loadTrailerAndCast() async {
    final dio = Dio();
    final apiKey = '5019e68de7bc112f4e4337a500b96c56';

    try {
      // Trailer
      final trailerResponse = await dio.get(
        'https://api.themoviedb.org/3/movie/${popular.id}/videos?api_key=$apiKey&language=es-MX',
      );
      final videos = trailerResponse.data['results'] as List;
      final trailer = videos.firstWhere(
        (v) => v['type'] == 'Trailer' && v['site'] == 'YouTube',
        orElse: () => null,
      );
      if (trailer != null) {
        videoKey = trailer['key'];
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoKey,
          flags: YoutubePlayerFlags(autoPlay: false),
        );
      }

      // Cast
      final castResponse = await dio.get(
        'https://api.themoviedb.org/3/movie/${popular.id}/credits?api_key=$apiKey&language=es-MX',
      );
      castList = castResponse.data['cast'];
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    if (_youtubeController != null) {
      _youtubeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              // Aquí puedes guardar en base de datos local si deseas
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo difuminado
          Positioned.fill(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${popular.posterPath}',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // Contenido
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 100, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: popular.id,
                    child: Text(
                      popular.title,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildRating(popular.voteAverage),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    popular.overview,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                if (videoKey.isNotEmpty)
                  YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Actores',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                _buildCastList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRating(double rating) {
    int stars = (rating / 2).round();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        );
      }),
    );
  }

  Widget _buildCastList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          final actor = castList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    actor['profile_path'] != null
                        ? 'https://image.tmdb.org/t/p/w185${actor['profile_path']}'
                        : 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 70,
                  child: Text(
                    actor['name'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
