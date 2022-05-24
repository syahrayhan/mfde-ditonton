import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_now.dart';
import 'package:ditonton/domain/usecases/get_tv_show_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_show_top_rated.dart';
import 'package:flutter/cupertino.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _nowTvShows = <TvShow>[];
  List<TvShow> get nowTvShows => _nowTvShows;

  RequestState _nowTvShowsState = RequestState.Empty;
  RequestState get nowTvShowsState => _nowTvShowsState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;
  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getTvShowNow,
    required this.getTvShowPopular,
    required this.getTvShowTopRated,
  });

  final GetTvShowNow getTvShowNow;
  final GetTvShowPopular getTvShowPopular;
  final GetTvShowTopRated getTvShowTopRated;

  Future<void> fetchNowTvShows() async {
    _nowTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowNow.execute();
    result.fold(
      (failure) {
        _nowTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _nowTvShowsState = RequestState.Loaded;
        _nowTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowPopular.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowTopRated.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShowsState = RequestState.Loaded;
        _topRatedTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
