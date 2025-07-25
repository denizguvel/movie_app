import 'movie_model.dart';

class MovieListResponse {
  final List<MovieModel> movies;
  final int totalPages;
  final int currentPage;

  const MovieListResponse({
    required this.movies,
    required this.totalPages,
    required this.currentPage,
  });

  factory MovieListResponse.fromMap(Map<String, dynamic> map) {
    final data = map['data'] ?? {};
    final moviesList = data['movies'];
    return MovieListResponse(
      movies: moviesList is List
          ? List<MovieModel>.from(moviesList.map((x) => MovieModel.fromMap(x)))
          : [],
      totalPages: data['totalPages'] is int ? data['totalPages'] : 0,
      currentPage: data['currentPage'] is int ? data['currentPage'] : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movies': movies.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'currentPage': currentPage,
    };
  }
} 