import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShow])
void main() {
  late TvShowSearchNotifier provider;
  late MockSearchTvShow mockSearchTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShow = MockSearchTvShow();
    provider = TvShowSearchNotifier(searchTvShow: mockSearchTvShow)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShow = TvShow(
    originalName: "ori name",
    originalLanguage: "us",
    originCountry: ["CU"],
    name: 'name',
    firstAirDate: '2002-05-01',
    backdropPath: '/path.jpg',
    genreIds: [14, 28],
    id: 557,
    overview: 'Overview',
    popularity: 60.441,
    posterPath: '/path.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvShowList = <TvShow>[tTvShow];
  final tQuery = 'naruto';

  group('search tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShow.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShow.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should change state to error when data is gotten unsuccessfully',
        () async {
      // arrange
      when(mockSearchTvShow.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
