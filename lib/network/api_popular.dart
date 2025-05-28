import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/popular_model.dart';

class ApiPopular {

  final URL = 'https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1';

  Future<List<PopularModel>> getPopularMovies() async {  // ← Ahora sí retorna una lista
  final dio = Dio();
  final response = await dio.get(URL);
  final res = response.data['results'] as List;

  return res.map((movie) => PopularModel.fromMap(movie)).toList();
  
  }
}