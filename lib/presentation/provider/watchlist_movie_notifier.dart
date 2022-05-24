import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_show.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  var _watchListTvShow = <TvShow>[];
  List<TvShow> get watchListTvShow => _watchListTvShow;

  var _watchlistTvShowState = RequestState.Empty;
  RequestState get watchlistTvShowState => _watchlistTvShowState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({
    required this.getWatchlistMovies,
    required this.getWatchlistTvShow,
  });

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvShow getWatchlistTvShow;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvShow() async {
    _watchlistTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShow.execute();
    result.fold(
      (failure) {
        _watchlistTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _watchlistTvShowState = RequestState.Loaded;
        _watchListTvShow = tvShowData;
        notifyListeners();
      },
    );
  }
}
