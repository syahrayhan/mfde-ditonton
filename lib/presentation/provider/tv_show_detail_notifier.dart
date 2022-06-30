import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:flutter/cupertino.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
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
}
