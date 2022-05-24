import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save tv show watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvShowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove tv show watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable.id))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable.id))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get tv show detail by id', () {
    final tId = 1;

    test('should return tv show detail when get from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvShowWatchlistById(tId))
          .thenAnswer((_) async => testTvShowMap);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, testTvShowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowWatchlistById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of tv show from database', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowWatchlist())
          .thenAnswer((_) async => [testTvShowMap]);
      // act
      final result = await dataSource.getWatchlistTvShows();
      // assert
      expect(result, [testTvShowTable]);
    });
  });
}
