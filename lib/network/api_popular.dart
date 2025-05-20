import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/model/actor_model.dart';
import 'package:flutter_application_1/model/video_model.dart';

class ApiPopular {
  final Dio _dio = Dio();
  static const String _apiKey = '5019e68de7bc112f4e4337a500b96c56';
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  
  // Método para obtener películas populares
  Future<List<PopularModel>> getPopularMovies() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'es-MX',
          'page': 1,
        },
      );
      
      final results = response.data['results'] as List;
      return results.map((movie) => PopularModel.fromMap(movie)).toList();
    } catch (e) {
      throw Exception('Error al obtener películas populares: ${e.toString()}');
    }
  }

  // Método para obtener el elenco de una película
  Future<List<ActorModel>> getMovieCast(int movieId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/$movieId/credits',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'es-MX',
        },
      );
      
      final cast = response.data['cast'] as List;
      return cast.map((actor) => ActorModel.fromMap(actor)).toList();
    } catch (e) {
      throw Exception('Error al obtener el elenco: ${e.toString()}');
    }
  }

  // Método para obtener videos/trailers de una película
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/$movieId/videos',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'es-MX',
        },
      );
      
      final videos = response.data['results'] as List;
      return videos.map((video) => VideoModel.fromMap(video)).toList();
    } catch (e) {
      throw Exception('Error al obtener videos: ${e.toString()}');
    }
  }

  // Método para obtener detalles adicionales de una película
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/$movieId',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'es-MX',
          'append_to_response': 'credits,videos',
        },
      );
      
      return response.data;
    } catch (e) {
      throw Exception('Error al obtener detalles: ${e.toString()}');
    }
  }

  // Método para marcar/desmarcar como favorito (requiere autenticación)
  Future<bool> toggleFavorite({
    required int movieId,
    required bool favorite,
    required String sessionId,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/account/{account_id}/favorite',
        data: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': favorite,
        },
        queryParameters: {
          'api_key': _apiKey,
          'session_id': sessionId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
          },
        ),
      );
      
      return response.data['success'] ?? false;
    } catch (e) {
      throw Exception('Error al actualizar favoritos: ${e.toString()}');
    }
  }

  // Método para obtener películas favoritas (requiere autenticación)
  Future<List<PopularModel>> getFavoriteMovies(String sessionId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/account/{account_id}/favorite/movies',
        queryParameters: {
          'api_key': _apiKey,
          'session_id': sessionId,
          'language': 'es-MX',
          'sort_by': 'created_at.desc',
        },
      );
      
      final results = response.data['results'] as List;
      return results.map((movie) => PopularModel.fromMap(movie)).toList();
    } catch (e) {
      throw Exception('Error al obtener favoritos: ${e.toString()}');
    }
  }

  // Método para buscar películas
  Future<List<PopularModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/search/movie',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'es-MX',
          'query': query,
          'page': 1,
          'include_adult': false,
        },
      );
      
      final results = response.data['results'] as List;
      return results.map((movie) => PopularModel.fromMap(movie)).toList();
    } catch (e) {
      throw Exception('Error al buscar películas: ${e.toString()}');
    }
  }
}