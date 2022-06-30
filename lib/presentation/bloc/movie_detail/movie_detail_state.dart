part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> recommendations;

  MovieDetailLoaded(this.movieDetail, {this.recommendations = const []});

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatusSuccess extends MovieDetailState {
  final String message;

  WatchlistStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatusError extends MovieDetailState {
  final String message;

  WatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatusLoaded extends MovieDetailState {
  final bool isAddedToWatchlist;

  WatchlistStatusLoaded(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
