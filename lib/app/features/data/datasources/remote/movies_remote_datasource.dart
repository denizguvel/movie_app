import 'package:movie_app/app/common/config/config.dart';
import 'package:movie_app/app/features/data/models/movie/movie_list_response.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';
import 'package:movie_app/core/dio_manager/api_response_model.dart';
import 'package:movie_app/core/dio_manager/dio_manager.dart';

abstract class MoviesRemoteDatasource {
  Future<ApiResponseModel<MovieListResponse>> getMovieList({required int page});
  Future<ApiResponseModel<bool>> addFavorite({required String favoriteId});
  Future<ApiResponseModel<List<String>>> getFavoriteMovieIds();
  Future<ApiResponseModel<List<MovieModel>>> getFavoriteMovies();
}

class MoviesRemoteDatasourceImpl implements MoviesRemoteDatasource {
  final DioApiManager _apiManager = DioApiManager(baseUrl: Config.apiBaseUrl);

  @override
  Future<ApiResponseModel<MovieListResponse>> getMovieList({
    required int page,
  }) async {
    var apiResponseModel = await _apiManager.get(
      '/movie/list',
      queryParams: {'page': page},
      converter: (data) {
        return MovieListResponse.fromMap(data);
      },
    );
    if (!apiResponseModel.isSuccess) {}
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<bool>> addFavorite({
    required String favoriteId,
  }) async {
    var apiResponseModel = await _apiManager.post(
      '/movie/favorite/$favoriteId',
      converter: (data) {
        if (data['success'] == true) return true;
        if (data['data'] != null && data['data']['movie'] != null) return true;
        return false;
      },
    );
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<List<String>>> getFavoriteMovieIds() async {
    var apiResponseModel = await _apiManager.get(
      '/movie/favorites',
      converter: (data) {
        final movies = data['data'] as List<dynamic>? ?? [];
        return movies.map((e) => e['id'] as String).toList();
      },
    );
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<List<MovieModel>>> getFavoriteMovies() async {
    var apiResponseModel = await _apiManager.get(
      '/movie/favorites',
      converter: (data) {
        final movies = data['data'] as List<dynamic>? ?? [];
        return movies.map((e) => MovieModel.fromMap(e)).toList();
      },
    );
    return apiResponseModel;
  }
}
