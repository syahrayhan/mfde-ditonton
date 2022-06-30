import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../provider/movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist
])
void main() {
  MockGetMovieDetail getMovieDetail;
  MockGetMovieRecommendations getMovieRecommendations;
  MockGetWatchListStatus getWatchListStatus;
  MockRemoveWatchlist removeWatchlist;
  MockSaveWatchlist saveWatchlist;
  MovieDetailBloc bloc;

  setUp(() {
    getMovieDetail = MockGetMovieDetail();
    getMovieRecommendations = MockGetMovieRecommendations();
    getWatchListStatus = MockGetWatchListStatus();
    removeWatchlist = MockRemoveWatchlist();
    saveWatchlist = MockSaveWatchlist();
    bloc = MovieDetailBloc(
      getMovieRecommendations,
      getMovieDetail,
      removeWatchlist,
      saveWatchlist,
      getWatchListStatus,
    );
  });
}
