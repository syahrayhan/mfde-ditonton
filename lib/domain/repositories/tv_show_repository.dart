import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowTvShow();
  Future<Either<Failure, List<TvShow>>> getPopularTvShow();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShow();
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecomendation(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShow(String query);
  Future<Either<Failure, String>> saveTvShowWatchlist(TvShowDetail tvShow);
  Future<Either<Failure, String>> removeTvShowWatchlist(TvShowDetail tvShow);
  Future<bool> isAddedToTvShowWatchlist(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowWatchlist();
}
