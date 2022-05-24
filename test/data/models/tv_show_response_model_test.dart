import 'dart:convert';

import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: '/path.jpg',
    firstAirDate: "2003-10-21",
    genreIds: [18],
    id: 1,
    name: "Name",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Origin Name",
    overview: "Overview",
    popularity: 1.1,
    posterPath: "/path.jpg",
    voteAverage: 7.6,
    voteCount: 1,
  );
  final tTvShowResponseModel =
      TvShowResponse(tvShowList: <TvShowModel>[tTvShowModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_show.json'));
      //act
      final result = TvShowResponse.fromJson(jsonMap);
      //assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2003-10-21",
            "genre_ids": [18],
            "id": 1,
            "name": "Name",
            "origin_country": ["CO"],
            "original_language": "es",
            "original_name": "Origin Name",
            "overview": "Overview",
            "popularity": 1.1,
            "poster_path": "/path.jpg",
            "vote_average": 7.6,
            "vote_count": 1
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
