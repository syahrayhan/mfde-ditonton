import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:flutter/cupertino.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final SaveTvShowWatchlist saveTvShowWatchlist;
  final RemoveTvShowWatchlist removeTvShowWatchlist;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getTvWatchlistStatus,
    required this.saveTvShowWatchlist,
    required this.removeTvShowWatchlist,
  });

  late TvShowDetail _tvShowDetail;
  TvShowDetail get tvShow => _tvShowDetail;

  RequestState _tvShowState = RequestState.Empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _recommendations = [];
  List<TvShow> get recommendations => _recommendations;

  RequestState _recommendationsState = RequestState.Empty;
  RequestState get recommendationsState => _recommendationsState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvShowDetail(int tvShowId) async {
    _tvShowState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvShowDetail.execute(tvShowId);
    final recommendationResult =
        await getTvShowRecommendations.execute(tvShowId);
    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _tvShowState = RequestState.Loaded;
        _tvShowDetail = tvShow;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationsState = RequestState.Error;
            _message = failure.message;
          },
          (tvShows) {
            _recommendationsState = RequestState.Loaded;
            _recommendations = tvShows;
          },
        );
        _tvShowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addTvShowToWatchlist(TvShowDetail tvShowId) async {
    final result = await saveTvShowWatchlist.execute(tvShowId);

    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (success) async {
      _watchlistMessage = success;
    });
    await loadTvShowWatchlistStatus(tvShowId.id);
  }

  Future<void> removeTvShowFromWatchlist(TvShowDetail tvShowId) async {
    final result = await removeTvShowWatchlist.execute(tvShowId);

    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (success) async {
      _watchlistMessage = success;
    });

    await loadTvShowWatchlistStatus(tvShowId.id);
  }

  Future<void> loadTvShowWatchlistStatus(int id) async {
    final result = await getTvWatchlistStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
