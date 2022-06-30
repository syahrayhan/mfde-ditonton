// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc(
    GetMovieDetail getMovieDetail,
    GetMovieRecommendations getMovieRecommendations,
    GetWatchListStatus getWatchListStatus,
    RemoveWatchlist removeWatchlist,
    SaveWatchlist saveWatchlist,
  ) : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) {
      if (event is OnMovieDetailRequested) {
        onMovieDetailDataRequested(
          getMovieDetail,
          getMovieRecommendations,
          event.movieId,
        );
      } else if (event is AddMovieToWatchlist) {
        addMovieToWatchlist(saveWatchlist, event.movieDetail);
      } else if (event is RemoveMovieFromWatchlist) {
        removeMovieFromWatchlist(removeWatchlist, event.movieDetail);
      } else if (event is LoadWatchlistStatus) {
        loadWatchlistStatus(getWatchListStatus, event.movieId);
      }
    });
  }

  Future<void> onMovieDetailDataRequested(
    GetMovieDetail getMovieDetail,
    GetMovieRecommendations getMovieRecommendations,
    int id,
  ) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movie) {
        emit(MovieDetailLoading());
        recommendationResult.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
            emit(MovieDetailLoaded(movie));
          },
          (recommendations) {
            emit(MovieDetailLoading());
            emit(MovieDetailLoaded(movie, recommendations: recommendations));
          },
        );
      },
    );
  }

  Future<void> addMovieToWatchlist(
      SaveWatchlist saveWatchlist, MovieDetail movieDetail) async {
    emit(MovieDetailLoading());
    final result = await saveWatchlist.execute(movieDetail);
    result.fold(
      (failure) {
        emit(WatchlistStatusError(failure.message));
      },
      (success) {
        emit(WatchlistStatusSuccess(success));
      },
    );
  }

  Future<void> removeMovieFromWatchlist(
      RemoveWatchlist removeWatchlist, MovieDetail movieDetail) async {
    emit(MovieDetailLoading());
    final result = await removeWatchlist.execute(movieDetail);
    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (success) {
        emit(WatchlistStatusSuccess(success));
      },
    );
  }

  Future<void> loadWatchlistStatus(
    GetWatchListStatus getWatchListStatus,
    int id,
  ) async {
    final result = await getWatchListStatus.execute(id);
    emit(WatchlistStatusLoaded(result));
  }
}
