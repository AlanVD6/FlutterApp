import 'package:dio/dio.dart';

class Trailer {
  final String key;   
  final String name;  

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
      if ((video['site'] == 'YouTube' || video['site'] == 'youtube') &&
          (video['type'] == 'Trailer' || video['type'] == 'Teaser')) {
        return Trailer.fromMap(video);
      }
    }

    return null;
  } catch (e) {
    print('Error al obtener trailer: $e');
    return null;
  }
}

}