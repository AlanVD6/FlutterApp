import 'package:dio/dio.dart';

class Actor {
  final String name;         // Nombre del actor
  final String character;    // Personaje que interpreta
  final String profilePath;  // URL de su imagen de perfil

  Actor({
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      name: map['name'] ?? '',
      character: map['character'] ?? '',
      profilePath: map['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w200${map['profile_path']}'
          : '',
    );
  }
}

class ApiActors {
  final Dio dio = Dio();
  final String _apiKey = '5019e68de7bc112f4e4337a500b96c56';

  Future<List<Actor>> fetchActors(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$_apiKey&language=es-MX';

    try {
      final response = await dio.get(url);
      final List castList = response.data['cast'];

      return castList.map((actorData) => Actor.fromMap(actorData)).toList();
    } catch (e) {
      print('Error al obtener actores: $e');
      return [];
    }
  }
}
