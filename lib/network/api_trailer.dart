import 'package:dio/dio.dart';

class Trailer {
  final String key;   // ID de video en YouTube
  final String name;  // Nombre del tráiler

  Trailer({required this.key, required this.name});

  factory Trailer.fromMap(Map<String, dynamic> map) {
    return Trailer(
      key: map['key'],
      name: map['name'],
    );
  }
}

class ApiTrailer {
  final dio = Dio();
  final String _apiKey = '5019e68de7bc112f4e4337a500b96c56';

  Future<Trailer?> getTrailer(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$_apiKey&language=es-MX';

    try {
      final response = await dio.get(url);
      final List videos = response.data['results'];

      for (var video in videos) {
        if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
          return Trailer.fromMap(video);
        }
      }

      // Si no se encuentra tráiler, retorna null
      return null;
    } catch (e) {
      print('Error al obtener el tráiler: $e');
      return null;
    }
  }
}
