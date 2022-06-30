import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockTvShowRemoteDataSource;

  setUp(() {
    mockTvShowRemoteDataSource = MockTvShowRemoteDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockTvShowRemoteDataSource,
    );
  });

  final tTvShowModel = TvShowModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2003-10-21",
    genreIds: [18],
    id: 1,
    name: "Name",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Origin Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 7.6,
    voteCount: 1,
  );

  final tTvShow = TvShow(
    backdropPath: "/path.jpg",
    firstAirDate: "2003-10-21",
    genreIds: [18],
    id: 1,
    name: "Name",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Origin Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 7.6,
    voteCount: 1,
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now TV Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getNowTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getNowTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getNowTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getNowTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('popular TV Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getPopularTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getPopularTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getPopularTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getPopularTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('top rated TV Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getTopRatedTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getTopRatedTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      verify(mockTvShowRemoteDataSource.getTopRatedTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get TV Show Recomendation', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvShowRecomendation(tId))
          .thenAnswer((_) async => tTvShowList);
      // act
      final result = await repository.getTvShowRecomendation(tId);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvShowList));
    });

    test(
        'should return server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvShowRecomendation(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecomendation(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvShowRecomendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvShowRecomendation(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecomendation(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvShowRecomendation(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('search TV Show', () {
    final tQuery = "naruto";

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTvShow(tQuery))
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      verify(mockTvShowRemoteDataSource.searchTvShow(tQuery));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      verify(mockTvShowRemoteDataSource.searchTvShow(tQuery));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('detail TV Show', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailModel(
      adult: false,
      backdropPath: "/path.jpg",
      episodeRunTime: [60, 90],
      firstAirDate: "2020-01-01",
      genres: [GenreModel(id: 1, name: "Action")],
      homepage: "https://www.google.com",
      id: 1,
      inProduction: true,
      languages: ["en"],
      lastAirDate: "2020-01-01",
      name: "name",
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "name",
      overview: "Overview",
      popularity: 7.5,
      posterPath: "/path.jpg",
      seasons: [
        SeasonModel(
          airDate: "2020-10-10",
          episodeCount: 1,
          id: 1,
          name: "Name",
          overview: "Overview",
          posterPath: "/path.jpg",
          seasonNumber: 1,
        )
      ],
      status: "status",
      tagline: "tagline",
      type: "scripted",
      voteAverage: 6.7,
      voteCount: 1,
    );

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });

    test(
        'should return server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
