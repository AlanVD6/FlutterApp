import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/review_model.dart';


class ApiReviews {
  final Dio dio = Dio();
  final String _apiKey = '5019e68de7bc112f4e4337a500b96c56';

  Future<List<Review>> fetchReviews(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=$_apiKey&language=es-MX';

    try {
      final response = await dio.get(url);
      final List results = response.data['results'];
      return results.map((r) => Review.fromMap(r)).toList();
    } catch (e) {
      print("Error al obtener comentarios: \$e");
      return [];
    }
  }
}

