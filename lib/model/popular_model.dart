class PopularModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularModel.fromMap(Map<String, dynamic> movie) {
    return PopularModel(
      backdropPath: 'https://image.tmdb.org/t/p/w500/${movie['backdrop_path']}' ??
          'https://toppng.com/uploads/preview/404-error-error-404-transparent-11563210406bsmsusbbzi.png',
      id: movie['id'],
      originalLanguage: movie['original_language'],
      originalTitle: movie['original_title'],
      overview: movie['overview'],
      popularity: movie['popularity'],
      posterPath: movie['poster_path'],
      releaseDate: movie['release_date'],
      title: movie['title'],
      voteAverage: movie['vote_average'].toDouble(),
      voteCount: movie['vote_count'],
    );
  }
}