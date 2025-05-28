import 'package:dio/dio.dart';

class Actor {
  final String name;
  final String character;
  final String profilePath;

  Actor({
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      name: map['name'],
      character: map['character'] ?? '',
      profilePath: map['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w200${map['profile_path']}'
          : '',
    );
  }
}

class ApiActors {
  final dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3/movie';

  Future<List<Actor>> fetchActors(int movieId) async {
    final response = await dio.get(
        '$baseUrl/$movieId/credits?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX');
    final data = response.data['cast'] as List;
    return data.map((e) => Actor.fromMap(e)).toList();
  }
}
