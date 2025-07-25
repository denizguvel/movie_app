import 'package:movie_app/app/features/data/datasources/remote/movies_remote_datasource.dart';
import 'package:movie_app/app/features/data/models/movie/movie_list_response.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';
import 'package:movie_app/core/logger/app_logger.dart';
import 'package:movie_app/core/result/result.dart';

abstract class MoviesRepository {
  Future<DataResult<MovieListResponse>> getMovieList({required int page});
  Future<DataResult<bool>> addFavorite({required String favoriteId});
  Future<DataResult<List<String>>> getFavoriteMovieIds();
  Future<DataResult<List<MovieModel>>> getFavoriteMovies();
}

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDatasource _remoteDatasource;

  MoviesRepositoryImpl({
    required MoviesRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<DataResult<MovieListResponse>> getMovieList({required int page}) async {
    var apiResponseModel = await _remoteDatasource.getMovieList(page: page);
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
        "$runtimeType getMovieList() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}",
      );
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getMovieList() Null Data");
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    AppLogger.instance.log("$runtimeType getMovieList() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!);
  }

  @override
  Future<DataResult<bool>> addFavorite({required String favoriteId}) async {
    var apiResponseModel = await _remoteDatasource.addFavorite(favoriteId: favoriteId);
    if (!apiResponseModel.isSuccess) {
      return ErrorDataResult(message: apiResponseModel.error?.message ?? 'Favori eklenemedi');
    }
    return SuccessDataResult(data: apiResponseModel.data ?? false);
  }

  @override
  Future<DataResult<List<String>>> getFavoriteMovieIds() async {
    var apiResponseModel = await _remoteDatasource.getFavoriteMovieIds();
    if (!apiResponseModel.isSuccess) {
      return ErrorDataResult(message: apiResponseModel.error?.message ?? 'Favoriler alınamadı');
    }
    return SuccessDataResult(data: apiResponseModel.data ?? []);
  }

  @override
  Future<DataResult<List<MovieModel>>> getFavoriteMovies() async {
    var apiResponseModel = await _remoteDatasource.getFavoriteMovies();
    if (!apiResponseModel.isSuccess) {
      return ErrorDataResult(message: apiResponseModel.error?.message ?? 'Favori filmler alınamadı');
    }
    return SuccessDataResult(data: apiResponseModel.data ?? []);
  }
}
