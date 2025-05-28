// utils/favorite_service.dart
import 'package:flutter_application_1/model/popular_model.dart';

class FavoriteService {
  static final List<PopularModel> _favorites = [];

  static List<PopularModel> get favorites => _favorites;

  static bool isFavorite(PopularModel movie) =>
      _favorites.any((element) => element.id == movie.id);

  static void toggleFavorite(PopularModel movie) {
    if (isFavorite(movie)) {
      _favorites.removeWhere((element) => element.id == movie.id);
    } else {
      _favorites.add(movie);
    }
  }
}
