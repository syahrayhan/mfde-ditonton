import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: 'backdropPath',
    firstAirDate: "2003-10-21",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['CO', 'ID', 'US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1919.3,
    posterPath: 'posterPath',
    voteAverage: 1.3,
    voteCount: 2,
  );

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: "2003-10-21",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['CO', 'ID', 'US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1919.3,
    posterPath: 'posterPath',
    voteAverage: 1.3,
    voteCount: 2,
  );

  test('should be a subclass of Tv Serries', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
