part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnMovieDetailRequested extends MovieDetailEvent {
  final int movieId;

  OnMovieDetailRequested(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class OnMovieRecommendationsRequested extends MovieDetailEvent {
  final int movieId;

  OnMovieRecommendationsRequested(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class AddMovieToWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  AddMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieFromWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  RemoveMovieFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int movieId;

  LoadWatchlistStatus(this.movieId);

  @override
  List<Object> get props => [movieId];
}
